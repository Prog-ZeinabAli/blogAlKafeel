//
//  ReportViewController.swift
//  blog
//
//  Created by turath alanbiaa on 6/23/20.
//  Copyright © 2020 test1. All rights reserved.
//

import UIKit

class ReportViewController: UIViewController {

 
    override func viewDidLoad() {
        super.viewDidLoad()
   
       
    }
    

    @IBAction func Close(_ sender: Any) {
         guard let menuViewController = self.storyboard?.instantiateViewController(identifier: "NavigationController") else {return}
              self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    

}
