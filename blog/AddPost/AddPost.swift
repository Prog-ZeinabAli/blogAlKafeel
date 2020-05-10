//
//  AddPost.swift
//  blog
//
//  Created by turath alanbiaa on 5/3/20.
//  Copyright © 2020 test1. All rights reserved.
//

import Foundation

struct addPost : Codable {
    
    let userId: String?
    let title: String?
    let content: String?
    let createdAt: CreatedAt?
    let rate: String?
    let views: String?
    let tags: String?
    let status :String?
    let categoryId: String?
    let id : Int?
    
    struct CreatedAt : Codable {
          let date: String?
          let timezoneType: Int?
         let timezone: String?
        
        enum CodingKeys: String, CodingKey {
               case date = "date"
               case timezoneType = "timezone_type"
               case timezone = "timezone" 

           }
      }
      

  
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case title = "title"
        case content = "content"
        case createdAt =  "created_at"
        case rate = "rate"
        case views = "views"
        case tags = "tags"
        case status = "status"
        case categoryId = "category_id"
        case id = "id"
    }

    
}


struct AddPost : Codable {

let data: addPost?

}
