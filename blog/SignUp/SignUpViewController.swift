//
//  SignUpViewController.swift
//  blog
//
//  Created by test1 on 4/9/20.
//  Copyright © 2020 test1. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var SignUpBtn: UIButton!
    @IBOutlet var MainView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        Utilities.fadedColor(MainView)
        Utilities.styleHollowButton(SignUpBtn)

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
