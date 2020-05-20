//
//  BookMarkViewController.swift
//  blog
//
//  Created by turath alanbiaa on 5/19/20.
//  Copyright © 2020 test1. All rights reserved.
//

import UIKit
import CoreData

class BookMarkViewController: UIViewController {

    
    var BM = [BookMarksCore]()
    @IBOutlet weak var tv: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tv.delegate = self
        tv.dataSource = self
        
        
        let fetchRequest : NSFetchRequest<BookMarksCore> = BookMarksCore.fetchRequest()

        do {
            let BM = try PressitentServer.context.fetch(fetchRequest)
            self.BM = BM
            self.tv.reloadData()
            
        }catch{}
    }
    
    
    override func didReceiveMemoryWarning() {
                      super.didReceiveMemoryWarning()
                  }

    override func viewWillAppear(_ animated: Bool) {
                  super.viewWillAppear(true)
    }

}


extension BookMarkViewController:UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  BM.count
    }
    
    
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! BMTableViewCell
        
        
        cell.UserName.text = BM[indexPath.row].nameBM
        cell.title.text = BM[indexPath.row].titleBM
        cell.content.text = BM[indexPath.row].contentBM
          return cell
      }
      

    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView( _ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
       // Share.shared.userId =  Blogger[indexPath.row].id
    }
    
    
}
