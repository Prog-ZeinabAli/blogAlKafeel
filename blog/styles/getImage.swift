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

static func Image(from string: String) -> UIImage? {
    //2. Get valid URL
    guard let url = URL(string: "https://alkafeelblog.edu.turathalanbiaa.com/aqlam/image/" + string )
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

}
