//
//  BMTableViewCell.swift
//  blog
//
//  Created by turath alanbiaa on 5/20/20.
//  Copyright © 2020 test1. All rights reserved.
//

import UIKit

protocol SeeMoreIsClicked {
    func onClickCell(index : Int)
}

class BMTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var content: UITextView!
    @IBOutlet weak var UserName: UILabel!
    
    var cellDelegate :SeeMoreIsClicked?
    var index : IndexPath?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func seeMorePressed(_ sender: Any) {
          cellDelegate?.onClickCell(index: (index?.row)!)
    }
    
}
