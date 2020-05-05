//
//  ViewsViewController.swift
//  blog
//
//  Created by turath alanbiaa on 5/4/20.
//  Copyright © 2020 test1. All rights reserved.
//

import UIKit

class ViewsViewController: UIViewController {

    @IBOutlet weak var UserName: UILabel!
    @IBOutlet weak var contetn: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        UserName.text = Share.shared.Blogsusername
        contetn.text = Share.shared.Blogscontent
        // Do any additional setup after loading the view.
    }
    

  

}
