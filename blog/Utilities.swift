//
//  Utilities.swift
//  blog
//
//  Created by test1 on 4/6/20.
//  Copyright © 2020 test1. All rights reserved.
//

import Foundation
import UIKit

class Utilities {
    
    
    //styling textFields
    static func styleTextField(_ textfield:UITextField){
        
        
        //create the bottom line
        let bottomLine = CALayer()
        
        bottomLine.frame = CGRect(x: 0, y: textfield.frame.height-2, width: textfield.frame.width ,height: 2)
        
        bottomLine.backgroundColor = UIColor.init(red: 48/255, green:173/255 , blue: 99/255 ,alpha: 1).cgColor
        
        
        //remove textfields borders
        textfield.borderStyle = .none
        
        //add line to the text field
        textfield.layer.addSublayer(bottomLine)
        
    }
    
  //styling hollow buttons
    static func styleHollowButton(_ button: UIButton){
        //holow rounded corners
        button.layer.borderWidth = 2
//        button.layer.borderColor = (UIColor.init(red: 82/255.0, green: 123/255.0, blue: 79/255.0, alpha: 1.0) as! CGColor)
        button.layer.cornerRadius = 12.0
        button.tintColor = UIColor.black
    }
    
    //styling view
    static func styleView(_ view: UIView){
           //holow rounded corners
        view.layer.backgroundColor = (UIColor.init(red: 82/255.0, green: 123/255.0, blue: 79/255.0, alpha: 1.0) as! CGColor)
       }
       
    
    
    //styling filled buttons
    static func styleFilledButton(_ button: UIButton){
        //filling rounded corners
        button.backgroundColor = UIColor.init(red: 82/255.0, green: 123/255.0, blue: 79/255.0, alpha: 1.0)
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.white
    }
    

   static func isPasswordValid(_ password : String) -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@","^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password )
    }
    
    
    static func fadedColor(_ hi: UIView) {
          let colorTeal =  UIColor(red: 82/255.0, green: 123/255.0, blue: 79/255.0, alpha: 1.0).cgColor
          let colorWhite = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0).cgColor
            let gradLayer = CAGradientLayer()
            gradLayer.colors = [colorTeal, colorWhite]
            gradLayer.locations = [0.0, 1.0]
            gradLayer.frame = hi.bounds
            hi.layer.insertSublayer(gradLayer, at:0)
        }
    
    static func TitlefadedColor(_ hi: UIView) {
      let colorTeal =  UIColor(red: 82/255.0, green: 123/255.0, blue: 79/255.0, alpha: 1.0).cgColor
      let colorWhite = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0).cgColor
        let gradLayer = CAGradientLayer()
        gradLayer.colors = [colorTeal, colorWhite]
        gradLayer.locations = [0.0, 1.0]
        gradLayer.cornerRadius = 25.0
        gradLayer.frame = hi.bounds
        hi.layer.insertSublayer(gradLayer, at:0)
    }
    static func RoundedCorners(_ hi: UIView) {
        let gradLayer = CAGradientLayer()
        gradLayer.cornerRadius = 25.0
           gradLayer.borderWidth = 2
                 gradLayer.borderColor = UIColor.black.cgColor
                 gradLayer.cornerRadius = 25.0
        }
    
}

