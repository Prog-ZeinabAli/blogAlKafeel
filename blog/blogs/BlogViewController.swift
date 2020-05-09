//
//  BlogViewController.swift
//  blog
//
//  Created by test1 on 4/6/20.
//  Copyright © 2020 test1. All rights reserved.

import UIKit

class BlogViewController: UIViewController {
    let Refresh = HomeViewController()
    @IBOutlet weak var Loading: UIActivityIndicatorView!
    var cm = 0
    var xx : Int = 0
    var posts: [Post] = []
    
    @IBOutlet var CommentPopUp: UIView!
    @IBOutlet var tv: UITableView!
    @objc var  refreshConroler : UIRefreshControl = UIRefreshControl()

    
        override func viewDidLoad() {
        super.viewDidLoad()
        self.Loading.isHidden = false
        self.Loading.startAnimating()
        let aColor = UIColor(named: "customControlColor")
        tv.delegate = self
        tv.dataSource = self
        tv.addSubview(refreshConroler)
        refreshConroler.addTarget(self, action: #selector(BlogViewController.refreshData), for: UIControl.Event.valueChanged)
        
        
        
        
    }
    func date() {
        let isoDate = "2016-04-14T10:44:00+0000"
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from:isoDate)!
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour], from: date)
        let finalDate = calendar.date(from:components)
    }
    
    @objc func refreshData(){
        self.viewWillAppear(true)
        print (Share.shared.sortby ?? 0)
        print (Share.shared.categoryId ?? 0)
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
                    self!.Loading.isHidden = true
                     self!.Loading.stopAnimating()
                    
                    
                self!.posts = (response.data!.data)!
                    self?.xx = response.data?.current_page ?? 0
                    print(self?.xx)
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
        
        cell.PersonalImg.setImage(UIImage(named: "PersonalImg"), for: UIControl.State.normal)
        Utilities.CircledButton( cell.PersonalImg)
        let views1 = posts[indexPath.row].views ?? 0
        cell.NumView.text = "\(views1)"
        
    
        let commentCount = posts[indexPath.row].cmdCount ?? 0
        cell.CommentCount.text = "\(commentCount)"
        
        cell.TagButton.setTitle(posts[indexPath.row].category?.name ,for: .normal)
        
        cell.index = indexPath
        cell.cellDelegate = self // as! CommentIsClicked
        
        Utilities.styleHollowButton(cell.TagButton)
        Utilities.fadedColor(cell.TitleUiView)
        Utilities.CircledButton(cell.PersonalImg)
        
        
    
        
    
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
        //sending data to profile Section
        Share.shared.userId = posts[index].user?.id //691311583402731//posts[index].id
        
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
