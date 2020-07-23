//
//  MenuViewController.swift
//  blog
//
//  Created by test1 on 4/7/20.
//  Copyright © 2020 test1. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
      
 
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var SignUpButton: UIButton!
    @IBOutlet weak var SignInButton: UIButton!
    @IBOutlet weak var UserNameLabel: UILabel!
    @IBOutlet weak var PersonalImg: UIButton!
    let transition = SlideInTransition()
    var search = false
    
    override func viewDidLayoutSubviews() {
        Utilities.fadedColor(profileView)
    }
        override func viewDidLoad() {
            Get.NightMode(from: self)
                      
            
            super.viewDidLoad()
           let name :String = UserDefaults.standard.object(forKey: "loggesUserName") as? String ?? "ضيف"
          // let pic = Share.shared.picture ??  "PersonalImg"
            UserNameLabel.text = name
         //   PersonalImg.imageView = UIImage(UIImage(named:"PersonalImg"))
    
        //MARK:- LOG_IN & LOG_OUT ACTIONS
            let flag =  UserDefaults.standard.object(forKey: "LoginFlag") as? String
            if flag == "yes"
            {
                SignUpButton.isHidden = true
                SignInButton.setTitle(" تسجيل خروج"  ,for: .normal)
                search = true

             //   viewDidLoad()
                
            }else{
                SignInButton.setTitle("تسجيل دخول" ,for: .normal)
                SignUpButton.isHidden = false

            }
            
            
            
        // MARK:- hide when tapping anywhere
                    let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideEveryThing))
                    view.addGestureRecognizer(tap)
            
            
        }
    
    
    @objc func hideEveryThing(){
         guard let menuViewController = self.storyboard?.instantiateViewController(identifier: "MenuViewControlller") else {return}
                     self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
         }
    
    
    @IBAction func ProfileIsCicked(_ sender: Any) {
        let flag =  UserDefaults.standard.object(forKey: "LoginFlag") as? String
                                    if flag != "yes"
                                    {
                                      let alert = UIAlertController(title: "خطأ", message: "عذرا ، يجب عليك تسجيل الدخول اولا ", preferredStyle: .alert)
                                      alert.addAction(UIAlertAction(title: "تم", style: .cancel, handler: nil))
                                      self.present(alert, animated: true)
                                    }else {
                                       guard let menuViewController = self.storyboard?.instantiateViewController(identifier: "Profile") else {return}
                                                  self.present(menuViewController,animated: true)
               }
    }
    
    
    func reNew(){
        //reload application data (renew root view )
        UIApplication.shared.keyWindow?.rootViewController = storyboard!.instantiateViewController(withIdentifier: "MenuViewControlller")
    }
    
    
        
    @IBAction func HomeIsTapped(_ sender: Any) {
            dismiss(animated: true)
    }
 
    @IBAction func LogInButton(_ sender: Any) {
        //reNew()
         let flag =  UserDefaults.standard.object(forKey: "LoginFlag") as? String
         if flag == "yes"
        {
                                    UserDefaults.standard.set("no", forKey: "LoginFlag")
                                    UserDefaults.standard.set("", forKey: "loggesUserName")
                                    UserDefaults.standard.set("", forKey: "loggesUserID")
           
                                                   
            
            guard let menuViewController = self.storyboard?.instantiateViewController(identifier: "MenuViewControlller") else {return}
             self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
            
         }else{
     guard let menuViewController = storyboard?.instantiateViewController(identifier: "LogInView") else {return}
                  present(menuViewController,animated: true)
    }
    }
    
    @IBAction func SearchIsTapped(_ sender: Any) {
        
            if search {
                Share.shared.SearchView = true
                self.performSegue(withIdentifier: "ValidationSucceeded", sender: self)
            } else {
                 let alert = UIAlertController(title: "خطأ", message: "عذرا ، يجب عليك تسجيل الدخول اولا  ", preferredStyle: .alert)
                           alert.addAction(UIAlertAction(title: "تم", style: .cancel, handler: nil))
                           self.present(alert, animated: true)
            }
        
      
    }
   @IBAction func BookMarkTapped(_ sender: Any) {
        let alert = UIAlertController(title: "عذرا", message: "هذة الخاصية غير متوفرة حاليا ..سيتم تفعيل هذه الخاصية في النسخة القادمة", preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: "تم", style: .cancel, handler: nil))
               self.present(alert, animated: true)
    }
}




    //extention for slide menu animation
    extension MenuViewController : UIViewControllerTransitioningDelegate {
        func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
            transition.isPresenting = true
            return transition
        }
        
        func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
            transition.isPresenting = false
            return transition
        }
            
    }
