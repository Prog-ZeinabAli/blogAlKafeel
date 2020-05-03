//
//  AddPostViewController.swift
//  blog
//
//  Created by turath alanbiaa on 5/3/20.
//  Copyright © 2020 test1. All rights reserved.
//

import UIKit

class AddPostViewController: UIViewController {

    @IBOutlet weak var BlogContent: UITextView!
    @IBOutlet weak var BlogTitle: UITextField!
    @IBOutlet weak var BlogTags: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    @IBAction func sendPost(_ sender: Any) {
        
        let json: [String: Any] = ["user_id": 691311583402731,"title": "yes","content":"yop thats content","tags": "me","category_id": 3 ,"input_img": "image.png" ]
        AddPostDateServer.instance.sendPost(json:json) { [weak self] (response) in
                        guard self != nil else { return }
                               if response.success {
                        print(response)
           }
                        
    }
    }
    
   
    
  

}
