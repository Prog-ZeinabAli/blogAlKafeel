//
//  Comments.swift
//  blog
//
//  Created by turath alanbiaa on 4/27/20.
//  Copyright © 2020 test1. All rights reserved.
//

import Foundation
struct Comment : Codable {
    
  
    let id: Int?
    let userId: String?
    let postId: Int?
    let content: String?
    let createdAt: String?
    let user : User?

    struct User : Codable {
           let id: Int?
           let name: String?
           let email: String?
       }
      
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case userId = "user_id"
        case postId = "post_id"
        case content = "content"
        case createdAt =  "created_at"
        case user = "user"
    }

}


struct Comments: Codable {
    let current_page: Int?
    let data: [Comment]?
    let from: Int?
     let last_page: Int?
     let next_page_url: String?
     let path: String?
     let per_page: Int?
     let prev_page_url: String?
     let to: Int?
     let total: Int?
     
}
