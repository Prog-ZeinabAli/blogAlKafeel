//
//  LogInVars.swift
//  blog
//
//  Created by turath alanbiaa on 4/24/20.
//  Copyright © 2020 test1. All rights reserved.
//

import Foundation
struct logInVars : Codable {
let description: String?
let email: String?
let facebook: String?
let id: Int?
let instagram: String?
let name: String?
let phone: String?
let picture: String?
let points: Int?
let status: Int?
let token: String?
let twitter: String?

}

struct LogInVars: Codable {
let data: [logInVars]?
}
