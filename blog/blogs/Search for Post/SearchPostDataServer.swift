//
//  SearchPostDataServer.swift
//  blog
//
//  Created by turath alanbiaa on 5/31/20.
//  Copyright © 2020 test1. All rights reserved.
//
import Foundation

import Alamofire
import SwiftyJSON

//categry dataSever THIS IS THE LINK WHERE I'LL BE GETTING MY Posts FROM JSON FILE
typealias CompletionHandler17<T> = (_ response: ApiResponse17<T>) -> ()
let API_URL17 = "https://blog-api.turathalanbiaa.com/api/searchPost2"

class SearchPostDataServer {
    
    static let instance = SearchPostDataServer()
    
    func Searching(json: [String: Any] , completion: @escaping CompletionHandler17<Posts>) {
        Alamofire.request(API_URL17,method: .post ,  parameters: json, encoding: JSONEncoding.default).responseString(completionHandler:{ r in
          //  print(r)
        })
        Alamofire.request(API_URL17,method: .post ,  parameters: json, encoding: JSONEncoding.default).responseString{ response in
            if response.error != nil {
                print(response.error as Any)
                completion(ApiResponse17<Posts>.fail(cause: response.error))
                return
            }
            
            guard let data = response.data else {
                print("response data is null")
                completion(ApiResponse17<Posts>.fail(cause: nil))
                return
            }
            
            let jsonDecoder = JSONDecoder()
            guard let tloaded =  try? jsonDecoder.decode(Posts.self, from: data) else {
                fatalError("Failed to decode from bundle.")
            }
            completion(ApiResponse17.success(data: tloaded))
          //  completion(ApiResponse17<Blogger>.fail(cause: nil))
        }
    }
}



class ApiResponse17<T> {
    var success = true
    var data: T? = nil
    var cause: Error? = nil
    
    init(success: Bool, data: T?, cause: Error?) {
        self.success = success
        self.data = data
    }
    
    public static func success(data: T) -> ApiResponse17<T> {
        return ApiResponse17(success: true, data: data, cause: nil)
    }
    
    public static func fail(cause: Error?) -> ApiResponse17<T> {
        return ApiResponse17(success: false, data: nil, cause: cause)
    }
}
