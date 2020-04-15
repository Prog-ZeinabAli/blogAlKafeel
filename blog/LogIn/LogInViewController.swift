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

class LogInViewController: UIViewController {

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
    /*
    @IBAction func LogInByFB(_ sender: Any) {
        let manager = LoginManager()
                manager.logIn(permissions: [.publicProfile, .email], viewController: self)
                {
                    (Result) in switch Result
                    {
                    case.cancelled:
                        print("user cancelled process")
                        break
                    case.failed(let error):
                        print("failed \(error)")
                        break
                    case.success(granted: let grant, declined: let dec, token: let token):
                        print("access token \(token)")
                        
                        
                        
                }
    }
    
} */
}
