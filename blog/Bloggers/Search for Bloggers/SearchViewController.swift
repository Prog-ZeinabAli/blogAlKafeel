//
//  SearchViewController.swift
//  blog
//
//  Created by turath alanbiaa on 5/30/20.
//  Copyright © 2020 test1. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    @IBOutlet weak var seacrh: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func sendSEacrh(_ sender: Any) {
        Share.shared.SearchRslt = seacrh.text
    }
    
}
