//
//  getImage.swift
//  blog
//
//  Created by turath alanbiaa on 5/27/20.
//  Copyright © 2020 test1. All rights reserved.
//

import Foundation
import UIKit

class Get{
    
    

static func Image(from string: String)  -> UIImage? {
    let urlString = "https://alkafeelblog.edu.turathalanbiaa.com/aqlam/image/" + string
           guard let url = URL(string: urlString)
               else{
                   return nil }
           var image: UIImage? = nil
           do {
               let data = try Data(contentsOf: url, options: [])
               image = UIImage(data: data)
           }
           catch {
               print(error.localizedDescription)
           }

           return image
    }

    
   


    
    static func Picture(from string: String) -> UIImage? {
        //2. Get valid URL
        guard let url = URL(string: string )
            else{
                return nil }
        var image: UIImage? = nil
        do {
            let data = try Data(contentsOf: url, options: [])
            image = UIImage(data: data)
        }
        catch {
            print(error.localizedDescription)
        }

        return image
    }
    

static func NightMode(from string: UIViewController) {

if UserDefaults.standard.object(forKey: "NightMode") as? String  == "True"
           {
            string.overrideUserInterfaceStyle = .dark
           }else{
           string.overrideUserInterfaceStyle = .light
           }
          
}
    
    static func BtnNightMode(from string: UIButton) {

    if UserDefaults.standard.object(forKey: "NightMode") as? String  == "True"
               {
                string.overrideUserInterfaceStyle = .dark
               }else{
               string.overrideUserInterfaceStyle = .light
               }
              
    }
    
  
    

     
}
