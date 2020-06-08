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
    var imagePath = "https://alkafeelblog.edu.turathalanbiaa.com/aqlam/image/"
    
    //MARK:- LOGIN VARIABLES
    var userName : String!
    var  FBuserId : String!
    var userId : Int?
    var PostId : Int?
    var email : String!
    var picture : String!
    var loggedIn : String!
   
    //MARK:- update post
    var updatePost = 0
    var content : String!
    var title : String!
    var cat : String!
    var image : String!
    var tag : String!
    

        //MARK:- seacrh
       var SearchView : Bool = false
    
    var fontSize : Int!  //setting font size changing
    var CmntUserName : String!
    
    
    // home ttabl views detection
    var categoryId : Int? //category table view selection
    var FromCtegoryVC : String = "No"
    var catChosen : Bool = false
    var sortby : Int? //category table view selection
    var changed_happend : Int?
    
    //setting
    var FontChnaged : Int? //indicate if the font size has cahnged
    
    //views
    var Blogsusername : String!
    var Blogscontent : String!
    
    //BookMark for views
    var BookMarked : Bool! = false
    
    
}
/* variables saved in the user defaults
 1)LogersUserName
 2)loogedInFlag
 3)UserId
 
*/
