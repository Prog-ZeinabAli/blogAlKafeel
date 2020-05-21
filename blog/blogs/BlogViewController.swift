//
//  BlogViewController.swift
//  blog
//
//  Created by test1 on 4/6/20.
//  Copyright © 2020 test1. All rights reserved.

import UIKit
import CoreData

class BlogViewController: UIViewController {
    let Refresh = HomeViewController()
    @IBOutlet weak var Loading: UIActivityIndicatorView!
    var cm = 0
    var xx : Int = 0
    var posts: [Post] = []
     var BookMark = [BookMarksCore]()
    
    @IBOutlet var CommentPopUp: UIView!
    @IBOutlet var tv: UITableView!
    @objc var  refreshConroler : UIRefreshControl = UIRefreshControl()

    
    
        override func viewDidLoad() {
            
            //bookmak stuuf
            let fetchRequest : NSFetchRequest<BookMarksCore> = BookMarksCore.fetchRequest()
                 do {
                     let BookMark = try PressitentServer.context.fetch(fetchRequest)
                     self.BookMark = BookMark
                 }catch{}
                 
        super.viewDidLoad()
        self.Loading.isHidden = false
        self.Loading.startAnimating()
       // let Color = UIColor(named: "customControlColor")
        tv.delegate = self
        tv.dataSource = self
        tv.addSubview(refreshConroler)
        refreshConroler.addTarget(self, action: #selector(BlogViewController.refreshData), for: UIControl.Event.valueChanged)
    }
    
    
    
    
 
    func timeAgoSinceDate(_ date:Date, numericDates:Bool = false) -> String? {
        let calendar = NSCalendar.current
        let unitFlags: Set<Calendar.Component> = [.minute, .hour, .day, .weekOfYear, .month, .year, .second]
        let now = Date()
        let earliest = now < date ? now : date
        let latest = (earliest == now) ? date : now
        let components = calendar.dateComponents(unitFlags, from: earliest,  to: latest)

        if (components.year! >= 2) {
            return "\(components.year!)yr"
        } else if (components.year! >= 1){
            if (numericDates){
                return "1yr"
            } else {
                return "Last year"
            }
        } else if (components.month! >= 2) {
            return "\(components.month!)mo"
        } else if (components.month! >= 1){
            if (numericDates){
                return "1 mo"
            } else {
                return "Last mo"
            }
        } else if (components.weekOfYear! >= 2) {
            return "\(components.weekOfYear!) weeks"
        } else if (components.weekOfYear! >= 1){
            if (numericDates){
                return "1 week"
            } else {
                return "Last week"
            }
        } else if (components.day! >= 2) {
            return "\(components.day!) d"
        } else if (components.day! >= 1){
            if (numericDates){
                return "1 d"
            } else {
                return "1 d"
            }
        } else if (components.hour! >= 2) {
            return "\(components.hour!) hrs"
        } else if (components.hour! >= 1){
            if (numericDates){
                return "1 hr"
            } else {
                return "1 hr"
            }
        } else if (components.minute! >= 2) {
            return "\(components.minute!) m"
        } else if (components.minute! >= 1){
            if (numericDates){
                return "1 m"
            } else {
                return "2 m"
            }
        } else if (components.second! >= 3) {
            return "\(components.second!)s"
        } else {
            return "now"
        }

    }
    
    
       @objc func refreshData(){
        self.viewWillAppear(true)
        print (Share.shared.sortby ?? 0)
        print (Share.shared.categoryId ?? 0)
        super.viewDidLoad()
        
    }
    // MARK: - Loading blogs
    
    override func didReceiveMemoryWarning() {
                 super.didReceiveMemoryWarning()
             }
    override func viewWillAppear(_ animated: Bool) {
          //  super.viewWillAppear(true)
        print (Share.shared.categoryId ?? 0)
        let json: [String: Any] = ["sortby": Share.shared.sortby ?? 0 ,"cat": 1 ,"category_id": Share.shared.categoryId ?? 0]
        PostDataServer.instance.fetchAllPosts (json: json)
            { [weak self] (response) in
                if self == nil {return}
                if response.success {
                    self!.Loading.isHidden = true
                     self!.Loading.stopAnimating()

                self!.posts = (response.data!.data)!
                    self?.xx = response.data?.current_page ?? 0
                //    print(self?.xx)
                    self!.tv.reloadData()
                    self!.refreshConroler.endRefreshing()
                }else {
                    let alert = UIAlertController(title: "خطأ", message: "فشل في التحميل, تحقق من الاتصال بالانترنت", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "تم", style: .cancel, handler: nil))
                    self!.present(alert, animated: true)
                     self!.refreshConroler.endRefreshing()
                    self!.viewDidLoad()
                }
            }
          tv.reloadData()
        }

    
    // MARK: - updating views
    @IBAction func ViewsTapped(_ sender: Any) {
        let json: [String: Any] = ["id": Share.shared.PostId as Any]
        updateViewDataServer.instance.Updating(json: json)
                   { [weak self] (response) in
                       if self == nil {return}
                       if response.success {
                        print("views are updated")
        
                       }else {
                           let alert = UIAlertController(title: "خطأ", message: "فشل في التحميل, تحقق من الاتصال بالانترنت", preferredStyle: .alert)
                           alert.addAction(UIAlertAction(title: "تم", style: .cancel, handler: nil))
                           self!.present(alert, animated: true)
                           self!.viewDidLoad()
                       }
                   }
    }
    
