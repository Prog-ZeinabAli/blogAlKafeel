//
//  LogInViewController.swift
//  blog
//
//  Created by test1 on 4/9/20.
//  Copyright © 2020 test1. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin
import Alamofire
import SwiftyJSON
import FBSDKLoginKit

class LogInViewController: UIViewController {

    var institutionFlag = 0
    @IBOutlet weak var signInWinstution: UISwitch!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var LogInWithFb: UIButton!
    @IBOutlet weak var LogInBtn: UIButton!
    @IBOutlet var MainView: UIView!
    @IBOutlet weak var Loading: UIActivityIndicatorView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Utilities.fadedColor(MainView)
         Utilities.styleHollowButton(LogInBtn)
        Loading.isHidden = true
    }
    
    //MARK:- FACEBOOK LOGIN
    @IBAction func FaceBookLogInBtn(_ sender: Any) {
        getFacebookUserInfo()
        
        let json: [String: Any] = ["id": Share.shared.PostId as Any , "name": Share.shared.userName as Any , "picture": "ji", "email": Share.shared.email as Any]
                   print(institutionFlag)
        LoginByFacebook.instance.FaceBookLogin(json: json){ [weak self] (response) in
            guard let self = self else { return }
                                if response.success {
                                    print(Share.shared.PostId as Any)
        }
    }
    }
    
    func getFacebookUserInfo(){
        let loginManager = LoginManager()
        loginManager.logIn(permissions: [.publicProfile, .email ], viewController: self) { (result) in
            switch result{
            case .cancelled:
                print("Cancel button click")
            case .success:
                let params = ["fields" : "id, name, first_name, last_name, picture.type(large), email "]
                let graphRequest = GraphRequest.init(graphPath: "/me", parameters: params)
                let Connection = GraphRequestConnection()
                Connection.add(graphRequest) { (Connection, result, error) in
                    let info = result as! [String : AnyObject]
                    print(info["name"] as! String)
                   // print(info["id"] as! String)
                    Share.shared.userName = (info["name"] as! String)
                    Share.shared.email = (info["email"] as! String)
                   // Share.shared.picture = (info["picture.type(large)"] as! String)
                   Share.shared.PostId = (info["id"] as! Int)
                }
                Connection.start()
            default:
                print("??")
            }
        }
    }
    
    
    
    //MARK:- CHECK IF USER SIGNED IN AS AN INSTITUTION
    @IBAction func InstitutionTabbed(_ sender: Any) {

        if signInWinstution.isOn == true
        {
            usernameTxt.backgroundColor = UIColor.red
            institutionFlag = 1
        } else if signInWinstution.isOn == false
        {
            usernameTxt.backgroundColor = UIColor.white
            institutionFlag = 0
        }
    }
    
    
    //MARK:- LOGIN
    @IBAction func LogInBtnPressed(_ sender: Any) {
        
        self.Loading.isHidden = false
        self.Loading.startAnimating()
        
        if (passwordTxt.text == "") || (usernameTxt.text == "")
        {
            let alert = UIAlertController(title: "خطأ", message: "احد الحقول فارغة يرجى ملئ جميع الحقول", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "تم", style: .cancel, handler: nil))
            self.present(alert, animated: true)
            self.Loading.isHidden = true
            self.Loading.stopAnimating()
        }else{
            let json: [String: Any] = ["email": passwordTxt.text as Any,"password": usernameTxt.text as Any ]//, "db":institutionFlag]
            print(institutionFlag)
            LogInServer.instance.LogInCheck(json:json) { [weak self] (response) in
                      guard let self = self else { return }
                      if response.success {
                          if let user = response.data {
                              if(user.message == "NOT FOUND")
                              {
                                  let alert = UIAlertController(title: "خطأ", message: "خطأ في الرمز السري او المعرف", preferredStyle: .alert)
                                                 alert.addAction(UIAlertAction(title: "تم", style: .cancel, handler: nil))
                                  self.present(alert, animated: true)
                                self.Loading.isHidden = true
                                          self.Loading.stopAnimating()
                              }else{
                                print(user.id!)
                                Share.shared.userName = user.name!
                                Share.shared.PostId = user.id!
                                self.dismiss(animated: true, completion: nil)
                              }
                          }
                        self.Loading.isHidden = true
                                  self.Loading.stopAnimating()
                      } else {
                           let alert = UIAlertController(title: "خطأ", message: "فشل في التحميل, تحقق من الاتصال بالانترنت", preferredStyle: .alert)
                                         alert.addAction(UIAlertAction(title: "تم", style: .cancel, handler: nil))
                          self.present(alert, animated: true)
                         self.Loading.isHidden = true
                                  self.Loading.stopAnimating()
                      }
                  }
        }
    
    }
       
    
    
    
    
    
  
}

