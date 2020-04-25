//
//  SignUpViewController.swift
//  blog
//
//  Created by test1 on 4/9/20.
//  Copyright © 2020 test1. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var SignUpBtn: UIButton!
    @IBOutlet weak var passwordRepeatTxt: UITextField!
    @IBOutlet var MainView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        Utilities.fadedColor(MainView)
        Utilities.styleHollowButton(SignUpBtn)

    
    }
    @IBAction func SignUpPressed(_ sender: Any) {
        if (nameTxt.text == "") || (usernameTxt.text == "") || (passwordTxt.text == "") || (passwordRepeatTxt.text == "")
               {
                   let alert = UIAlertController(title: "خطأ", message: "احد الحقول فارغة يرجى ملئ جميع الحقول", preferredStyle: .alert)
                   alert.addAction(UIAlertAction(title: "تم", style: .cancel, handler: nil))
                   self.present(alert, animated: true)
        } else if (passwordTxt.text != passwordRepeatTxt.text){
            let alert = UIAlertController(title: "خطأ", message: "كلمة السر غير مطابقة", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "تم", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
        else{
                   let json: [String: Any] = ["name": nameTxt.text as Any,"email": usernameTxt.text as Any , "password": passwordTxt.text as Any,]
            RegisterServer.instance.RegisterCheck(json:json) { [weak self] (response) in
                             guard let self = self else { return }
                             if response.success {
                                 if let user = response.data {
                                     if(user.message == "NOT FOUND")
                                     {
                                         let alert = UIAlertController(title: "خطأ", message: "خطأ في الرمز السري او المعرف", preferredStyle: .alert)
                                                        alert.addAction(UIAlertAction(title: "تم", style: .cancel, handler: nil))
                                         self.present(alert, animated: true)
                                     }else{
                                        let alert = UIAlertController(title: " \(user.name)تم التسجيل ", message: "لقد تم تسجيلك في مدونة الكفيل", preferredStyle: .alert)
                                                          alert.addAction(UIAlertAction(title: " شكرآ", style: .cancel, handler: nil))
                                           self.present(alert, animated: true)
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
