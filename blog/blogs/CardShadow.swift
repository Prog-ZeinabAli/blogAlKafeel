//
//  CardShadow.swift
//  blog
//
//  Created by test1 on 4/6/20.
//  Copyright © 2020 test1. All rights reserved.
//

import UIKit


//this class will add shadow to the view card to look as if it is a card
class CardShadow: UIView {

       override func layoutSubviews() {
        layer.cornerRadius = cornrerRadius
           layer.shadowColor = shadowColor.cgColor
           layer.shadowOffset = CGSize(width: shadowOffSetWidth, height: shadowOffSetHeight)
           let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornrerRadius)
           layer.shadowPath = shadowPath.cgPath
           layer.shadowOpacity = Float(shadowOpacity)
           
    }

    @IBInspectable var cornrerRadius : CGFloat = 25.0
        @IBInspectable var shadowOffSetWidth :CGFloat = 0
        @IBInspectable var shadowOffSetHeight : CGFloat = 5
        @IBInspectable  var shadowColor : UIColor = UIColor.black
        @IBInspectable var shadowOpacity : CGFloat = 0.5
        

      

}
