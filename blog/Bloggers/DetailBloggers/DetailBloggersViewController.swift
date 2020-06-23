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
    static var current_page = 2
    var profiles: [Profile] = []
    var fetchMore = false
    var nob = 0
    @IBOutlet weak var tv: UITableView!
    override func viewDidLoad() {
       
        Get.NightMode(from: self)
        super.viewDidLoad()
        self.Loading.isHidden = false
        self.Loading.startAnimating()
        PersonalImg.layer.cornerRadius = PersonalImg.frame.size.width / 2
        PersonalImg.clipsToBounds = true
        noOfBlogs.isHidden = true
        userName.text = "جار تحميل الصفحة"
        
        
       
        
        tv.delegate = self
        tv.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
                       Utilities.fadedColor(BackgorundView)
                  }

   override func didReceiveMemoryWarning() {
                  super.didReceiveMemoryWarning()
              }
           
           override func viewWillAppear(_ animated: Bool) {
               super.viewWillAppear(true)
            
              let json: [String: Any] = ["user_id":Share.shared.userId as Any]
            ProfiletDataServer.instance.fetchAllProfile(API_URL7:"https://blog-api.turathalanbiaa.com/api/PosttPaginationByUserId" ,json:json ) { [weak self] (response) in
                             if self == nil {return}
                             if response.success {
                              self!.profiles = (response.data!.data)!
                                
                                 self!.tv.reloadData()
                                self!.Loading.isHidden = true
                                self!.Loading.stopAnimating()
                                if response.data!.total == 0 {
                                    self!.userName.text = " لا توجد اي تدوينة"
                                }
                                
                                
                                self!.nob = response.data!.total ?? 0
                                self!.noOfBlogs.text = "عدد التدوينات: \(self!.nob) "
                                
                             }else {
                                 let alert = UIAlertController(title: "خطأ", message: "فشل في التحميل, تحقق من الاتصال بالانترنت", preferredStyle: .alert)
                                 alert.addAction(UIAlertAction(title: "تم", style: .cancel, handler: nil))
                                 self!.present(alert, animated: true)
                                self?.dismiss(animated: true, completion: nil)
                             }
                         }
                     }

    //MARK:- Load more Items for pagination Function
       func loadMoreItems(){
           self.Loading.isHidden = false
                   self.Loading.startAnimating()
                            let json: [String: Any] = ["user_id": Share.shared.userId as Any]
           ProfiletDataServer.instance.fetchAllProfile(API_URL7 : "https://blog-api.turathalanbiaa.com/api/PosttPaginationByUserId" + "?page=" + "\( DetailBloggersViewController.current_page)" , json:json ) { [weak self]
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
                                                                        self?.Loading.isHidden = true
                                                                        self?.Loading.stopAnimating()
                                                                     }
                                                                 }
                  }
    
    
    @IBAction func BlockUser(_ sender: Any) {
        
        let alert = UIAlertController(title: "تنبيه !", message: "هل تريد حظر المستخدم ؟", preferredStyle: UIAlertController.Style.alert)
        
      alert.addAction(UIAlertAction(title: "نعم", style: .default, handler: { (action: UIAlertAction!) in
              print("Handle Ok logic here")
        }))

        alert.addAction(UIAlertAction(title: "الغاء", style: .cancel, handler: { (action: UIAlertAction!) in
              print("Handle Cancel Logic here")
        }))

        present(alert, animated: true, completion: nil)
        
        
    }
    
    
    
    
    @IBAction func BookMarkTapped(_ sender: Any) {
        let alert = UIAlertController(title: "عذرا", message: "هذة الخاصية غير متوفرة حاليا ..سيتم تفعيل هذه الخاصية في النسخة القادمة", preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: "تم", style: .cancel, handler: nil))
               self.present(alert, animated: true)
    }
    
  }

  extension DetailBloggersViewController: UITableViewDataSource, UITableViewDelegate {

     public func numberOfSections(in tableView: UITableView) -> Int {
         return 1
     }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
         return profiles.count
     }

    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DetaledBlogersTableViewCell
        //change according to settings
                  let FZ = UserDefaults.standard.object(forKey: "FontSizeDefault") as? CGFloat //CGFloat(Share.shared.fontSize ?? 17)
                      cell.Content.font = UIFont.italicSystemFont(ofSize: FZ ?? 13)
                  let FT =  UserDefaults.standard.object(forKey:"FontTypeDefault") as? String
                      cell.Content.font = UIFont(name: FT ?? "Lateef", size: FZ ?? 13)
                      cell.title.font = UIFont(name: FT ?? "Lateef", size: 30)
                      
            
            
            
            PersonalImg.image = Get.Picture(from:(profiles[indexPath.row].user?.picture)!) ?? UIImage(named:"PersonalImg")
            
            userName.text = profiles[indexPath.row].user?.name
            noOfBlogs.isHidden = false
       //MARK:- show only accpeted (valid) blogs
       if profiles[indexPath.row].status != 0 {
       // noOfBlogs.text = (noOfBlogs!.text) as Int? - 1
    cell.title.text = profiles[indexPath.row].title
     cell.Content.text = profiles[indexPath.row].content
        
        
         //  cell.date.setTitle(profiles[indexPath.row].createdAt, for: .normal)
           cell.tags.setTitle(profiles[indexPath.row].tags, for: .normal)

        let dateFormatterGet = DateFormatter()  //
                      dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
                      let dateFormatterPrint = DateFormatter()
                      dateFormatterPrint.dateFormat = "MMM"// dd,yyyy"
                      if let date = dateFormatterGet.date(from: String(profiles[indexPath.row].createdAt ?? "00-00-0000 00 00"))  {
                        cell.date.setTitle(dateFormatterPrint.string(from: Date() - date.distance(to: Date())), for: .normal)//(from: date)
                      }
        
          let views = profiles[indexPath.row].views ?? 0
        cell.Views.setTitle("\(views)", for: .normal)
    
     let  cmd = profiles[indexPath.row].cmdCount ?? 0
        cell.comment.setTitle("\(cmd)", for: .normal)
              
        
       // cell.date.titleLabel?.adjustsFontSizeToFitWidth = true
        cell.Views.titleLabel?.adjustsFontSizeToFitWidth = true
        cell.tags.titleLabel?.adjustsFontSizeToFitWidth = true
        cell.category.setTitle(profiles[indexPath.row].category?.name ,for: .normal)
        cell.category.titleLabel?.adjustsFontSizeToFitWidth = true
        cell.index = indexPath
        cell.cellDelegate = self as! ButtonIsClicked // as! CommentIsClicked
        Utilities.styleHollowButton(cell.category)
       }else{
        cell.isHidden = true
        }
         return cell
        
     }


     func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
         return UIView()
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

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
             let offSetY = scrollView.contentOffset.y
             let contentHeight = scrollView.contentSize.height
             
             if offSetY > contentHeight - scrollView.frame.height{
                   if !fetchMore
                           {
                               fetchMore = true
                           print("this is the last cell")
                             loadMoreItems()
                             DetailBloggersViewController.current_page = DetailBloggersViewController.current_page + 1
                             
                           }
             }
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
    
    //send to category to filter blog by cat
    let catId = DataService.instance.categories[index].id ?? 0
          Share.shared.categoryId = catId
          Share.shared.sortby = 1
          Share.shared.FromCtegoryVC = "yes"
}
}
