//
//  BlogViewController.swift
//  blog
//
//  Created by test1 on 4/6/20.
//  Copyright © 2020 test1. All rights reserved.
//

import UIKit

class BlogViewController: UIViewController {
    var posts: [Post] = []
    @IBOutlet var tv: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tv.delegate = self
        tv.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    
    override func didReceiveMemoryWarning() {
                 super.didReceiveMemoryWarning()
             }
          
          override func viewWillAppear(_ animated: Bool) {
              super.viewWillAppear(true)

              PostDataServer.instance.fetchAllPosts { [weak self] (response) in
                  if self == nil {return}
                  if response.success {
                      self!.posts = response.data!
                      self!.tv.reloadData()
                  }else {
                      let alert = UIAlertController(title: "خطأ", message: "فشل في التحميل, تحقق من الاتصال بالانترنت", preferredStyle: .alert)
                      alert.addAction(UIAlertAction(title: "تم", style: .cancel, handler: nil))
                      self!.present(alert, animated: true)
                  }
              }
          }

   

}


extension BlogViewController: UITableViewDataSource, UITableViewDelegate {

       public func numberOfSections(in tableView: UITableView) -> Int {
           return 1
       }

       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           print(posts.count)
           return posts.count
       }

       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! BlogCardTableViewCell
        
            cell.title.text = posts[indexPath.row].title
          Utilities.fadedColor(cell.TitleUiView)
        cell.content.text = posts[indexPath.row].contnet
            //cell.imageView?.image = UIImage(contentsOfFile: posts[indexPath.row].image)
           return cell
       }


       func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
           return UIView()
       }

       func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 500
       }


   }

