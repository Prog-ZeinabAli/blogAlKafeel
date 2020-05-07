//
//  ProfileTableViewCell.swift
//  blog
//
//  Created by turath alanbiaa on 4/30/20.
//  Copyright © 2020 test1. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var Content: UITextView!
    @IBOutlet weak var Title: UILabel!
    @IBOutlet weak var Date: UIButton!
    @IBOutlet weak var View: UIButton!
    @IBOutlet weak var noOfCmnt: UIButton!
    @IBOutlet weak var catBtn: UIButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
