//
//  Blogger.swift
//  blog
//
//  Created by test1 on 4/17/20.
//  Copyright © 2020 test1. All rights reserved.
//

import Foundation

struct Blog : Codable {
     let id: Int?
    let name: String?
    let email: String?
    let status: Int?
    let points: Int?
    let picture: String?
    let description: String?
    let facebook: String?
    let instagram: String?
    let twitter: String?
    let phone: String?
    
    
}

struct Blogger: Codable {
    let current_page: Int
    let data: [Blog]?
}
