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
                        ProfiletDataServer.instance.fetchAllProfile(json:json ) { [weak self] (response) in
                             if self == nil {return}
                             if response.success {
                              self!.profiles = (response.data!.data)!
                                 self!.tv.reloadData()
                                self!.Loading.isHidden = true
                                self!.Loading.stopAnimating()
                                if response.data!.total == 0 {
                                    self!.userName.text = " لا توجد اي تدوينة"
                                }
                                
                             }else {
                                 let alert = UIAlertController(title: "خطأ", message: "فشل في التحميل, تحقق من الاتصال بالانترنت", preferredStyle: .alert)
                                 alert.addAction(UIAlertAction(title: "تم", style: .cancel, handler: nil))
                                 self!.present(alert, animated: true)
                                self?.dismiss(animated: true, completion: nil)
                             }
                         }
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
                  
        
      
             //  cell.PersonalImg.setImage(Get.Picture(from:(posts[indexPath.row].user?.picture)!) ?? UIImage(named:"PersonalImg"), for: .normal)
        PersonalImg.image = Get.Picture(from:(profiles[indexPath.row].user?.picture)!) ?? UIImage(named:"PersonalImg")
       // PersonalImg.layer.cornerRadius = PersonalImg.frame.size.width / 2
        //PersonalImg.clipsToBounds = true
        
        userName.text = profiles[indexPath.row].user?.name
        noOfBlogs.isHidden = false
      noOfBlogs.text = "عدد التدوينات: \(String(profiles.count)) "
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
    
    //send to category to filter blog by cat
    let catId = DataService.instance.categories[index].id ?? 0
          Share.shared.categoryId = catId
          Share.shared.sortby = 1
          Share.shared.FromCtegoryVC = "yes"
}
}
