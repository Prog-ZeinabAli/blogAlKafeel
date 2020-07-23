//
//  UnblockUserViewController.swift
//  blog
//
//  Created by turath alanbiaa on 7/10/20.
//  Copyright © 2020 test1. All rights reserved.
//

import UIKit

class UnblockUserViewController: UIViewController {
 var User_id = UserDefaults.standard.object(forKey: "loggesUserID")
    @IBOutlet weak var BackroudView: UIView!
    @IBOutlet weak var tv: UITableView!
    @IBOutlet weak var Loading: UIActivityIndicatorView!
    //let BlockedList = ["جميع التدوينات","احدث التدوينات","يتصدر الان"]
    
    
    override func viewDidLoad() {
        self.Loading.isHidden = false
        self.Loading.startAnimating()
        super.viewDidLoad()
        tv.delegate = self
        tv.dataSource = self
        Utilities.TitlefadedColor(BackroudView)
    
        // MARK:- hide when tapping anywhere
      /*  let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(Close))
        view.addGestureRecognizer(tap)*/
    }
    

    @objc func Close() {
                  guard let menuViewController = self.storyboard?.instantiateViewController(identifier: "Profile") else {return}
                       self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
             }
    
    
    override func didReceiveMemoryWarning() {
                      super.didReceiveMemoryWarning()
                  }
               
               override func viewWillAppear(_ animated: Bool) {
                   super.viewWillAppear(true)
                let json: [String: Any] = ["my_id": User_id as Any]
                TestServer.instance.fetchAlltest(json: json)
                {  (success) in
                                      if  success {
                                        self.tv.reloadData()
                                        self.Loading.isHidden = true
                                        self.Loading.stopAnimating()
                                      
                                      }else {
                                          let alert = UIAlertController(title: "خطأ", message: "فشل في التحميل, تحقق من الاتصال بالانترنت", preferredStyle: .alert)
                                          alert.addAction(UIAlertAction(title: "تم", style: .cancel, handler: nil))
                                        self.present(alert, animated: true)
                                      }
                                  }
                  
      }
   
}


extension UnblockUserViewController:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        TestServer.instance.test.count
       }
       
       
         func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
             let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UnblockTableViewCell
            
            cell.UserName.text = TestServer.instance.test[indexPath.row].name
            Utilities.BrightfadedColor(cell.MainView)
           
             return cell
         }
         

       func tableView( _ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
          {
              let alert = UIAlertController(title: "تنبيه !", message: "هل تريد الغاء حظر المستخدم ؟", preferredStyle: UIAlertController.Style.alert)
                    
                  alert.addAction(UIAlertAction(title: "نعم", style: .default, handler: { (action: UIAlertAction!) in
                    self.Loading.isHidden = false
                    self.Loading.startAnimating()
                    let json: [String: Any] = ["my_id": self.User_id as Any,"blocked_user_id": TestServer.instance.test[indexPath.row].user_id as Any]
                   UnBlockUserDataServer.instance.UnBlocking(json: json) { [weak self]
                            (response) in
                             if self == nil {return}
                                if response.success {
                                    if response.data != nil{
                                        self?.dismiss(animated: true, completion: nil)
                                    print("yeeeeeeeeey User was blocked ")
                                        let alert = UIAlertController(title: "خطأ", message: "فشل في التحميل, تحقق من الاتصال بالانترنت", preferredStyle: .alert)
                                                                              alert.addAction(UIAlertAction(title: "تم", style: .cancel, handler: nil))
                                                                                          self!.present(alert, animated: true)
                                        self!.Loading.isHidden = true
                                        self!.Loading.stopAnimating()
                                                }
                                                                
                                        }else {
                                    let alert = UIAlertController(title: "خطأ", message: "فشل في التحميل, تحقق من الاتصال بالانترنت", preferredStyle: .alert)
                                        alert.addAction(UIAlertAction(title: "تم", style: .cancel, handler: nil))
                                                    self!.present(alert, animated: true)
                                                self!.viewDidLoad()
                    }
                    }
                                                                                    
                                                                                   
                    }))
                    alert.addAction(UIAlertAction(title: "الغاء", style: .cancel, handler: nil))

                    present(alert, animated: true, completion: nil)
                    
          }

    
    
    
   
    
       func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
           return UIView()
       }
       
       func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 62
       }
       
    /*   extension CategoryViewController: CategoryTypeIsClicked{
       func onClickCell(index: Int) {
           let catId = DataService.instance.categories[index].id ?? 0
           Share.shared.categoryId = catId
           Share.shared.sortby = 1
           Share.shared.FromCtegoryVC = "yes"
           print(Share.shared.categoryId)
       }*/
  
    
}

