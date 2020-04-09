//
//  CategoryViewController.swift
//  blog
//
//  Created by test1 on 4/8/20.
//  Copyright © 2020 test1. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController {
let x = ["selam","olsun","benim","arkadashalar"]
    @IBOutlet weak var tv: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tv.delegate = self
        tv.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    //both bring the data out on the tableview
    override func didReceiveMemoryWarning() {
         super.didReceiveMemoryWarning()
     }
     override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(true)
         DataService.instance.fetchAllCategories { (success) in
             if success {
                 self.tv.reloadData()
             }
         }
     }

}
 





// Extention for catgeories slideDown menu
extension CategoryViewController:UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print(DataService.instance.categories.count)
        //return DataService.instance.categories.count
        return x.count
    }
    
    
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CategoryTableViewCell
      //  cell.textLabel?.text = DataService.instance.categories[indexPath.row].categoryName
        cell.btn.setTitle(x[indexPath.row],for: .normal)
        Utilities.styleHollowButton(cell.btn)
          print(cell)
        

          return cell
      }
      

    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
}

