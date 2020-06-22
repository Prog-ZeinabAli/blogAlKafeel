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

    var blogIndex :Int!
    var BMBlog : NSManagedObject!
    var deleteRow = false
    static var indexes : IndexPath!
    var BM = [BookMarksCore]()
    @IBOutlet weak var tv: UITableView!
    
    override func viewDidLoad() {
        Get.NightMode(from: self)
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
    
    @IBAction func SeeMoreTapped(_ sender: Any) {
        Share.shared.BookMarked = true
    }
    
    
    @IBAction func BookMarksIsTapped(_ sender: Any) {
        PressitentServer.context.delete(BMBlog)
        BM.remove(at: blogIndex)
        tv.beginUpdates()
        let indexPath = IndexPath(row: blogIndex, section: 0)
        tv.deleteRows(at: [indexPath], with: .automatic)
        tv.endUpdates()
        PressitentServer.saveContext()
        deleteRow = true
        
        
       
        
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
        
        cell.index = indexPath
        cell.cellDelegate = self //as SeeMoreIsClicked?
        
        //TODO:- delete row at index path
        
        return cell
      }
   


    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    
    
}


extension BookMarkViewController : SeeMoreIsClicked{
    func onClickCell(index: Int) {
        BMBlog = BM[index]
        blogIndex = index
        
        Share.shared.Blogscontent = BM[index].contentBM
        Share.shared.Blogsusername = BM[index].nameBM
        Share.shared.title = BM[index].titleBM
        
    }
    
    
}
