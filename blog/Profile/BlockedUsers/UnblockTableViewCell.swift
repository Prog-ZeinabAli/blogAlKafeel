//
//  UnblockTableViewCell.swift
//  blog
//
//  Created by turath alanbiaa on 7/10/20.
//  Copyright © 2020 test1. All rights reserved.
//

import UIKit
protocol UnblockIsClicked {
    func onClickCell(index : Int)
}

class UnblockTableViewCell: UITableViewCell {

    @IBOutlet weak var MainView: UIView!
    @IBOutlet weak var UserName: UILabel!
    var cellDelegate :UnblockIsClicked?
    var index : IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
  /*  @IBAction func UblockButton(_ sender: Any) {
        cellDelegate?.onClickCell(index: (index?.row)!)
    }*/
    
  

}
