//
//  DetaledBlogersTableViewCell.swift
//  blog
//
//  Created by turath alanbiaa on 5/8/20.
//  Copyright © 2020 test1. All rights reserved.
//

import UIKit

class DetaledBlogersTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var tags: UIButton!
    @IBOutlet weak var date: UIButton!
    @IBOutlet weak var comment: UIButton!
    @IBOutlet weak var Views: UIButton!
    @IBOutlet weak var Content: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
