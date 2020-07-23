//
//  PrivacyPolicyViewController.swift
//  blog
//
//  Created by turath alanbiaa on 7/14/20.
//  Copyright © 2020 test1. All rights reserved.
//

import UIKit

class PrivacyPolicyViewController: UIViewController {

    var check = 0
    @IBOutlet weak var NextBtn: UIButton!
    @IBOutlet weak var CheckButtonView: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        Utilities.styleHollowButton(NextBtn)
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func CheckButton(_ sender: Any) {
        if check == 0{
            CheckButtonView.setImage(UIImage(systemName: "checkmark.square"), for: .normal )
            CheckButtonView.tintColor = UIColor(red: 82/255.0, green: 123/255.0, blue: 79/255.0, alpha: 1.0)
            check = 1
        }
        else{
            CheckButtonView.setImage(UIImage(systemName: "stop"), for: .normal )
            CheckButtonView.tintColor = UIColor(red: 82/255.0, green: 123/255.0, blue: 79/255.0, alpha: 1.0)
            check = 0
        }
        
    
    }
    
    @IBAction func NextTapped(_ sender: Any) {
        if check == 0 {
             CheckButtonView.tintColor = UIColor(red: 255/255.0, green: 12/255.0, blue: 7/255.0, alpha: 1.0)
        }else{
            guard let menuViewController = self.storyboard?.instantiateViewController(identifier: "SignUp") else {return}
            self.present(menuViewController,animated: true)
        }
    }
   

}
