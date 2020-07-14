//
//  CommentViewController.swift
//  blog
//
//  Created by turath alanbiaa on 4/27/20.
//  Copyright © 2020 test1. All rights reserved.
//

import UIKit

class CommentViewController: UIViewController {
    var User_id = UserDefaults.standard.object(forKey: "loggesUserID") ?? "noUser" as Any
    var commentId : Int!
    var Commentindex :Int! // delete comment at index
  
    @IBOutlet weak var sendCmntBtn: UIButton!
    @IBOutlet weak var Loading: UIActivityIndicatorView!
    @IBOutlet weak var NoCommentsLabel: UILabel!
    @IBOutlet weak var comment: UITextField!
    
    var comments: [Comment] = []
    var postId = 0
    var fetchMore = false
    

    @IBOutlet weak var tv: UITableView!
    override func viewDidLoad() {
        NoCommentsLabel.isHidden = true
        super.viewDidLoad()
        print("userid\(User_id)")
        Get.NightMode(from: self)
        tv.delegate = self
        tv.dataSource = self
        self.Loading.isHidden = false
        self.Loading.startAnimating()
        
      
             
    }
    
    
    
    
     //MARK:- Loading Comment View
    override func didReceiveMemoryWarning() {
                    super.didReceiveMemoryWarning()
                }
             
             override func viewWillAppear(_ animated: Bool) {
                 super.viewWillAppear(true)
               
                let json: [String: Any] = ["post_id": Share.shared.PostId]
                CommentDataServer.instance.fetchAllComments( API_URL6 : "https://blog-api.turathalanbiaa.com/api/commentpagination" , json:json ) { [weak self] (response) in
                     if self == nil {return}
                     if response.success {
                        self!.comments = (response.data!.data)!
                       let noOfCmnts = response.data?.total
                        if noOfCmnts == 0
                        {
                            self!.NoCommentsLabel.isHidden = false
                        }
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
  
  
    
    //MARK:- Deleting Comment
    @IBAction func DeleteCommentIsTapped(_ sender: Any) {
        self.Loading.isHidden = false
        self.Loading.startAnimating()
       let json: [String: Any] = ["id": commentId ?? 0]
        DeleteCmntDataServer.instance.Delete(json:json ) { [weak self] (response) in
                           if self == nil {return}
                          if response.success {
                           if let user = response.data {
                              if(user.message == "DONE")
                            {
                                print("deleted")
                                self!.tv.reloadData()
                                self!.Loading.isHidden = true
                                self!.Loading.stopAnimating()
                                self!.dismiss(animated: true, completion: nil)
                              }else if (user.message == "NOT FOUND") {
                                let alert = UIAlertController(title: "خطأ", message: "فشل في الحذف, تحقق من الاتصال بالانترنت", preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "تم", style: .cancel, handler: nil))
                                self!.present(alert, animated: true)
                            }
            }
        }
        
    }
    }
    
    
    
     //MARK:- Sending Comment
    @IBAction func SendComment(_ sender: Any) {
        sendCmntBtn.isEnabled = false
        self.Loading.isHidden = false
        self.Loading.startAnimating()
        let flag =  UserDefaults.standard.object(forKey: "LoginFlag") as? String
                                   if flag != "yes"
                                   {
                                     let alert = UIAlertController(title: "خطأ", message: "عذرا ، يجب عليك تسجيل الدخول اولا لاضافة تعليق", preferredStyle: .alert)
                                     alert.addAction(UIAlertAction(title: "تم", style: .cancel, handler: nil))
                                     self.present(alert, animated: true)
                                   }else if comment.text == "" {
            let alert = UIAlertController(title: "خطأ", message: "لم يتم كتابة اي تعليق ، يرجى كتابة تعليق قبل الارسال", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "تم", style: .cancel, handler: nil))
            self.present(alert, animated: true)
            sendCmntBtn.isEnabled = true
            self.Loading.isHidden = true
            self.Loading.stopAnimating()
                                    
        }else{
        
        let json: [String: Any] = ["user_id": User_id , "post_id": Share.shared.PostId, "content": comment.text]
        AddcomentDataServer.instance.addComment(json:json ) { [weak self] (response) in
                           if self == nil {return}
                           if response.success {
                           // self!.dismiss(animated: true, completion: nil)
                            self!.sendCmntBtn.isEnabled = true
                            self!.comment.text = ""
                            self!.view.endEditing(true)
                               self!.tv.reloadData()
                            self!.Loading.isHidden = true
                              self!.Loading.stopAnimating()
                          let alert = UIAlertController(title: "تمت عملية الارسال", message: "تمت عملية ارسال التعليق بنجاح  ", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "تم", style: .cancel, handler: nil))
                            self!.present(alert, animated: true)
                            self!.dismiss(animated: true, completion: nil)
                           }else if let user = response.data {
                            if(user.message == "NOT FOUND"){
                                let alert = UIAlertController(title: "خطأ", message: "فشل في التحميل, تحقق من الاتصال بالانترنت", preferredStyle: .alert)
                                    alert.addAction(UIAlertAction(title: "تم", style: .cancel, handler: nil))
                                                              self!.present(alert, animated: true)
                                self!.Loading.isHidden = true
                                self!.Loading.stopAnimating()
                                 self!.dismiss(animated: true, completion: nil)
                            }else if(user.message == "user not found")
                            {
                                let alert = UIAlertController(title: "خطأ", message: "عذرا ، يجب عليك تسجيل الدخول اولا لاضافة تعليق", preferredStyle: .alert)
                                    alert.addAction(UIAlertAction(title: "تم", style: .cancel, handler: nil))
                                self!.present(alert, animated: true)
                                self!.Loading.isHidden = true
                                self!.Loading.stopAnimating()
                                self!.dismiss(animated: true, completion: nil)
                            }
                            }
                           else{
                               let alert = UIAlertController(title: "خطأ", message: "فشل في التحميل, تحقق من الاتصال بالانترنت", preferredStyle: .alert)
                               alert.addAction(UIAlertAction(title: "تم", style: .cancel, handler: nil))
                               self!.present(alert, animated: true)
                                self!.sendCmntBtn.isEnabled = true
                                
                        }
                }
        }
    }
    
