//
//  BloggersViewController.swift
//  blog
//
//  Created by test1 on 4/10/20.
//  Copyright © 2020 test1. All rights reserved.
//

import UIKit

class BloggersViewController: UIViewController {
     var blogger: [Blog] = []
    var privateList = [String]()
    var fetchMore = false
    //let totalItems = 100 // server does not provide totalItems
    static var current_page = 2
    @IBOutlet weak var SearchBar: UISearchBar!
    var searchBlogger : [search] = []
    
    @IBOutlet weak var tv: UITableView!
    @IBOutlet weak var Loading: UIActivityIndicatorView!
    
    
    
    override func viewDidLoad() {
        Get.NightMode(from: self)
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
                
                BloggersDataServer.instance.fetchAllBloggers(API_URL3: "https://blog-api.turathalanbiaa.com/api/userpagination") { [weak self] (response) in
                                    if self == nil {return}
                                    if response.success {
                                       self!.blogger.append(contentsOf: (response.data!.data)!)
                                       // self!.blogger =  (response.data!.data)!
                                        self!.tv.reloadData()
                                       self!.Loading.isHidden = true
                                       self!.Loading.stopAnimating()
                                      // self!.loadItemsNow()
                                        
                                    }else {
                                        let alert = UIAlertController(title: "خطأ", message: "فشل في التحميل, تحقق من الاتصال بالانترنت", preferredStyle: .alert)
                                        alert.addAction(UIAlertAction(title: "تم", style: .cancel, handler: nil))
                                        self!.present(alert, animated: true)
                                    }
                                }
                
    }
    
      func loadMoreItems(){
        self.Loading.isHidden = false
        self.Loading.startAnimating()
        BloggersDataServer.instance.fetchAllBloggers(API_URL3: "https://blog-api.turathalanbiaa.com/api/userpagination"+"?page=" + "\( BloggersViewController.current_page)" ) { [weak self] (response) in
                                                 if self == nil {return}
                                                 if response.success {
                                                    self!.blogger.append(contentsOf: (response.data!.data)!)
                                                    // self!.blogger =  (response.data!.data)!
                                                    self!.fetchMore = false
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

    
    func loadSearhResult(searchText : String) {
        
        self.Loading.isHidden = false
        self.Loading.startAnimating()
            let json: [String: Any] = ["data": searchText]
           SearchDataServer.instance.Searching(json: json) { [weak self] (response) in
                               if self == nil {return}
                               if response.success {
                               self!.blogger = (response.data!.data)!
                               //self!.blogger as! [search] = self!.searchBlogger
                                 self!.tv.reloadData()
                                  self!.Loading.isHidden = true
                                  self!.Loading.stopAnimating()
                                   print("loading")
                               }else {
                                   let alert = UIAlertController(title: "خطأ", message: "فشل في التحميل, تحقق من الاتصال بالانترنت", preferredStyle: .alert)
                                   alert.addAction(UIAlertAction(title: "تم", style: .cancel, handler: nil))
                                   self!.present(alert, animated: true)
                               }
                           }
    }

  

     func viewDidLayoutSubviews(view : UIView) {
                    Utilities.TitlefadedColor(view)
               }

}




// Extention for Bloggers tableview
extension BloggersViewController:UITableViewDataSource,UITableViewDelegate{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  blogger.count
    }
    
    
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! BloggersTableViewCell
        cell.UserName.text = blogger[indexPath.row].name
        let score1 = blogger[indexPath.row].points ?? 0
        cell.Score.text = "النقاط:\(score1)"
        cell.PrsImg.image = Get.Picture(from:(blogger[indexPath.row].picture)!) ?? UIImage(named:"PersonalImg")
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
        Share.shared.userId =  blogger[indexPath.row].id
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offSetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offSetY > contentHeight - scrollView.frame.height{
              if !fetchMore
                      {
                          fetchMore = true
                      print("this is the last cell")
                        loadMoreItems()
                        BloggersViewController.current_page = BloggersViewController.current_page + 1
                        
                      }
        }
    }
    

}
//MARK:-  Search for blogers
extension BloggersViewController : UISearchBarDelegate
{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty == false
        {
              loadSearhResult(searchText: searchText)
        }
     //   tv.reloadData()
       
    }
}

