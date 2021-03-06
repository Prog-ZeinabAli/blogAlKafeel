//
//  BlogViewController.swift
//  blog
//
//  Created by test1 on 4/6/20.
//  Copyright © 2020 test1. All rights reserved.

import UIKit
import CoreData
import Haneke
class BlogViewController: UIViewController {
 
    //MARK:- Outlets and Variables
    @IBOutlet weak var ReportButton: UIButton!
    var User_id = UserDefaults.standard.object(forKey: "loggesUserID")
    @IBOutlet weak var reloadChoice: UIActivityIndicatorView!  //when categories are chosen
    @IBOutlet weak var CategoryButton: UIButton!
    @IBOutlet weak var latestBlogsButton: UIButton!
    @IBOutlet weak var Loading: UIActivityIndicatorView!
    @IBOutlet weak var BlogTv: UITableView!
    @IBOutlet weak var CatgTv: UITableView!
    @IBOutlet var tv: UITableView!
    @objc var  refreshConroler : UIRefreshControl = UIRefreshControl()
    @IBOutlet weak var SearchBar: UISearchBar!
    
    let LatestBlogsTable = ["جميع التدوينات","احدث التدوينات","يتصدر الان"]
    let Refresh = HomeViewController()
  
    static var current_page = 2
    var cm = 0
    var xx : Int = 0
    var posts: [Post] = []
    var categories : [Category] = []
    var BookMark = [BookMarksCore]()
    var BM = [BookMarksCore]()
    var fetchMore = false
    var PostPaginationLink : String?
    var SearchPaginationLink : String?
    
 
     //MARK:- View Did Load
  
