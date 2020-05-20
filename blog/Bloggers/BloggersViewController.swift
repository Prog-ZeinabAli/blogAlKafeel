//
//  BloggersViewController.swift
//  blog
//
//  Created by test1 on 4/10/20.
//  Copyright © 2020 test1. All rights reserved.
//

import UIKit

class BloggersViewController: UIViewController {
     var Blogger: [Blog] = []

    @IBOutlet weak var SearchBar: UISearchBar!
    var searchBlogger = [Blog]()
    
    @IBOutlet weak var tv: UITableView!
    @IBOutlet weak var Loading: UIActivityIndicatorView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.Loading.isHidden = false
        self.Loading.startAnimating()
        tv.delegate = self
        tv.dataSource = self
    }
    
       override func didReceiveMemoryWarning() {
                    super.didReceiveMemoryWarning()
                }
             
             override func viewWillAppear(_ animated: Bool) {
                 super.viewWillAppear(true)
               
           
                BloggersDataServer.instance.fetchAllBloggers { [weak self] (response) in
                     if self == nil {return}
                     if response.success {
                        self!.Blogger = (response.data!.data)!
                         self!.tv.reloadData()
                        self!.Loading.isHidden = true
                        self!.Loading.stopAnimating()
                     }else {
                         let alert = UIAlertController(title: "خطأ", message: "فشل في التحميل, تحقق من الاتصال بالانترنت", preferredStyle: .alert)
                         alert.addAction(UIAlertAction(title: "تم", style: .cancel, handler: nil))
                         self!.present(alert, animated: true)
                     }
                 }
             }


  

}




// Extention for Bloggers tableview
extension BloggersViewController:UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  Blogger.count
    }
    
    
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! BloggersTableViewCell
        cell.UserName.text = Blogger[indexPath.row].name
        let score1 = Blogger[indexPath.row].points ?? 0
        cell.Score.text = "النقاط:\(score1)"
   //     let Purl = URL(fileURLWithPath: Blogger[indexPath.row].picture!)
          //  cell.PrsImg = UIImage(purl)
        
        cell.PrsImg.image = UIImage(named: "PersonalImg")
        cell.PrsImg.layer.cornerRadius = cell.PrsImg.frame.size.width / 2
        cell.PrsImg.clipsToBounds = true
        
        
         Utilities.TitlefadedColor(cell.MainView)
          return cell
      }
      

    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    
    func tableView( _ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        Share.shared.userId =  Blogger[indexPath.row].id
    }
    
    
}

extension BloggersViewController : UISearchBarDelegate
{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("chnanged")
         let json: [String: Any] = ["data": searchText]
        SearchDataServer.instance.Search(json: json) { [weak self] (response) in
                            if self == nil {return}
                            if response.success {
                               self!.Blogger = (response.data!.data)!
                              self!.tv.reloadData()
                               self!.Loading.isHidden = true
                               self!.Loading.stopAnimating()
                                print("loading heioghdghd")
                            }else {
                                let alert = UIAlertController(title: "خطأ", message: "فشل في التحميل, تحقق من الاتصال بالانترنت", preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "تم", style: .cancel, handler: nil))
                                self!.present(alert, animated: true)
                            }
                        }
        
    }
}

