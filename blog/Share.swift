//
//  share.swift
//  blog
//
//  Created by turath alanbiaa on 4/27/20.
//  Copyright © 2020 test1. All rights reserved.
//

import Foundation
final class Share{
    static let shared = Share()
    var userName : String!
    var CmntUserName : String!
    var PostId : Int!
    var fontSize : Int!  //setting font size changing
    
    
    // hom etabl views detection
    var categoryId : Int? //category table view selection
    var sortby : Int? //category table view selection
    
    
    var FontChnaged : Int? //indicate if the font size has cahnged
}
