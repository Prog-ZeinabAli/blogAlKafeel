//
//  BlogViewController.swift
//  blog
//
//  Created by test1 on 4/6/20.
//  Copyright © 2020 test1. All rights reserved.

import UIKit
import CoreData

class BlogViewController: UIViewController {
 
    //MARK:- Outlets and Variables
    @IBOutlet weak var reloadChoice: UIActivityIndicatorView!  //when categories are chosen
    @IBOutlet weak var CategoryButton: UIButton!
    @IBOutlet weak var latestBlogsButton: UIButton!
    @IBOutlet weak var Loading: UIActivityIndicatorView!
    @IBOutlet weak var BlogTv: UITableView!
    @IBOutlet weak var CatgTv: UITableView!
    @IBOutlet var tv: UITableView!
    @objc var  refreshConroler : UIRefreshControl = UIRefreshControl()
    
    let x = ["جميع التدوينات","احدث التدوينات","يتصدر الان"]
    let Refresh = HomeViewController()
  
    static var current_page = 2
    var cm = 0
    var xx : Int = 0
    var posts: [Post] = []
    var BookMark = [BookMarksCore]()
    var BM = [BookMarksCore]()
    var fetchMore = false
    
 
     //MARK:- View Did Load
        override func viewDidLoad() {
            if UserDefaults.standard.object(forKey: "NightMode") as? String  == "True"
            {
                 overrideUserInterfaceStyle = .dark
            }else{
                overrideUserInterfaceStyle = .light
            }
           
         

            //viewing from the categories page
            if Share.shared.FromCtegoryVC == "yes"
                     {
                       CategoryButton.isHidden = true
                       Share.shared.FromCtegoryVC = "no"
                     }
            
            //bookmak stuuf
            let fetchRequest : NSFetchRequest<BookMarksCore> = BookMarksCore.fetchRequest()
                 do {
                     let BookMark = try PressitentServer.context.fetch(fetchRequest)
                     self.BookMark = BookMark
                 }catch{}
                 
        super.viewDidLoad()
        reloadChoice!.isHidden = true
        tv.delegate = self
        tv.dataSource = self
        CatgTv.delegate = self
        CatgTv.dataSource = self
        BlogTv.delegate =  self
        BlogTv.dataSource = self
        tv.addSubview(refreshConroler)
        refreshConroler.addTarget(self, action: #selector(BlogViewController.refreshData), for: UIControl.Event.valueChanged)
        CategoryButton.titleLabel?.adjustsFontSizeToFitWidth = true
        latestBlogsButton.titleLabel?.adjustsFontSizeToFitWidth = true
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
        
        self.Loading.isHidden = false
         self.Loading.startAnimating()
     
        //cateogory table view
        DataService.instance.fetchAllCategories { (success) in
                     if success {
                         self.CatgTv.reloadData()
                     }
                 }
        
          //  blog table view
        print (Share.shared.categoryId ?? 0)
        let json: [String: Any] = ["sortby": Share.shared.sortby ?? 0 ,"cat": 1 ,"category_id": Share.shared.categoryId ?? 0]
        PostDataServer.instance.fetchAllPosts (API_URL2: "https://blog-api.turathalanbiaa.com/api/posttpagination",json: json)
            { [weak self] (response) in
                if self == nil {return}
                if response.success {
                    self!.Loading.isHidden = true
                     self!.Loading.stopAnimating()
                    self!.reloadChoice.isHidden = true
                    self!.reloadChoice.stopAnimating()

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

    
     //MARK:- Load more Items for pagination Function
    func loadMoreItems(){
        self.Loading.isHidden = false
                self.Loading.startAnimating()
                         let json: [String: Any] = ["sortby": Share.shared.sortby ?? 0 ,"cat": 1 ,"category_id": Share.shared.categoryId ?? 0]
            PostDataServer.instance.fetchAllPosts (API_URL2: "https://blog-api.turathalanbiaa.com/api/posttpagination"+"?page=" + "\( BloggersViewController.current_page)", json: json)
                                                              { [weak self] (response) in
                                                                  if self == nil {return}
                                                                  if response.success {
                                                                      self!.Loading.isHidden = true
                                                                       self!.Loading.stopAnimating()
                                                                      self!.reloadChoice.isHidden = true
                                                                      self!.reloadChoice.stopAnimating()

                                                                    self!.posts.append(contentsOf: (response.data!.data)!)
                                                                 self!.fetchMore = false
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
    
     //MARK:- Category button
    @IBAction func CategoryButtonPressed(_ sender: Any) {
          if self.CatgTv.isHidden == true {
                       self.CatgTv.isHidden = false
                   }
                   else {
                          self.CatgTv.isHidden = true
              }
      }
       //MARK:- Latest Blog Button
      @IBAction func LatestBlogButtonPressed(_ sender: Any) {
          if self.BlogTv.isHidden == true {
                               self.BlogTv.isHidden = false
                           }
                           else {
                                  self.BlogTv.isHidden = true
                      }
      }
      
    
    // MARK:- Add bookMarks
    @IBAction func BookMarkIsTapped(_ sender: Any) {
       let coin = UIImage(systemName: "pencil")
        (sender as AnyObject).setImage(coin ,for: UIControl.State.highlighted) 
        let bookMarks = BookMarksCore(context: PressitentServer.context)
        bookMarks.titleBM = Share.shared.title
        bookMarks.contentBM = Share.shared.Blogscontent
        bookMarks.nameBM = Share.shared.userName
        let postid = Share.shared.PostId ?? 0
        bookMarks.postIdBM = "\(String(describing: postid))"//Share.shared.Blogsusername
        PressitentServer.saveContext()
    }
    
}



 //MARK:- EXTENSIONS
extension BlogViewController: UITableViewDataSource, UITableViewDelegate {
       public func numberOfSections(in tableView: UITableView) -> Int {
    
           return 1
       }

       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (tableView.tag == 1){
                  return DataService.instance.categories.count
               }
               else if( tableView.tag == 2){
                   return x.count
               }
            else if( tableView.tag == 0){
                return posts.count
            }else{
                   return 0
               }
       }

    
    
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//MARK:- tableView.tag == 1 : CATEGORY
        if(tableView.tag == 1) //CATEGORY TABLE VIEW
               {
                  let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
                  cell.textLabel?.text = DataService.instance.categories[indexPath.row].categoryName
                   //cell.textLabel?.text = x1[indexPath.row]
                  return cell
               }
//MARK:- tableView.tag == 2 : SORT BY
               else if (tableView.tag == 2)
               {
                  let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
                   cell.textLabel?.text = x[indexPath.row]
                  return cell
                
//MARK:- tableView.tag == 0 : BLOGS AND BOOKMARKS
        } else if (tableView.tag == 0) // RING OU THE BOOK MARKS
        {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! BlogCardTableViewCell
            let fetchRequest : NSFetchRequest<BookMarksCore> = BookMarksCore.fetchRequest()
                       do {
                             let BM = try PressitentServer.context.fetch(fetchRequest)
                                     self.BM = BM
                                 }catch{}
                         
                 if BM.count != 0{
                     for i in 0 ... BM.count - 1{
                         let postid = Share.shared.PostId ?? 0
                                          if  BM[i].postIdBM ==  "\(postid)"
                                          {
                                             cell.BookMarkSaved.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
                                          }else{
                                             cell.BookMarkSaved.setImage(UIImage(systemName: "bookmark"), for: .normal)
                        }
                    }
                 }
            
            
           
        //change according to settings
        let FZ = UserDefaults.standard.object(forKey: "FontSizeDefault") as? CGFloat //CGFloat(Share.shared.fontSize ?? 17)
            cell.content.font = UIFont.italicSystemFont(ofSize: FZ ?? 13)
        let FT =  UserDefaults.standard.object(forKey:"FontTypeDefault") as? String
            cell.content.font = UIFont(name: FT ?? "Lateef", size: FZ ?? 13)
            cell.title.font = UIFont(name: FT ?? "Lateef", size: 30)
            
        
            
            
            
            
       let dateFormatterGet = DateFormatter()  //
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM"// dd,yyyy"
        if let date = dateFormatterGet.date(from: String(posts[indexPath.row].createdAt ?? "00-00-0000 00 00"))  {
            cell.Date.text = dateFormatterPrint.string(from: Date() - date.distance(to: Date()))//(from: date)
        }

        cell.title.text = posts[indexPath.row].title
        cell.UserName.text = posts[indexPath.row].user?.name
        cell.content.text = posts[indexPath.row].content
       // cell.PostImage.image = UIImage(contentsOfFile: posts[indexPath.row].image! ) ?? UIImage(named:"home")
            cell.PostImage.image = Get.Image(from:posts[indexPath.row].image!) ?? UIImage(named:"home") //posts[indexPath.row].image!) "1585684885.jpg"
        cell.PersonalImg.setImage(UIImage(named: "PersonalImg"), for: UIControl.State.normal)
        let views1 = posts[indexPath.row].views ?? 0
        cell.NumView.text = "\(views1)"
        //cell.cardViewUIView.overrideUserInterfaceStyle = .light
        cell.cardViewUIView.backgroundColor = UIColor(named: "System Red Color")
            Utilities.Borders(cell.cardViewUIView)
        let commentCount = posts[indexPath.row].cmdCount ?? 0
        cell.CommentCount.text = "\(commentCount)"
        cell.TagButton.setTitle(posts[indexPath.row].category?.name ,for: .normal)
        cell.index = indexPath
        cell.cellDelegate = self // as! CommentIsClicked
        cell.contentView.backgroundColor = UIColor.systemBackground
        //For named color you have to resolve it.
        Utilities.styleHollowButton(cell.TagButton)
        Utilities.fadedColor(cell.TitleUiView)
        Utilities.CircledButton(cell.PersonalImg)
              return cell
        }
       // cell.PersonalImg.image = UIImage(contentsOfFile: posts[indexPath.row].picture)
           return tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
       }


       func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
           return UIView()
       }

    func tableView( _ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
        {
         
         
         if (tableView.tag == 1)
            {
                let x = DataService.instance.categories[indexPath.row].id ?? 0
                       Share.shared.categoryId = x
                tableView.isHidden = true
                super.viewDidLoad()
                refreshData()
                tableView.reloadData()
                self.reloadChoice.isHidden = false
                  self.reloadChoice.startAnimating()
            }
            else if( tableView.tag == 2)
            {
            Share.shared.sortby = indexPath.row
                tableView.isHidden = true
                super.viewDidLoad()
                refreshData()
                tableView.reloadData()
                self.reloadChoice.isHidden = false
                self.reloadChoice.startAnimating()
               
             }
        
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
                           BloggersViewController.current_page = BloggersViewController.current_page + 1
                           
                         }
           }
       }
    
       func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (tableView.tag == 0)
        {
           return 500
        }else{
            return 45
        }
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





