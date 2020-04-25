//
//  RegisterServer.swift
//  blog
//
//  Created by turath alanbiaa on 4/25/20.
//  Copyright © 2020 test1. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

typealias CompletionHandler5<T> = (_ response: ApiResponse5<T>) -> ()
let API_URL5 = "https://blog-api.turathalanbiaa.com/api/registerusers"

class RegisterServer {
    
    private init() {}
    
    static let instance = RegisterServer()
    
    func RegisterCheck(json: [String: Any] , completion: @escaping CompletionHandler5<UserRegister>) {
        Alamofire.request(API_URL5,method: .post).responseString(completionHandler:{ r in
            print(r)
        })
        Alamofire.request(API_URL5,method: .post , parameters: json, encoding: JSONEncoding.default).responseJSON { response in
            if response.error != nil {
                print(response.error as Any)
                completion(ApiResponse5<UserRegister>.fail(cause: response.error))
                return
            }
            
            guard let data = response.data else {
                print("response data is null")
                completion(ApiResponse5<UserRegister>.fail(cause: nil))
                return
            }
            
            let jsonDecoder = JSONDecoder()
            guard let user =  try? jsonDecoder.decode(UserRegister.self, from: data) else {
                fatalError("Failed to decode from bundle.")
            }
            completion(ApiResponse5.success(response: user))
        }
    }
}



class ApiResponse5<T> {
    var success = true
    var data: T? = nil
    var cause: Error? = nil
    
    init(success: Bool, data: T?, cause: Error?) {
        self.success = success
        self.data = data
    }
    
    public static func success(response: T) -> ApiResponse5<T> {
        return ApiResponse5(success: true, data: response, cause: nil)
    }
    
    public static func fail(cause: Error?) -> ApiResponse5<T> {
        return ApiResponse5(success: false, data: nil, cause: cause)
    }
}
