//
//  Search.swift
//  blog
//
//  Created by turath alanbiaa on 5/18/20.
//  Copyright © 2020 test1. All rights reserved.
//

import Foundation

    struct search : Codable {
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
        let token: String?
        
    }


    struct Search: Codable {
        let data: [search]?
    }
