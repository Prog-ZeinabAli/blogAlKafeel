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

class LogInViewController: UIViewController {

    var institutionFlag = 0
    @IBOutlet weak var signInWinstution: UISwitch!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var LogInWithFb: UIButton!
    @IBOutlet weak var LogInBtn: UIButton!
    @IBOutlet var MainView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        Utilities.fadedColor(MainView)
         Utilities.styleHollowButton(LogInBtn)
        // Do any additional setup after loading the view.
    }
    @IBAction func FaceBookLogInBtn(_ sender: Any) {
        print("yes")
      
    }
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
    @IBAction func LogInBtnPressed(_ sender: Any) {
        if (passwordTxt.text == "") || (usernameTxt.text == "")
        {
            let alert = UIAlertController(title: "خطأ", message: "احد الحقول فارغة يرجى ملئ جميع الحقول", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "تم", style: .cancel, handler: nil))
            self.present(alert, animated: true)
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
                              }else{
                                    print(user.name!)
                                Share.shared.userName = user.name!
                                self.dismiss(animated: true, completion: nil)
                              }
                          }
                      } else {
                           let alert = UIAlertController(title: "خطأ", message: "فشل في التحميل, تحقق من الاتصال بالانترنت", preferredStyle: .alert)
                                         alert.addAction(UIAlertAction(title: "تم", style: .cancel, handler: nil))
                          self.present(alert, animated: true)
                      }
                  }
        }
    
    }
       
    
    
    
    
    
  
}

