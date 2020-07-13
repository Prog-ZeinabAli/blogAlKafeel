//
//  BlocUserDataServer.swift
//  blog
//
//  Created by turath alanbiaa on 7/9/20.
//  Copyright © 2020 test1. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

//categry dataSever THIS IS THE LINK WHERE I'LL BE GETTING MY POSTS FROM JSON FILE
typealias CompletionHandler18<T> = (_ response: ApiResponse18<T>) -> ()
let API_URL18 = "https://blog-api.turathalanbiaa.com/api/block_user"

class BlockUserDataServer {
    
    static let instance = BlockUserDataServer()
    
    func Blocking(json: [String : Any] ,completion: @escaping CompletionHandler18<BlockUser>) {
   

        
        Alamofire.request(API_URL18,method: .post , parameters: json, encoding: JSONEncoding.default).responseJSON { response in
            if response.error != nil {
                print(response.error as Any)
                completion(ApiResponse18<BlockUser>.fail(cause: response.error))
                return
            }
            
            guard let data = response.data else {
                print("response data is null")
                completion(ApiResponse18<BlockUser>.fail(cause: nil))
                return
            }
            
            let jsonDecoder = JSONDecoder()
            guard let tloaded =  try? jsonDecoder.decode(BlockUser.self, from: data) else {
                fatalError("Failed to decode from bundle.")
            }
            completion(ApiResponse18.success(data: tloaded))
          //  completion(ApiResponse18<Profile>.fail(cause: nil))
        }
    }
}



class ApiResponse18<T> {
    var success = true
    var data: T? = nil
    var cause: Error? = nil
    
    init(success: Bool, data: T?, cause: Error?) {
        self.success = success
        self.data = data
    }
    
    public static func success(data: T) -> ApiResponse18<T> {
        return ApiResponse18(success: true, data: data, cause: nil)
    }
    
    public static func fail(cause: Error?) -> ApiResponse18<T> {
        return ApiResponse18(success: false, data: nil, cause: cause)
    }
}
