//
//  DetailBloggersViewController.swift
//  blog
//
//  Created by turath alanbiaa on 5/8/20.
//  Copyright © 2020 test1. All rights reserved.
//

import UIKit

class DetailBloggersViewController: UIViewController {

    @IBOutlet weak var Loading: UIActivityIndicatorView!
    @IBOutlet weak var BackgorundView: UIView!
    @IBOutlet weak var PersonalImg: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var noOfBlogs: UILabel!
    var profiles: [Profile] = []
    @IBOutlet weak var tv: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.Loading.isHidden = false
        self.Loading.startAnimating()
        Utilities.fadedColor(BackgorundView)
        tv.delegate = self
        tv.dataSource = self
    }
    

   override func didReceiveMemoryWarning() {
                  super.didReceiveMemoryWarning()
              }
           
           override func viewWillAppear(_ animated: Bool) {
               super.viewWillAppear(true)
            
              let json: [String: Any] = ["user_id":Share.shared.userId as Any]
                        ProfiletDataServer.instance.fetchAllProfile(json:json ) { [weak self] (response) in
                             if self == nil {return}
                             if response.success {
                              self!.profiles = (response.data!.data)!
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

  extension DetailBloggersViewController: UITableViewDataSource, UITableViewDelegate {

     public func numberOfSections(in tableView: UITableView) -> Int {
         return 1
     }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         print(profiles.count)
         return profiles.count
     }

    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DetaledBlogersTableViewCell
        
        
        PersonalImg.image = UIImage(named: "PersonalImg")
              PersonalImg.layer.cornerRadius = PersonalImg.frame.size.width / 2
              PersonalImg.clipsToBounds = true
        
        userName.text = profiles[indexPath.row].user?.name
      noOfBlogs.text = "عدد التدوينات: \(String(profiles.count)) "
    cell.title.text = profiles[indexPath.row].title
     cell.Content.text = profiles[indexPath.row].content
        
        
         //  cell.date.setTitle(profiles[indexPath.row].createdAt, for: .normal)
           cell.tags.setTitle(profiles[indexPath.row].tags, for: .normal)

        
        
          let views = profiles[indexPath.row].views ?? 0
        cell.Views.setTitle("\(views)", for: .normal)
    
     let  cmd = profiles[indexPath.row].cmdCount ?? 0
        cell.comment.setTitle("\(cmd)", for: .normal)
              
        
       // cell.date.titleLabel?.adjustsFontSizeToFitWidth = true
        cell.Views.titleLabel?.adjustsFontSizeToFitWidth = true
        cell.tags.titleLabel?.adjustsFontSizeToFitWidth = true
        
        
        cell.index = indexPath
        cell.cellDelegate = self as! ButtonIsClicked // as! CommentIsClicked
        
         return cell
     }


     func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
         return UIView()
     }

     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return 300
     }
  }



extension DetailBloggersViewController: ButtonIsClicked{
func onClickCell(index: Int) {
    //sedning index to the comment section
    let x = profiles[index].id ?? 0
    Share.shared.PostId = x
   // sending data to the view section
    Share.shared.Blogscontent = profiles[index].content
    Share.shared.Blogsusername = profiles[index].user?.name
    Share.shared.title = profiles[index].title
}
}
