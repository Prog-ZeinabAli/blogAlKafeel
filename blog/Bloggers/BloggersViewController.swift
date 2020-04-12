//
//  BloggersViewController.swift
//  blog
//
//  Created by test1 on 4/10/20.
//  Copyright © 2020 test1. All rights reserved.
//

import UIKit

class BloggersViewController: UIViewController {
    let x = ["bloger1","bloger2","bloger3"]
    @IBOutlet weak var tv: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tv.delegate = self
        tv.dataSource = self
    }
    

  

}




// Extention for catgeories slideDown menu
extension BloggersViewController:UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return x.count
    }
    
    
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! BloggersTableViewCell
        cell.UserName.text = x[indexPath.row]
        Utilities.TitlefadedColor(cell.MainView)
          return cell
      }
      

    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    
    
}


