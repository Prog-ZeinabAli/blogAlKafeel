//
//  BlockedUsersDataServer.swift
//  blog
//
//  Created by turath alanbiaa on 7/10/20.
//  Copyright © 2020 test1. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

//categry dataSever THIS IS THE LINK WHERE I'LL BE GETTING MY POSTS FROM JSON FILE
typealias CompletionHandler19<T> = (_ response: ApiResponse19<T>) -> ()
let API_URL19 = "https://blog-api.turathalanbiaa.com/api/all_block_user"

class BlockedUsersDataServer {
    
    static let instance = BlockedUsersDataServer()
    
    func BlockingList(json: [String : Any] ,completion: @escaping CompletionHandler19<BlockedUsers>) {
      
        Alamofire.request(API_URL19,method: .post , parameters: json, encoding: JSONEncoding.default).responseJSON { response in
            if response.error != nil {
                print(response.error as Any)
                completion(ApiResponse19<BlockedUsers>.fail(cause: response.error))
                return
            }
            
            guard let data = response.data else {
                print("response data is null")
                completion(ApiResponse19<BlockedUsers>.fail(cause: nil))
                return
            }
            
            let jsonDecoder = JSONDecoder()
            guard let tloaded =  try? jsonDecoder.decode(BlockedUsers.self, from: data) else {
                fatalError("Failed to decode from bundle.")
            }
            completion(ApiResponse19.success(data: tloaded))
          //  completion(ApiResponse19<Profile>.fail(cause: nil))
        }
    }
}



class ApiResponse19<T> {
    var success = true
    var data: T? = nil
    var cause: Error? = nil
    
    init(success: Bool, data: T?, cause: Error?) {
        self.success = success
        self.data = data
    }
    
    public static func success(data: T) -> ApiResponse19<T> {
        return ApiResponse19(success: true, data: data, cause: nil)
    }
    
    public static func fail(cause: Error?) -> ApiResponse19<T> {
        return ApiResponse19(success: false, data: nil, cause: cause)
    }
}