        override func viewDidLoad() {
            
            
            
            //MARK:- Signed in or not
                   let flag =  UserDefaults.standard.object(forKey: "LoginFlag") as? String
                   if flag == "yes"
                   {
                      PostPaginationLink =  "https://blog-api.turathalanbiaa.com/api/posttpagination2"
                       
                   }else{
                     PostPaginationLink =  "https://blog-api.turathalanbiaa.com/api/posttpagination"

                   }
            
            
            
            SearchBar.delegate = self
            //searching
            if Share.shared.SearchView == true{
                SearchBar.isHidden = false
                CategoryButton.isHidden = true
                latestBlogsButton.isHidden = true
                Share.shared.SearchView = false
            }else{
                 SearchBar.isHidden = true
            }
            
           Get.NightMode(from: self)
           if   UserDefaults.standard.object(forKey: "NightMode") as? String == "True"
           {
            CategoryButton.backgroundColor = .darkGray
            Utilities.styleHollowButton(CategoryButton)
            latestBlogsButton.backgroundColor = .darkGray
            Utilities.styleHollowButton(latestBlogsButton)
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
            
            
         /*  // MARK:- hide when tapping anywhere
            let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideEveryThing))
            view.addGestureRecognizer(tap)*/
    }
    
    
    
       @objc func refreshData(){
        self.viewWillAppear(true)
        print (Share.shared.sortby ?? 0)
        print (Share.shared.categoryId ?? 0)
        super.viewDidLoad()
    }
    
    
    @objc func hideEveryThing(){
        BlogTv.isHidden = true
        CatgTv.isHidden = true
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
        
          //  blog table view   Share.shared.categoryId ??
        if Share.shared.catChosen == true ||  Share.shared.FromCtegoryVC == "yes" {
            //if user is logged
             let flag =  UserDefaults.standard.object(forKey: "LoginFlag") as? String
             if flag == "yes"
                             {
                                 let json: [String: Any] = ["my_id": User_id , "sortby": Share.shared.sortby ?? 0 ,"cat": 1 ,"category_id": Share.shared.categoryId]
                                  loadBlogs( json:json)
                             }else{
                                 let json: [String: Any] = [ "sortby": Share.shared.sortby ?? 0 ,"cat": 1 ,"category_id": Share.shared.categoryId]
                                loadBlogs( json:json)
                             }
            
           
        }else {
            //if user is logged
                        let flag =  UserDefaults.standard.object(forKey: "LoginFlag") as? String
                        if flag == "yes"
                                        {
                                            let json: [String: Any] = [ "my_id": User_id ,"sortby": 2 ,"cat": 0 ]
                                                       loadBlogs( json: json)
                                        }else{
                                           let json: [String: Any] = [ "sortby": 2 ,"cat": 0 ]
                                                       loadBlogs( json: json)
                                        }
                       
           
        }
       
          tv.reloadData()
        }

       //MARK:- Load Blogs
    func loadBlogs( json: [String: Any]){
        PostDataServer.instance.fetchAllPosts (API_URL2: PostPaginationLink! ,json: json)
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
                        alert.addAction(UIAlertAction(title: "اعادة تحميل الصفحة", style: .default, handler: { (action: UIAlertAction!) in
                            self!.viewWillAppear(true)
                        }))
                            

                           
                        self!.Loading.isHidden = true
                        self!.Loading.stopAnimating()
                       }
                   }
    }
    
    
     //MARK:- Load more Items for pagination Function
    func loadMoreItems(){
        self.Loading.isHidden = false
                self.Loading.startAnimating()
                         let json: [String: Any] = ["sortby": Share.shared.sortby ?? 0 ,"cat": 1 ,"category_id": Share.shared.categoryId ?? 0]
        PostDataServer.instance.fetchAllPosts (API_URL2: PostPaginationLink! + "?page=" + "\( BlogViewController.current_page)", json: json)
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
    
    
    
       func loadSearhResult(searchText : String) {
            
            self.Loading.isHidden = false
            self.Loading.startAnimating()
        let json: [String: Any] = ["my_id": User_id as Any , "data": searchText]
               SearchPostDataServer.instance.Searching(json: json) { [weak self] (response) in
                                   if self == nil {return}
                                   if response.success {
                                  self!.posts = (response.data!.data)!
                                     self!.tv.reloadData()
                                      self!.Loading.isHidden = true
                                      self!.Loading.stopAnimating()
                                       print("loading")
                                   }else {
                                       let alert = UIAlertController(title: "خطأ", message: "فشل في التحميل, تحقق من الاتصال بالانترنت", preferredStyle: .alert)
                                       alert.addAction(UIAlertAction(title: "تم", style: .cancel, handler: nil))
                                       self!.present(alert, animated: true)
                                   }
                               }
        }

    // MARK: - updating views
    @IBAction func ViewsTapped(_ sender: Any) {
       
    }
    
    @IBAction func ReportIsTapped(_ sender: Any) {
        let flag =  UserDefaults.standard.object(forKey: "LoginFlag") as? String
                                    if flag != "yes"
                                    {
                                        let alert = UIAlertController(title: "خطأ", message: "عذرا ، يجب عليك تسجيل الدخول اولا لكتابة مدونة", preferredStyle: .alert)
                                                                      alert.addAction(UIAlertAction(title: "تم", style: .cancel, handler: nil))
                                        self.present(alert, animated: true)
                                        
        }
    }
    //MARK:- Category table button
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
      
    @IBAction func categoryPostPressed(_ sender: Any) {
        super.viewDidLoad()
        viewWillAppear(true)
        tv.reloadData()
    }
    
    // MARK:- Add bookMarks
    @IBAction func BookMarkIsTapped(_ sender: Any) {
        let alert = UIAlertController(title: "عذرا", message: "هذة الخاصية غير متوفرة حاليا ..سيتم تفعيل هذه الخاصية في النسخة القادمة", preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: "تم", style: .cancel, handler: nil))
               self.present(alert, animated: true)
    /*   let coin = UIImage(systemName: "pencil")
        (sender as AnyObject).setImage(coin ,for: UIControl.State.highlighted) 
        let bookMarks = BookMarksCore(context: PressitentServer.context)
        bookMarks.titleBM = Share.shared.title
        bookMarks.contentBM = Share.shared.Blogscontent
        bookMarks.nameBM = Share.shared.userName
        let postid = Share.shared.PostId ?? 0
        bookMarks.postIdBM = "\(String(describing: postid))"//Share.shared.Blogsusername
        PressitentServer.saveContext() */
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
                   return LatestBlogsTable.count
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
                  cell.textLabel?.adjustsFontSizeToFitWidth = true
                  return cell
               }
