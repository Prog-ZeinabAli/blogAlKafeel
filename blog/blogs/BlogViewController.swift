//
//  BlogViewController.swift
//  blog
//
//  Created by test1 on 4/6/20.
//  Copyright © 2020 test1. All rights reserved.

import UIKit

class BlogViewController: UIViewController {
    var cm = 0
    var xx : Int = 0
    var posts: [Post] = []
    
    @IBOutlet var CommentPopUp: UIView!
    @IBOutlet var tv: UITableView!
    @objc var  refreshConroler : UIRefreshControl = UIRefreshControl()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let aColor = UIColor(named: "customControlColor")
        tv.delegate = self
        tv.dataSource = self
        tv.addSubview(refreshConroler)
        refreshConroler.addTarget(self, action: #selector(BlogViewController.refreshData), for: UIControl.Event.valueChanged)
        if Share.shared.changed_happend == 1
        {
            let alert = UIAlertController(title: "خطأ", message: "in the view did load ي التحميل, تحقق من الاتصال بالانترنت", preferredStyle: .alert)
                               alert.addAction(UIAlertAction(title: "تم", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
        
    }
    
    @objc func refreshData(){
        tv.reloadData()
        print (Share.shared.sortby)
        print (Share.shared.categoryId)
        refreshConroler.endRefreshing()
    }
    // MARK: - Core Data Saving support
    
    override func didReceiveMemoryWarning() {
                 super.didReceiveMemoryWarning()
             }
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(true)
        if Share.shared.changed_happend == 1
               {
                   let alert = UIAlertController(title: "خطأ", message: "in the view will apppppeeeaaat ي التحميل, تحقق من الاتصال بالانترنت", preferredStyle: .alert)
                                      alert.addAction(UIAlertAction(title: "تم", style: .cancel, handler: nil))
                self.present(alert, animated: true)
               }
        
        
        let json: [String: Any] = ["sortby": Share.shared.sortby ?? 0  ,"cat": 1 ,"category_id": Share.shared.categoryId ?? 1]
        PostDataServer.instance.fetchAllPosts (json: json)
            { [weak self] (response) in
                if self == nil {return}
                if response.success {
                self!.posts = (response.data!.data)!
                    self?.xx = response.data?.current_page ?? 0
                    print(self?.xx)
                    self!.tv.reloadData()
                }else {
                    let alert = UIAlertController(title: "خطأ", message: "فشل في التحميل, تحقق من الاتصال بالانترنت", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "تم", style: .cancel, handler: nil))
                    self!.present(alert, animated: true)
                }
            }
        }

   

}

//table view
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
        
        //Send propperties through share
        let FZ = CGFloat(Share.shared.fontSize ?? 17)
        cell.content.font = UIFont.italicSystemFont(ofSize: FZ)
       
        
        cell.title.text = posts[indexPath.row].title
        
        cell.UserName.text = posts[indexPath.row].user?.name
                
        cell.content.text = posts[indexPath.row].content
        
        cell.Date.text = posts[indexPath.row].createdAt
        
        cell.PostImage.image = UIImage(contentsOfFile: posts[indexPath.row].image! ) ?? UIImage(named:"home")
        cell.PersonalImg.image = UIImage(contentsOfFile: (posts[indexPath.row].user?.picture)! ) ?? UIImage(named:"PersonalImg")
    
        let views1 = posts[indexPath.row].views ?? 0
        cell.NumView.text = "\(views1)"
        
    
        let commentCount = posts[indexPath.row].cmdCount ?? 0
        cell.CommentCount.text = "\(commentCount)"
        
        cell.TagButton.setTitle(posts[indexPath.row].category?.name ,for: .normal)
        
        cell.index = indexPath
        cell.cellDelegate = self // as! CommentIsClicked
        
        Utilities.styleHollowButton(cell.TagButton)
        Utilities.fadedColor(cell.TitleUiView)

        
        
    
        
       // cell.PersonalImg.image = UIImage(contentsOfFile: posts[indexPath.row].picture)
           return cell
       }

   /* func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        
        let lastItem = posts.count - 1
        if indexPath.row == lastItem {
            var index = posts.count
            posts.append(index)
            index = index + 1
            }
        }
    }

    func loadMoreData(){
        for i in 1 ..< 10 {
            var lastItem = posts.last!
            var num = (lastItem)
            posts.append(num)
        }
        tv.reloadData()
    } */
       func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
           return UIView()
       }

       func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 500
       }

   }

//to send data to the comment viewController
extension BlogViewController: CommentIsClicked{
    func onClickCell(index: Int) {
        //sedning index to the comment section
        let x = posts[index].id ?? 0
        Share.shared.PostId = x
        
       // sending data to the view section
        Share.shared.Blogscontent = posts[index].content
        Share.shared.Blogsusername = posts[index].user?.name
        
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
