//
//  ViewController.swift
//  blog
//
//  Created by test1 on 4/6/20.
//  Copyright © 2020 test1. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    let x = ["hi","jd","ho"]
     let x1 = ["hi","jd","ho"]
    @IBOutlet weak var BlogTv: UITableView!
    @IBOutlet weak var CatgTv: UITableView!
    let transition = SlideInTransition()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CatgTv.delegate = self
        CatgTv.dataSource = self
        BlogTv.delegate =  self
        BlogTv.dataSource = self
    }

    @IBAction func menu(_ sender: Any) {
        guard let menuViewController = storyboard?.instantiateViewController(identifier: "MenuViewControlller") else {return}
              menuViewController.modalPresentationStyle = .overCurrentContext
              menuViewController.transitioningDelegate = self as UIViewControllerTransitioningDelegate
              present(menuViewController,animated: true)
    }
    
    
    @IBAction func CategoryButtonPressed(_ sender: Any) {
        if self.CatgTv.isHidden == true {
                     self.CatgTv.isHidden = false
                 }
                 else {
                        self.CatgTv.isHidden = true
            }
    }
    
    @IBAction func LatestBlogButtonPressed(_ sender: Any) {
        if self.BlogTv.isHidden == true {
                             self.BlogTv.isHidden = false
                         }
                         else {
                                self.BlogTv.isHidden = true
                    }
    }
    
    
    
    //both bring the data out on the tableview
       override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
        }
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(true)
            DataService.instance.fetchAllCategories { (success) in
                if success {
                    self.CatgTv.reloadData()
                }
            }
        }
       
    
}



//extention for slide menu animation
extension HomeViewController : UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = true
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = false
        return transition
    }
        
}


// Extention for catgeories slideDown menu
extension HomeViewController:UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (tableView.tag == 1)
        {
           //return DataService.instance.categories.count
             return x1.count
        }
        else if( tableView.tag == 2)
        {
            return x.count
        }
        else{
            return 0
        }
    }
    
    
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if(tableView.tag == 1)
        {
           // cell.textLabel?.text = DataService.instance.categories[indexPath.row].categoryName
            cell.textLabel?.text = x1[indexPath.row]
        }
        else if (tableView.tag == 2)
        {
            cell.textLabel?.text = x[indexPath.row]
        }
          
          print(cell)
          return cell
      }
      

    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    
}


