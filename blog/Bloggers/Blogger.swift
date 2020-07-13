//
//  Blogger.swift
//  blog
//
//  Created by test1 on 4/17/20.
//  Copyright © 2020 test1. All rights reserved.
//

import Foundation

struct Blog : Codable {
    let id: String?
    let name: String?
    let email: String?
    let status: Int?
    let points: Int?
    let picture: String?
    let password : String?
    let description: String?
    let facebook: String?
    let instagram: String?
    let twitter: String?
    let phone: String?
    let token: String?
    
    
}

struct Blogger: Codable {
    let current_page: Int
    let data: [Blog]?
    let from: Int?
    let last_page: Int?
    let next_page_url: String?
    let path: String?
    let per_page: Int?
    let prev_page_url: String?
    let to: Int?
    let total: Int?
}