    func insertNewComment(){
     //comments.append(comment.text!)
      let indexPath = IndexPath(row: comments.count - 1, section: 0)
        tv.beginUpdates()
        tv.insertRows(at: [indexPath], with: .automatic)
        tv.endUpdates()
        tv.reloadData()
        
    }
    
    
    
     //MARK:- Cancelling Comment View
    
    @IBAction func CancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
     //MARK:- Load more Items for pagination Function
    func loadMoreItems(){
        self.Loading.isHidden = false
                self.Loading.startAnimating()
        let json: [String: Any] = ["post_id": Share.shared.PostId]
        CommentDataServer.instance.fetchAllComments( API_URL6 : "https://blog-api.turathalanbiaa.com/api/commentpagination" + "?page=" + "\( ProfileViewController.current_page)"  , json:json ) { [weak self] (response) in
                                                                  if self == nil {return}
                                                                  if response.success {
                                                                    
                                                                 
                                                                      self!.Loading.isHidden = true
                                                                       self!.Loading.stopAnimating()
                                                                    self!.comments.append(contentsOf: (response.data!.data)!)
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




extension CommentViewController: UITableViewDataSource, UITableViewDelegate {

    /*   public func numberOfSections(in tableView: UITableView) -> Int {
           return 1
       }*/
    

       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return comments.count
       }
    
    
    

       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CommentTableViewCell
        
        
        if comments.count == 0{
            NoCommentsLabel.isHidden = false }
        
        let dateFormatterGet = DateFormatter()  //
               dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
               let dateFormatterPrint = DateFormatter()
               dateFormatterPrint.dateFormat = "MMM"// dd,yyyy"
               if let date = dateFormatterGet.date(from: String(comments[indexPath.row].createdAt ?? "00-00-0000 00 00"))  {
               cell.Date.text = dateFormatterPrint.string(from: Date() - date.distance(to: Date()))//(from: date)
               }
        
        
        cell.Username.text = comments[indexPath.row].user?.name
        cell.comment.text = comments[indexPath.row].content

          let flag =  UserDefaults.standard.object(forKey: "LoginFlag") as? String
           if flag == "yes"
            {
               print ( "----------\(String(describing: comments[indexPath.row].user?.id))" )
                print ( "===========\(User_id)")
            print("there is a user id")
           if  comments[indexPath.row].user?.id == User_id as! Int {
              //  if  "\(comments[indexPath.row].user?.id)" == "\(User_id)" {
            cell.DeleteButtonView.isHidden = false
         }
        }else{
            print(User_id)
            print("user has NO id")
        }
        
        cell.index = indexPath
       cell.cellDelegate = self as! DeleteButtonIsClicked
        
        
           return cell
       }

    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
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
    
       func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
           return UIView()
       }

       func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 114
       }
    
    
   }


extension CommentViewController: DeleteButtonIsClicked{
    func onClickCell(index: Int) {
        commentId = comments[index].id
        Commentindex = index
    }
    
}
