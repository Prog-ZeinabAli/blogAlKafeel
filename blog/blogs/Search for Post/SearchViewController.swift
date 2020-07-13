//
//  SearchViewController.swift
//  blog
//
//  Created by turath alanbiaa on 7/13/20.
//  Copyright © 2020 test1. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var Seacrhing: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        Seacrhing.delegate = self
    }
    

   func loadSearhResult(searchText : String) {
          
        /*  self.Loading.isHidden = false
          self.Loading.startAnimating()
              let json: [String: Any] = ["data": searchText]
             SearchDataServer.instance.Searching(json: json) { [weak self] (response) in
                                 if self == nil {return}
                                 if response.success {
                                 self!.blogger = (response.data!.data)!
                                 //self!.blogger as! [search] = self!.searchBlogger
                                   self!.tv.reloadData()
                                    self!.Loading.isHidden = true
                                    self!.Loading.stopAnimating()
                                     print("loading")
                                 }else {
                                     let alert = UIAlertController(title: "خطأ", message: "فشل في التحميل, تحقق من الاتصال بالانترنت", preferredStyle: .alert)
                                     alert.addAction(UIAlertAction(title: "تم", style: .cancel, handler: nil))
                                     self!.present(alert, animated: true)
                                 }
                             }
      }*/
    }

}
//MARK:-  Search for blogers
extension SearchViewController : UISearchBarDelegate
{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty == false
        {
            print("yessssss")
             // loadSearhResult(searchText: searchText)
        }
       
    }
}
