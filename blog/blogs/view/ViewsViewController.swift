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
    @IBOutlet weak var Posttitle: UILabel!
    @IBOutlet weak var content: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let json: [String: Any] = ["id": Share.shared.PostId as Any]
               updateViewDataServer.instance.Updating(json: json)
                          { [weak self] (response) in
                              if self == nil {return}
                              if response.success {
                                if let user = response.data {
                                if(user.message == "update DONE"){
                                      print("views are updated")
                                    }
                                    else if (user.message == "NOT FOUND")
                                {
                                    self?.dismiss(animated: true, completion: nil)
                                    
                                    }
                              }else {
                                  let alert = UIAlertController(title: "خطأ", message: "فشل في التحميل, تحقق من الاتصال بالانترنت", preferredStyle: .alert)
                                  alert.addAction(UIAlertAction(title: "تم", style: .cancel, handler: nil))
                                  self!.present(alert, animated: true)
                                  self?.dismiss(animated: true, completion: nil)
                              }
                          }
        }
        
        
        Get.NightMode(from: self)
        //change according to settings
               let FZ = UserDefaults.standard.object(forKey: "FontSizeDefault") as? CGFloat //CGFloat(Share.shared.fontSize ?? 17)
                   content.font = UIFont.italicSystemFont(ofSize: FZ ?? 13)
               let FT =  UserDefaults.standard.object(forKey:"FontTypeDefault") as? String
                   content.font = UIFont(name: FT ?? "Lateef", size: FZ ?? 13)
                   Posttitle.font = UIFont(name: FT ?? "Lateef", size: 30)
        
        
        UserName.text = Share.shared.Blogsusername
        content.text = Share.shared.Blogscontent
        Posttitle.text = Share.shared.title
        // Do any additional setup after loading the view.
    }
    

  

}
