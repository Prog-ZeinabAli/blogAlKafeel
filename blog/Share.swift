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
    
    //MARK:- LOGIN VARIABLES
    var userName : String!
    var userId : Int?
    var PostId : Int!
    var email : String!
    var picture : String!
   
    //MARK:- update post
    var updatePost = 0
    var content : String!
    var title : String!
    var cat : String!
    var image : String!
    var tag : String!
    
    
    
    
    var fontSize : Int!  //setting font size changing
    var CmntUserName : String!
    
    
    // hom etabl views detection
    var categoryId : Int? //category table view selection
    var sortby : Int? //category table view selection
    var changed_happend : Int?
    
    //setting
    var FontChnaged : Int? //indicate if the font size has cahnged
    
    //views
    var Blogsusername : String!
    var Blogscontent : String!
    
    
}
