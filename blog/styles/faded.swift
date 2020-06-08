//
//  faded.swift
//  blog
//
//  Created by turath alanbiaa on 6/1/20.
//  Copyright © 2020 test1. All rights reserved.
//

import UIKit

class faded: UIView {

       override func layoutSubviews() {
        // layer.cornerRadius = cornrerRadius
      //  layer.backgroundColor = [UIColor.black].CGColor
      //  layer.backgroundColor = UIColor.black as? CGColor //shadowColor.cgColor//[colorTeal , colorWhite] as! CGColor
          //  layer.shadowColor = shadowColor.cgColor
          //  layer.shadowOffset = CGSize(width: shadowOffSetWidth, height: shadowOffSetHeight)
         //   let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornrerRadius)
      //      layer.shadowPath = shadowPath.cgPath
       //     layer.shadowOpacity = Float(shadowOpacity)
            
     }

     @IBInspectable var cornrerRadius : CGFloat = 25.0
         @IBInspectable var shadowOffSetWidth :CGFloat = 0
         @IBInspectable var shadowOffSetHeight : CGFloat = 5
    @IBInspectable  var colorTeal : CGColor = UIColor(red: 82/255.0, green: 123/255.0, blue: 79/255.0, alpha: 1.0).cgColor
    @IBInspectable  var colorWhite : CGColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0).cgColor
         @IBInspectable var shadowOpacity : CGFloat = 0.5
         
    
  

       

}
