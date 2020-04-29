//
//  SettingsViewController.swift
//  blog
//
//  Created by turath alanbiaa on 4/29/20.
//  Copyright © 2020 test1. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var FontSizeLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func FontSizeStepper(_ sender: UIStepper) {
        let x = CGFloat(sender.value)
       FontSizeLabel.font = UIFont.italicSystemFont(ofSize: x)
    //   FontSizeLabel.text = String(sender.value)
    
    }
    

    @IBAction func Save(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
