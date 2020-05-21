//
//  BlogCardTableViewCell.swift
//  blog
//
//  Created by test1 on 4/6/20.
//  Copyright © 2020 test1. All rights reserved.
//

import UIKit

protocol CommentIsClicked {
    func onClickCell(index : Int)
}


class BlogCardTableViewCell: UITableViewCell {

    @IBOutlet weak var BookMarkSaved: UIButton!
    @IBOutlet weak var PersonalImg: UIButton!
    @IBOutlet weak var Date: UILabel!
    @IBOutlet var content: UITextView!
    @IBOutlet var UserName: UILabel!
    @IBOutlet var title: UILabel!
    @IBOutlet weak var PostImage: UIImageView!
    @IBOutlet weak var NumView: UILabel!
    @IBOutlet weak var TagButton: UIButton!
    @IBOutlet weak var CommentCount: UILabel!
    @IBOutlet weak var TitleUiView: UIView!
    
    var cellDelegate :CommentIsClicked?
    var index : IndexPath?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func CommentBtnClicked(_ sender: Any) {
        cellDelegate?.onClickCell(index: (index?.row)!)
    }
    @IBAction func ViewsBtnClicked(_ sender: Any) {
         cellDelegate?.onClickCell(index: (index?.row)!)
    }
    
    @IBAction func ProfileBtnClicked(_ sender: Any) {
         cellDelegate?.onClickCell(index: (index?.row)!)
    }
    
    @IBAction func BookMarkPressed(_ sender: Any) {
        cellDelegate?.onClickCell(index: (index?.row)!)
    }
}

