//
//  AddComment.swift
//  blog
//
//  Created by turath alanbiaa on 5/10/20.
//  Copyright © 2020 test1. All rights reserved.
//

import Foundation
struct AddComment : Codable {
    let userId: String?
    let PostId: String?
    let content: String?
    let createdAt: CreatedAt?
    let id: Int?
    
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
    
}


    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case PostId = "post_id"
        case content = "content"
        case createdAt =  "created_at"
        case id = "id"
    
     
    }
