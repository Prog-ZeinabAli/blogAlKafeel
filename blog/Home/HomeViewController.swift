//
//  ViewController.swift
//  blog
//
//  Created by test1 on 4/6/20.
//  Copyright © 2020 test1. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController  {

    let tv : BlogViewController! = nil
  
    @IBOutlet weak var UIViewBlog: UIView!
    @IBOutlet weak var NewBlogBtn: UIButton!
    let transition = SlideInTransition()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        Utilities.CircledButton(NewBlogBtn)
       
        
    }
    
    
    @IBAction func menu(_ sender: Any) {
        guard let menuViewController = storyboard?.instantiateViewController(identifier: "MenuViewControlller") else {return}
              menuViewController.modalPresentationStyle = .overCurrentContext
              menuViewController.transitioningDelegate = self as UIViewControllerTransitioningDelegate
              present(menuViewController,animated: true)
    }
    
    @IBAction func AddPostTapped(_ sender: Any) {
        let flag =  UserDefaults.standard.object(forKey: "LoginFlag") as? String
                             if flag != "yes"
                             {
                               let alert = UIAlertController(title: "خطأ", message: "عذرا ، يجب عليك تسجيل الدخول اولا لكتابة مدونة", preferredStyle: .alert)
                               alert.addAction(UIAlertAction(title: "تم", style: .cancel, handler: nil))
                               self.present(alert, animated: true)
                             }else {
                                guard let menuViewController = self.storyboard?.instantiateViewController(identifier: "AddPost") else {return}
                                           self.present(menuViewController,animated: true)
        }
        
        }
    
    
    }
    
       
    



//extention for slide menu animation
extension HomeViewController : UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = true
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = false
        return transition
    }
        
}



