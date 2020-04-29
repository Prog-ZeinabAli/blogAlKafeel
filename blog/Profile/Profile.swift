//
//  Profile.swift
//  blog
//
//  Created by turath alanbiaa on 4/28/20.
//  Copyright © 2020 test1. All rights reserved.
//

import Foundation

struct Profile : Codable {
    
    struct User : Codable {
        let id: Int?
        let name: String?
        let picture: String?
    }
    
    let id: Int?
    let userId: String?
    let title: String?
    let content: String?
    let createdAt: String?
    let image: String?
    let rate: Int?
    let views: Int?
    let tags: String?
    let status: Int?
    let categoryId: String?
    let cmdCount: Int?
    let user : User?

    
    enum CodingKeys5: String, CodingKey {
        case id = "id"
        case userId = "user_id"
        case title = "title"
        case content = "content"
        case createdAt =  "created_at"
        case image = "image"
        case rate = "rate"
        case views = "views"
        case tags = "tags"
        case status = "status"
        case categoryId = "category_id"
        case cmdCount = "cmd_count"
        case user = "user"
        case category = "cat"
    }

    
}


struct Profiles: Codable {
    let current_page: Int
    let data: [Profile]?
    let from: Int
    let last_page: Int
    let next_page_url: String
    let path: String
    let per_page: Int
    let prev_page_url: String?
    let to: Int
    let total: Int
    
}
