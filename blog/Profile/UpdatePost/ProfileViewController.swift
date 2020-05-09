//
//  ProfileViewController.swift
//  blog
//
//  Created by turath alanbiaa on 4/28/20.
//  Copyright © 2020 test1. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var Loading: UIActivityIndicatorView!
    @IBOutlet weak var noOfBlogs: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var BackGroudView: UIView!
    var nob = 0
    var profiles: [Profile] = []
    @IBOutlet weak var tv: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tv.delegate = self
        tv.dataSource = self
        self.Loading.isHidden = false
        self.Loading.startAnimating()
       Utilities.fadedColor(BackGroudView)
    }
    

 
   override func didReceiveMemoryWarning() {
                super.didReceiveMemoryWarning()
            }
         
         override func viewWillAppear(_ animated: Bool) {
             super.viewWillAppear(true)
          
            let json: [String: Any] = ["user_id":691311583402731]//Share.shared.userId as Any]//
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

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {

   public func numberOfSections(in tableView: UITableView) -> Int {
       return 1
   }

   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       print(profiles.count)
       return profiles.count
   }

   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProfileTableViewCell
    noOfBlogs.text = "عدد التدوينات: \(String(profiles.count)) "
    userName.text = profiles[indexPath.row].user?.name
   cell.Title.text = profiles[indexPath.row].title
   cell.Content.text = profiles[indexPath.row].content
    cell.Date.titleLabel?.text = profiles[indexPath.row].createdAt
    cell.catBtn.titleLabel?.text = profiles[indexPath.row].tags
    
    let views = profiles[indexPath.row].views ?? 0
    cell.View.titleLabel?.text = "\(views)"
    let  cmd = profiles[indexPath.row].cmdCount ?? 0
    cell.noOfCmnt.titleLabel?.text = "\(cmd)"
            
    cell.Date.titleLabel?.adjustsFontSizeToFitWidth = true
    cell.View.titleLabel?.adjustsFontSizeToFitWidth = true
    cell.catBtn.titleLabel?.adjustsFontSizeToFitWidth = true
    
    
    cell.index = indexPath
    cell.cellDelegate = self //as! EditPost
    
       return cell
   }


   func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
       return UIView()
   }

   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 500
   }

        
        
}


extension ProfileViewController : EditPost{
   func onClickCell(index: Int) {
   // Share.shared.postId
 
       }
   }
