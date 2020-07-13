//
//  BlockedUsers.swift
//  blog
//
//  Created by turath alanbiaa on 7/10/20.
//  Copyright © 2020 test1. All rights reserved.
//

import Foundation
struct blockedUsers : Codable {
   
    let name: String?
    let user_id: String?
   
    enum CodingKeys2: String, CodingKey {
                      case name = "name"
                      case UserId = "user_id"
                 }
}


struct BlockedUsers: Codable {
    let data: [blockedUsers]?
}
