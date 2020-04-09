//
//  BlogCardTableViewCell.swift
//  blog
//
//  Created by test1 on 4/6/20.
//  Copyright © 2020 test1. All rights reserved.
//

import UIKit

class BlogCardTableViewCell: UITableViewCell {

    @IBOutlet var content: UITextView!
    @IBOutlet var UserName: UILabel!
    @IBOutlet var title: UILabel!
    @IBOutlet weak var PersonalImg: UIImageView!
    @IBOutlet weak var PostImage: UIImageView!
    @IBOutlet weak var NumView: UILabel!
    @IBOutlet weak var TagButton: UIButton!
    
    @IBOutlet weak var TitleUiView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBDesignable class CardView: UIView {
          
          @IBInspectable var cornrerRadius : CGFloat = 2
          @IBInspectable var shadowOffSetWidth :CGFloat = 0
          @IBInspectable var shadowOffSetHeight : CGFloat = 5
          @IBInspectable  var shadowColor : UIColor = UIColor.black
          @IBInspectable var shadowOpacity : CGFloat = 0.5
          

          override func layoutSubviews() {
              //add shadow
              layer.cornerRadius = cornrerRadius
              layer.shadowColor = shadowColor.cgColor
              layer.shadowOffset = CGSize(width: shadowOffSetWidth, height: shadowOffSetHeight)
              let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornrerRadius)
              layer.shadowPath = shadowPath.cgPath
              layer.shadowOpacity = Float(shadowOpacity)
              
          
      }

}
}
