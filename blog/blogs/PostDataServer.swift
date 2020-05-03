//
//  PostDataServer.swift
//  blog
//
//  Created by test1 on 4/6/20.
//  Copyright © 2020 test1. All rights reserved.
//
import Foundation

import Alamofire
import SwiftyJSON

//categry dataSever THIS IS THE LINK WHERE I'LL BE GETTING MY POSTS FROM JSON FILE
typealias CompletionHandler1<T> = (_ response: ApiResponse<T>) -> ()
let API_URL2 = "https://blog-api.turathalanbiaa.com/api/posttpagination"

class PostDataServer {
    
    static let instance = PostDataServer()
    
    func fetchAllPosts(json: [String : Any],completion: @escaping CompletionHandler1<Posts>) {
        
        Alamofire.request(API_URL2,method: .post, parameters: json, encoding: JSONEncoding.default).responseString(completionHandler:{ r in
            print(r)
        })
        Alamofire.request(API_URL2,method: .post ,  parameters: json, encoding: JSONEncoding.default).responseJSON { response in
            if response.error != nil {
                print(response.error as Any)
                completion(ApiResponse<Posts>.fail(cause: response.error))
                return
            }
            
            guard let data = response.data else {
                print("response data is null")
                completion(ApiResponse<Posts>.fail(cause: nil))
                return
            }
            
            let jsonDecoder = JSONDecoder()
            guard let tloaded =  try? jsonDecoder.decode(Posts.self, from: data) else {
                fatalError("Failed to decode from bundle.")
            }
            completion(ApiResponse.success(data: tloaded))
          //  completion(ApiResponse<Posts>.fail(cause: nil))
        }
    }
}



class ApiResponse<T> {
    var success = true
    var data: T? = nil
    var cause: Error? = nil
    
    init(success: Bool, data: T?, cause: Error?) {
        self.success = success
        self.data = data
    }
    
    public static func success(data: T) -> ApiResponse<T> {
        return ApiResponse(success: true, data: data, cause: nil)
    }
    
    public static func fail(cause: Error?) -> ApiResponse<T> {
        return ApiResponse(success: false, data: nil, cause: cause)
    }
}