//MARK:- tableView.tag == 2 : SORT BY
               else if (tableView.tag == 2)
               {
                  let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
                   cell.textLabel?.text = LatestBlogsTable[indexPath.row]
                   cell.textLabel?.adjustsFontSizeToFitWidth = true
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
    
        let views1 = posts[indexPath.row].views ?? 0
        cell.NumView.text = "\(views1)"
        let commentCount = posts[indexPath.row].cmdCount ?? 0
        cell.CommentCount.text = "\(commentCount)"
        cell.TagButton.setTitle(posts[indexPath.row].category?.name ,for: .normal)
        cell.TagButton.titleLabel?.adjustsFontSizeToFitWidth = true
        cell.index = indexPath
        cell.cellDelegate = self // as! CommentIsClicked
        cell.cellDelegate2 = self // as! CommentIsClicked
       /* let urlString = "https://alkafeelblog.edu.turathalanbiaa.com/aqlam/image/" + posts[indexPath.row].image!
       let url = URL(string: urlString)
            cell.PostImage.hnk_setImage(from: url) 
            cell.PersonalImg.hnk_setImage(from: url, for: .normal)*/
        cell.PostImage.image = Get.Image(from:posts[indexPath.row].image!) ?? UIImage(named:"home")
        cell.PersonalImg.setImage(Get.Picture(from:(posts[indexPath.row].user?.picture)!) ?? UIImage(named:"PersonalImg"), for: .normal)
            
          
            
            
             //MARK:- Night mode cahnge cells
            if   UserDefaults.standard.object(forKey: "NightMode") as? String == "True"
            {
        cell.cardViewUIView.backgroundColor = UIColor(named: "System Red Color")
        cell.contentView.backgroundColor = UIColor.systemBackground
        Utilities.Borders(cell.cardViewUIView)
            }
            
       
        //For named color you have to resolve it.
        Utilities.styleHollowButton(cell.TagButton)
        Utilities.fadedColor(cell.TitleUiView)
        Utilities.CircledButton(cell.PersonalImg)
              return cell
        }
       //cell.PersonalImg.image = UIImage(contentsOfFile: posts[indexPath.row].picture)
           return tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
       }


       func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
           return UIView()
       }

    func tableView( _ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
        {
         
         
         if (tableView.tag == 1)
            {
                print("yuuup)")
                let x = DataService.instance.categories[indexPath.row].id ?? 0
                       Share.shared.categoryId = x
                Share.shared.catChosen = true
                tableView.isHidden = true
                super.viewDidLoad()
                refreshData()
                tableView.reloadData()
                self.reloadChoice.isHidden = false
                  self.reloadChoice.startAnimating()
            }
            else if( tableView.tag == 2)
            {
                print("yuuup)")
            Share.shared.sortby = indexPath.row
                tableView.isHidden = true
                super.viewDidLoad()
                refreshData()
                tableView.reloadData()
                self.reloadChoice.isHidden = false
                self.reloadChoice.startAnimating()
               
         }else {
            let x = posts[indexPath.row].id ?? 0
                  Share.shared.PostId = x
                  
                 // sending data to the view section
                  Share.shared.Blogscontent = posts[indexPath.row].content
                  Share.shared.Blogsusername = posts[indexPath.row].user?.name
                  Share.shared.title = posts[indexPath.row].title
           
            guard let menuViewController = self.storyboard?.instantiateViewController(identifier: "ViewBlog") else {return}
                                                      self.present(menuViewController,animated: true)
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
                            BlogViewController.current_page = BlogViewController.current_page + 1
                           
                         }
           }
       }
    
       func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (tableView.tag == 0)
        {
            if UIScreen.main.bounds.height <  800
                   {
                    print(UIScreen.main.bounds.size.height)
                       return UIScreen.main.bounds.height - 150
            }else{
            let heightRatio = UIScreen.main.bounds.height - 350
                print(UIScreen.main.bounds.size.height)
           return heightRatio
            }
        
        }else{
            return 45
        }
    }

   }



//MARK:-  Search for blogs
extension BlogViewController : UISearchBarDelegate
{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty == false
        {
              loadSearhResult(searchText: searchText)
           // print("changed")
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


//MARK:-  to filter the tv into catogries
extension BlogViewController: CategoryIsClicked{
    func onClickCell2(index: Int) {
     //category button is clicked
        let catId = DataService.instance.categories[index].id ?? 0
           Share.shared.categoryId = catId
           Share.shared.sortby = 1
           Share.shared.FromCtegoryVC = "yes"
    }
    
}


