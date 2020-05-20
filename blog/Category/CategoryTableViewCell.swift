//
//  CategoryTableViewCell.swift
//  blog
//
//  Created by test1 on 4/8/20.
//  Copyright © 2020 test1. All rights reserved.
//

import UIKit

protocol CategoryTypeIsClicked {
     func onClickCell(index : Int)
}

class CategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var btn: UIButton!
    
    var cellDelegate :CategoryTypeIsClicked?
    var index : IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    @IBAction func CatogryTapped(_ sender: Any) {
          cellDelegate?.onClickCell(index: (index?.row)!)
    }
    
}
