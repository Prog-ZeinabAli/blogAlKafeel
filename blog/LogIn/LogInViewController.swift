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
    var loginCheck: [logInVars] = []
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
    @IBAction func LogInBtnPressed(_ sender: Any) {
        let json: [String: Any] = ["password": passwordTxt.text,"email": usernameTxt.text , "db":0]
        
        LogInServer.instance.LogInCheck(json: json) { [weak self] (response) in
            if self == nil {return}
            if response.success {
                self!.loginCheck = (response.data!.data)!
                print(response.data!.data)
                
           /*     if (self!.loginCheck[0].id) != 0{
                    print("\(self!.loginCheck[1].name)")
                    print("yeah")
            }//you were thnking about a way to hget th id out and print it */
            
        }else {
                        let alert = UIAlertController(title: "خطأ", message: "فشل في التحميل, تحقق من الاتصال بالانترنت", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "تم", style: .cancel, handler: nil))
                        self!.present(alert, animated: true)
                    }
                }
}
        
        
 /*       let x = Alamofire.request("https://blog-api.turathalanbiaa.com/api/loginuser", method: .post, parameters: json, encoding: JSONEncoding.default)
            .responseJSON { (response) in
                if response.result.isSuccess{
                    print(response)
                }
                else{
                    print("error")
                }
        }
        
       */
  
}

