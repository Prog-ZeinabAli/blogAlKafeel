//
//  Post.swift
//  blog
//
//  Created by test1 on 4/6/20.
//  Copyright © 2020 test1. All rights reserved.
//


import Foundation

struct Post : Codable {
    
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
    let category : Category2?
    
    enum CodingKeys: String, CodingKey {
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



struct Category2: Codable {
    let id: Int?
    let name: String?
}


struct Posts: Codable {
    let current_page: Int
    let data: [Post]?
    let from: Int?
    let last_page: Int?
    let next_page_url: String?
    let path: String?
    let per_page: Int?
    let prev_page_url: String?
    let to: Int?
    let total: Int?
}
