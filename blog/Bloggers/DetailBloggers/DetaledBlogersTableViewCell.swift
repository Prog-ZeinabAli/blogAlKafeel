//
//  DetaledBlogersTableViewCell.swift
//  blog
//
//  Created by turath alanbiaa on 5/8/20.
//  Copyright © 2020 test1. All rights reserved.
//

import UIKit

protocol ButtonIsClicked {
    func onClickCell(index : Int)
}

class DetaledBlogersTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var tags: UIButton!
    @IBOutlet weak var date: UIButton!
    @IBOutlet weak var comment: UIButton!
    @IBOutlet weak var Views: UIButton!
    @IBOutlet weak var Content: UITextView!
    @IBOutlet weak var category: UIButton!
    
    var cellDelegate :ButtonIsClicked?
    var index : IndexPath?
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    
    @IBAction func catIsClicked(_ sender: Any) {
         cellDelegate?.onClickCell(index: (index?.row)!)
    }
    @IBAction func CommentIsClicked(_ sender: Any) {
         cellDelegate?.onClickCell(index: (index?.row)!)
     }
     @IBAction func ViewIsCicked(_ sender: Any) {
         cellDelegate?.onClickCell(index: (index?.row)!)
     }
     

}
