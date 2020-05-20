//
//  CategoryViewController.swift
//  blog
//
//  Created by test1 on 4/8/20.
//  Copyright © 2020 test1. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController {
    @IBOutlet weak var tv: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tv.delegate = self
        tv.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
         super.didReceiveMemoryWarning()
     }
     override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(true)
         DataService.instance.fetchAllCategories { (success) in
             if success {
                 self.tv.reloadData()
             }
            else {
                let alert = UIAlertController(title: "خطأ", message: "فشل في التحميل, تحقق من الاتصال بالانترنت", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "تم", style: .cancel, handler: nil))
                self.present(alert, animated: true)
                self.viewDidLoad()
            }
         }
     }

}
 





// Extention for catgeories slideDown menu
extension CategoryViewController:UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        DataService.instance.categories.count
    }
    
    
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CategoryTableViewCell
        cell.btn.setTitle( DataService.instance.categories[indexPath.row].categoryName,for: .normal)
        Utilities.styleHollowButton(cell.btn)
          cell.index = indexPath
        cell.cellDelegate = self as CategoryTypeIsClicked 
        

          return cell
      }
      

    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
}



extension CategoryViewController: CategoryTypeIsClicked{
    func onClickCell(index: Int) {
        let catId = DataService.instance.categories[index].id ?? 0
        Share.shared.categoryId = catId
        Share.shared.sortby = 1
        Share.shared.FromCtegoryVC = "yes"
        print(Share.shared.categoryId)
    }
    
}
