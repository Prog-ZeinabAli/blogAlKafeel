//
//  CommentViewController.swift
//  blog
//
//  Created by turath alanbiaa on 4/27/20.
//  Copyright © 2020 test1. All rights reserved.
//

import UIKit

class CommentViewController: UIViewController {
    var User_id = UserDefaults.standard.object(forKey: "loggesUserID")
    @IBOutlet weak var sendCmntBtn: UIButton!
    @IBOutlet weak var Loading: UIActivityIndicatorView!
    @IBOutlet weak var NoCommentsLabel: UILabel!
    @IBOutlet weak var comment: UITextField!
    var comments: [Comment] = []
    var postId = 0
    
    @IBOutlet weak var tv: UITableView!
    override func viewDidLoad() {
        NoCommentsLabel.isHidden = true
        super.viewDidLoad()
        tv.delegate = self
        tv.dataSource = self
        self.Loading.isHidden = false
        self.Loading.startAnimating()
        
      
             
    }
    override func didReceiveMemoryWarning() {
                    super.didReceiveMemoryWarning()
                }
             
             override func viewWillAppear(_ animated: Bool) {
                 super.viewWillAppear(true)
               
                let json: [String: Any] = ["post_id": Share.shared.PostId]
                CommentDataServer.instance.fetchAllComments(json:json ) { [weak self] (response) in
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
  
  
    
    @IBAction func SendComment(_ sender: Any) {
        sendCmntBtn.isEnabled = false
        self.Loading.isHidden = false
        self.Loading.startAnimating()
        
        if comment.text == ""
        {
            
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
                            print("succeded")
                            self!.sendCmntBtn.isEnabled = true
                            self!.comment.text = ""
                               self!.tv.reloadData()
                            self!.Loading.isHidden = true
                              self!.Loading.stopAnimating()
                            let alert = UIAlertController(title: "تمت عملية الارسال", message: "تمت عملية ارسال التعليق بنجاح  ", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "تم", style: .cancel, handler: nil))
                            self!.present(alert, animated: true)
                            
                            self!.dismiss(animated: true, completion: nil)
                           }else {
                               let alert = UIAlertController(title: "خطأ", message: "فشل في التحميل, تحقق من الاتصال بالانترنت", preferredStyle: .alert)
                               alert.addAction(UIAlertAction(title: "تم", style: .cancel, handler: nil))
                               self!.present(alert, animated: true)
                               self!.sendCmntBtn.isEnabled = true
                           }
                       }
        }
        
    }
    
    @IBAction func CancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}




extension CommentViewController: UITableViewDataSource, UITableViewDelegate {

       public func numberOfSections(in tableView: UITableView) -> Int {
           return 1
       }

       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           print(comments.count)
           return comments.count
       }

       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CommentTableViewCell
        
        
        if comments.count == 0
                           {
                               NoCommentsLabel.isHidden = false
                           }
        
        cell.Username.text = comments[indexPath.row].user?.name
        cell.Date.text = comments[indexPath.row].createdAt
        cell.comment.text = comments[indexPath.row].content
     

           return cell
       }


       func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
           return UIView()
       }

       func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 114
       }
    
    
   }
