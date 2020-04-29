//
//  BlogViewController.swift
//  blog
//
//  Created by test1 on 4/6/20.
//  Copyright © 2020 test1. All rights reserved.
//

import UIKit

class BlogViewController: UIViewController {
    var cm = 0
    var posts: [Post] = []
    @IBOutlet var CommentPopUp: UIView!
    @IBOutlet var tv: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tv.delegate = self
        tv.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    
    override func didReceiveMemoryWarning() {
                 super.didReceiveMemoryWarning()
             }
          
          override func viewWillAppear(_ animated: Bool) {
              super.viewWillAppear(true)
            
        
              PostDataServer.instance.fetchAllPosts { [weak self] (response) in
                  if self == nil {return}
                  if response.success {
                    self!.posts = (response.data!.data)!
                      self!.tv.reloadData()
                  }else {
                      let alert = UIAlertController(title: "خطأ", message: "فشل في التحميل, تحقق من الاتصال بالانترنت", preferredStyle: .alert)
                      alert.addAction(UIAlertAction(title: "تم", style: .cancel, handler: nil))
                      self!.present(alert, animated: true)
                  }
              }
          }

    
    //comment Section
    @IBAction func CommentBtn(_ sender: Any) {
        print("post id num is \(cm)")
    }
            
   

}


extension BlogViewController: UITableViewDataSource, UITableViewDelegate {

       public func numberOfSections(in tableView: UITableView) -> Int {
           return 1
       }

       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           print(posts.count)
           return posts.count
       }

       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! BlogCardTableViewCell
        
        cm = posts[indexPath.row].id ?? 0
        Share.shared.PostId = cm
        
        cell.title.text = posts[indexPath.row].title
        
        cell.UserName.text = posts[indexPath.row].user?.name
                
        cell.content.text = posts[indexPath.row].content
        
        cell.Date.text = posts[indexPath.row].createdAt
        
        cell.PostImage.image = UIImage(named: "https://alkafeelblog.edu.turathalanbiaa.com/aqlam/image/1585684885.jpg")
    
        let views1 = posts[indexPath.row].views ?? 0
        cell.NumView.text = "\(views1)"
        
        
        let commentCount = posts[indexPath.row].cmdCount ?? 0
        cell.CommentCount.text = "\(commentCount)"
        
        cell.TagButton.setTitle(posts[indexPath.row].category?.name ,for: .normal)
        
        
        
        Utilities.styleHollowButton(cell.TagButton)
        Utilities.fadedColor(cell.TitleUiView)

    
        
       // cell.PersonalImg.image = UIImage(contentsOfFile: posts[indexPath.row].picture)
        
     

           return cell
       }


       func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
           return UIView()
       }

       func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 500
       }


    
    
    
    
    
    
    
   }

/*
 struct BlogPost: Decodable {
     let title: String
     let date: Date
 }

 let decoder = JSONDecoder()
 let dateFormatter = DateFormatter()
 dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
 dateFormatter.locale = Locale(identifier: "en_US")
 dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
 decoder.dateDecodingStrategy = .formatted(dateFormatter)

 let blogPost: BlogPost = try! decoder.decode(BlogPost.self, from: jsonData)
 print(blogPost.date) // Prints: 2019-10-21 09:15:00 +0000
 */
