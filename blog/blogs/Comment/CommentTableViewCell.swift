//
//  CommentTableViewCell.swift
//  blog
//
//  Created by turath alanbiaa on 4/27/20.
//  Copyright © 2020 test1. All rights reserved.
//

import UIKit

protocol DeleteButtonIsClicked {
    func onClickCell(index : Int)
}


class CommentTableViewCell: UITableViewCell {

    @IBOutlet weak var DeleteButtonView: UIButton!
    @IBOutlet weak var comment: UITextView!
    @IBOutlet weak var Date: UILabel!
    @IBOutlet weak var Username: UILabel!
    
    var cellDelegate :DeleteButtonIsClicked?
     var index : IndexPath?
     
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func DeleteBtnClicked(_ sender: Any) {
           cellDelegate?.onClickCell(index: (index?.row)!)
      }

}