    // MARK: - add bookMarks
    @IBAction func BookMarkIsTapped(_ sender: Any) {
      /*  let coin = UIImage(systemName: "pencil")
        (sender as AnyObject).setImage(coin ,for: UIControl.State.highlighted) */
        let bookMarks = BookMarksCore(context: PressitentServer.context)
        bookMarks.titleBM = Share.shared.title
        bookMarks.contentBM = Share.shared.Blogscontent
        bookMarks.nameBM = Share.shared.Blogsusername
     //   bookMarks.postIdBM = (Share.shared.PostId) as! String?
      //  bookMarks.postIdBM = Share.shared.PostId
        PressitentServer.saveContext()
        
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
        
        //bookMark Button
     /*   for i in 0...BookMark.count {
             if BookMark[i].postIdBM == (posts[indexPath.row].id) as! String?
                   {
                        cell.BookMarkSaved.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
                   }else{
                       cell.BookMarkSaved.setImage(UIImage(systemName: "bookmark"), for: .normal)
                   }
                  
        } */
      
        
       // cell.BookMarkSaved.set
        
        //Send propperties through share
        let FZ = CGFloat(Share.shared.fontSize ?? 17)
        cell.content.font = UIFont.italicSystemFont(ofSize: FZ)
       
        
        cell.title.text = posts[indexPath.row].title
        
        cell.UserName.text = posts[indexPath.row].user?.name
                
        
      let dateFormatterGet = DateFormatter()  //
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM"// dd,yyyy"

        
        
        if let date = dateFormatterGet.date(from: String(posts[indexPath.row].createdAt ?? "00-00-0000 00 00"))  {
            
            cell.Date.text = dateFormatterPrint.string(from: Date() - date.distance(to: Date()))//(from: date)
        }

            
        cell.content.text = posts[indexPath.row].content
        
       
        
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
    
 /*   func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row < posts.count - 1
        {
            self.posts.append(posts)
        }
        self.tv.reloadData()
        
    } */

       func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
           return UIView()
       }

    
       func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 500
       }

   }



//MARK:-  to send data to the (comment + view + profile) viewControllers
extension BlogViewController: CommentIsClicked{
    func onClickCell(index: Int) {
        //sedning index to the comment section
        let x = posts[index].id ?? 0
        Share.shared.PostId = x
        
       // sending data to the view section
        Share.shared.Blogscontent = posts[index].content
        Share.shared.Blogsusername = posts[index].user?.name
        Share.shared.title = posts[index].title
        
        //sending data to profile Section
        Share.shared.userId = posts[index].user?.id
        
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
