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
    
    
    @IBOutlet weak var PersonalImg: UIImageView!
    @IBOutlet weak var Loading: UIActivityIndicatorView!
    @IBOutlet weak var noOfBlogs: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var BackGroudView: UIView!
    var blogIndex :Int!
    var fetchMore = false
    var nob = 0
    var profiles: [Profile] = []
    static var current_page = 2
    @IBOutlet weak var tv: UITableView!
    override func viewDidLoad() {
        
        Get.NightMode(from: self)
        super.viewDidLoad()
        tv.delegate = self
        tv.dataSource = self
        self.Loading.isHidden = false
        self.Loading.startAnimating()
        noOfBlogs.isHidden = true
        
        PersonalImg.layer.cornerRadius = PersonalImg.frame.size.width / 2
        PersonalImg.clipsToBounds = true
        
    
    }
    
    
    
 
    
    override func viewDidLayoutSubviews() {
                 Utilities.fadedColor(BackGroudView)
            }

 
   override func didReceiveMemoryWarning() {
                super.didReceiveMemoryWarning()
            }
         
         override func viewWillAppear(_ animated: Bool) {
             super.viewWillAppear(true)
          
            let json: [String: Any] = ["user_id": User_id]
            ProfiletDataServer.instance.fetchAllProfile(API_URL7 : "https://blog-api.turathalanbiaa.com/api/PosttPaginationByUserId" , json:json ) { [weak self] (response) in
                           if self == nil {return}
                           if response.success {
                            
                            if response.data!.total == 0 {
                                self!.userName.text =  "لا توجد لديك اي مدونات في حسابك"
                            }
                            
                          //  let  nob = response.data!.total ?? 0
                           // self!.noOfBlogs.text = "عدد التدوينات: \(nob) "
                            
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
                                        let alert = UIAlertController(title: "تم الحذف", message: "تمت عملية حذف المدونة بنجاح", preferredStyle: .alert)
                                                                          alert.addAction(UIAlertAction(title: "تم", style: .cancel, handler: nil))
                                                                          self!.present(alert, animated: true)
                                        //MARK:- deleting the row
                                        self!.tv.beginUpdates()
                                        let indexPath = IndexPath(row: self!.blogIndex, section: 0)
                                        self!.tv.deleteRows(at: [indexPath], with: .automatic)
                                        self!.tv.endUpdates()
                                        
                                        
                                        self!.tv.reloadData()
                                        } else if(user.message == "NOT FOUND'"){
                                            let alert = UIAlertController(title: "خطأ", message: "فشل في التحميل, تحقق من الاتصال بالانترنت", preferredStyle: .alert)
                                            alert.addAction(UIAlertAction(title: "تم", style: .cancel, handler: nil))
                                            self!.present(alert, animated: true)
                                        }
                                  }else {
                                      let alert = UIAlertController(title: "خطأ", message: "فشل في التحميل, تحقق من الاتصال بالانترنت", preferredStyle: .alert)
                                      alert.addAction(UIAlertAction(title: "تم", style: .cancel, handler: nil))
                                      self!.present(alert, animated: true)
                                  }
                              }
    }
    }
    
    @IBAction func editPost(_ sender: Any) {
         Share.shared.updatePost = 1
    }
    @IBAction func BookMarkTapped(_ sender: Any) {
        let alert = UIAlertController(title: "عذرا", message: "هذة الخاصية غير متوفرة حاليا ..سيتم تفعيل هذه الخاصية في النسخة القادمة", preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: "تم", style: .cancel, handler: nil))
               self.present(alert, animated: true)
    }
    

     //MARK:- Load more Items for pagination Function
    func loadMoreItems(){
        self.Loading.isHidden = false
                self.Loading.startAnimating()
                         let json: [String: Any] = ["user_id": User_id]
        ProfiletDataServer.instance.fetchAllProfile(API_URL7 : "https://blog-api.turathalanbiaa.com/api/PosttPaginationByUserId" + "?page=" + "\( ProfileViewController.current_page)" , json:json ) { [weak self]
          (response) in
                                                                  if self == nil {return}
                                                                  if response.success {
                                                                    
                                                                 
                                                                      self!.Loading.isHidden = true
                                                                       self!.Loading.stopAnimating()
                                                                    self!.profiles.append(contentsOf: (response.data!.data)!)
                                                                 self!.fetchMore = false
                                                                      self!.tv.reloadData()

                                                                  }else {
                                                                      let alert = UIAlertController(title: "خطأ", message: "فشل في التحميل, تحقق من الاتصال بالانترنت", preferredStyle: .alert)
                                                                      alert.addAction(UIAlertAction(title: "تم", style: .cancel, handler: nil))
                                                                      self!.present(alert, animated: true)
                                                                      self!.viewDidLoad()
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
                   
    
    let dateFormatterGet = DateFormatter()  //
                         dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
                         let dateFormatterPrint = DateFormatter()
                         dateFormatterPrint.dateFormat = "MMM"// dd,yyyy"
                         if let date = dateFormatterGet.date(from: String(profiles[indexPath.row].createdAt ?? "00-00-0000 00 00"))  {
                          // cell.Date.titleLabel?.text = dateFormatterPrint.string(from: Date() - date.distance(to: Date()))
                           cell.Date.setTitle(dateFormatterPrint.string(from: Date() - date.distance(to: Date())),for: .normal)
                         }
    
    if profiles[indexPath.row].status == 0 {
        cell.vaildSign.setImage(UIImage(systemName: "exclamationmark.octagon.fill"), for: .normal )
        cell.vaildSign.tintColor = UIColor.red
    }else{
        cell.vaildSign.setImage(UIImage(systemName: "checkmark.seal.fill"), for: .normal )
          cell.vaildSign.tintColor = UIColor(red: 82/255.0, green: 123/255.0, blue: 79/255.0, alpha: 1.0)
    }
  
   PersonalImg.image = Get.Picture(from:(profiles[indexPath.row].user?.picture)!) ?? UIImage(named:"PersonalImg")
    
   cell.Title.text = profiles[indexPath.row].title
   cell.Content.text = profiles[indexPath.row].content
    
    
    cell.catBtn.setTitle(profiles[indexPath.row].category?.name,for: .normal)
    
    let views = profiles[indexPath.row].views ?? 0
    cell.View.setTitle("\(views)" ,for: .normal)
    
    let  cmd = profiles[indexPath.row].cmdCount ?? 0
    cell.noOfCmnt.setTitle("\(cmd)" ,for: .normal)
    
    
    cell.Date.titleLabel?.adjustsFontSizeToFitWidth = true
    cell.View.titleLabel?.adjustsFontSizeToFitWidth = true
    cell.catBtn.titleLabel?.adjustsFontSizeToFitWidth = true
    
    
    cell.index = indexPath
    cell.cellDelegate = self //as! EditPost
    Utilities.styleHollowButton(cell.catBtn)
       return cell
   }


   func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
       return UIView()
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
                           ProfileViewController.current_page = ProfileViewController.current_page + 1
                           
                         }
           }
       }
    
    
    func tableView( _ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
             {
               
               let x = profiles[indexPath.row].id ?? 0
                  Share.shared.PostId = x
                 // sending data to the view section
                  Share.shared.Blogscontent = profiles[indexPath.row].content
                  Share.shared.Blogsusername = profiles[indexPath.row].user?.name
                  Share.shared.title = profiles[indexPath.row].title
               
               guard let menuViewController = self.storyboard?.instantiateViewController(identifier: "ViewBlog") else {return}
               self.present(menuViewController,animated: true)
       }
    
    
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 500
   }

        
        
}


extension ProfileViewController : EditPost{
   func onClickCell(index: Int) {
    //delete post
    blogIndex = index
    Share.shared.PostId = profiles[index].id
    // edit post
    Share.shared.title = profiles[index].title
    Share.shared.content = profiles[index].content
    Share.shared.PostId = profiles[index].id
    Share.shared.cat = profiles[index].category?.name
    Share.shared.image = profiles[index].image
    Share.shared.tag = profiles[index].tags
   // Share.shared.updatePost = 1
    //comment section
    let x = profiles[index].id ?? 0
           Share.shared.PostId = x
          // sending data to the view section
           Share.shared.Blogscontent = profiles[index].content
           Share.shared.Blogsusername = profiles[index].user?.name
       }
   }
