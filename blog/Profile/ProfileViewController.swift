//
//  ProfileViewController.swift
//  blog
//
//  Created by turath alanbiaa on 4/28/20.
//  Copyright © 2020 test1. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var noOfBlogs: UILabel!
    var nob = ""
    var profiles: [Profile] = []
    @IBOutlet weak var tv: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tv.delegate = self
        tv.dataSource = self
        // Do any additional setup after loading the view.
        noOfBlogs.text = nob
    }
    

 
   override func didReceiveMemoryWarning() {
                super.didReceiveMemoryWarning()
            }
         
         override func viewWillAppear(_ animated: Bool) {
             super.viewWillAppear(true)
           
            let json: [String: Any] = ["user_id":691311583402731]//Share.shared.PostId as Any]
                      ProfiletDataServer.instance.fetchAllProfile(json:json ) { [weak self] (response) in
                           if self == nil {return}
                           if response.success {
                            self!.profiles = [response.data!]
                               self!.tv.reloadData()
                           }else {
                               let alert = UIAlertController(title: "خطأ", message: "فشل في التحميل, تحقق من الاتصال بالانترنت", preferredStyle: .alert)
                               alert.addAction(UIAlertAction(title: "تم", style: .cancel, handler: nil))
                               self!.present(alert, animated: true)
                           }
                       }
                   }


}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {

   public func numberOfSections(in tableView: UITableView) -> Int {
       return 1
   }

   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       print(profiles.count)
       return profiles.count
   }

   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProfileTableViewCell
    nob = profiles[indexPath.row].createdAt ?? "data"
    cell.Title.text = profiles[indexPath.row].title
    
    cell.Content.text = profiles[indexPath.row].content
            
       return cell
   }


   func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
       return UIView()
   }

   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 500
   }
}

