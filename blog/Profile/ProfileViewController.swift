//
//  ProfileViewController.swift
//  blog
//
//  Created by turath alanbiaa on 4/28/20.
//  Copyright © 2020 test1. All rights reserved.


import UIKit

class ProfileViewController: UIViewController {
    
  var User_id = UserDefaults.standard.object(forKey: "loggesUserID")
 // var loginFlag = UserDefaults.standard.set("yes", forKey: "LoginFlag")
    
    
    @IBOutlet weak var Loading: UIActivityIndicatorView!
    @IBOutlet weak var noOfBlogs: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var BackGroudView: UIView!
    var nob = 0
    var profiles: [Profile] = []
    @IBOutlet weak var tv: UITableView!
    override func viewDidLoad() {
        Get.NightMode(from: self)
        super.viewDidLoad()
        tv.delegate = self
        tv.dataSource = self
        self.Loading.isHidden = false
        self.Loading.startAnimating()
        noOfBlogs.isHidden = true
        
       Utilities.fadedColor(BackGroudView)
    }
    

 
   override func didReceiveMemoryWarning() {
                super.didReceiveMemoryWarning()
            }
         
         override func viewWillAppear(_ animated: Bool) {
             super.viewWillAppear(true)
          
            let json: [String: Any] = ["user_id":User_id]
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

  
    
    @IBAction func deletePostTapped(_ sender: Any) {
        self.Loading.isHidden = false
              self.Loading.startAnimating()
         let json: [String: Any] = ["id":Share.shared.PostId as Any ]
        DeletePostDataServer.instance.Delete(json:json ) { [weak self] (response) in
                                  if self == nil {return}
                                   if response.success {
                                     if let user = response.data {
                                        if(user.message == "DONE")
                                      {
                                        self!.Loading.isHidden = true
                                                                   self!.Loading.stopAnimating()
                                        let alert = UIAlertController(title: "خطأ", message: "DELTED", preferredStyle: .alert)
                                                                          alert.addAction(UIAlertAction(title: "تم", style: .cancel, handler: nil))
                                                                          self!.present(alert, animated: true)
                                        self!.tv.reloadData()
                                    }
                                  }else {
                                      let alert = UIAlertController(title: "خطأ", message: "فشل في التحميل, تحقق من الاتصال بالانترنت", preferredStyle: .alert)
                                      alert.addAction(UIAlertAction(title: "تم", style: .cancel, handler: nil))
                                      self!.present(alert, animated: true)
                                  }
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
    if profiles.count == 0 {
          userName.text = "لا توجد لديك اي مدونات في حسابك"
    }else{
              userName.text = profiles[indexPath.row].user?.name
        }
    
  //change according to settings
               let FZ = UserDefaults.standard.object(forKey: "FontSizeDefault") as? CGFloat //CGFloat(Share.shared.fontSize ?? 17)
                   cell.Content.font = UIFont.italicSystemFont(ofSize: FZ ?? 13)
               let FT =  UserDefaults.standard.object(forKey:"FontTypeDefault") as? String
                   cell.Content.font = UIFont(name: FT ?? "Lateef", size: FZ ?? 13)
                   cell.Title.font = UIFont(name: FT ?? "Lateef", size: 30)
                   
    
    
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
    //delete post
    Share.shared.PostId = profiles[index].id
    // edit post
    Share.shared.title = profiles[index].title
    Share.shared.content = profiles[index].content
    Share.shared.PostId = profiles[index].id
    Share.shared.cat = profiles[index].category?.name
    Share.shared.image = profiles[index].image
    Share.shared.tag = profiles[index].tags
    Share.shared.updatePost = 1
    //comment section
    let x = profiles[index].id ?? 0
           Share.shared.PostId = x
          // sending data to the view section
           Share.shared.Blogscontent = profiles[index].content
           Share.shared.Blogsusername = profiles[index].user?.name
       }
   }
