//
//  AddPostServer.swift
//  blog
//
//  Created by turath alanbiaa on 5/3/20.
//  Copyright © 2020 test1. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

//categry dataSever THIS IS THE LINK WHERE I'LL BE GETTING MY POSTS FROM JSON FILE
typealias CompletionHandler8<T> = (_ response: ApiResponse8<T>) -> ()
let API_URL8 = "https://blog-api.turathalanbiaa.com/api/addposts"

class AddPostDateServer {
    
    static let instance = AddPostDateServer()
    
    func sendPost(json: [String : Any] ,completion: @escaping CompletionHandler8<AddPost>) {
        Alamofire.request(API_URL8,method: .post , parameters: json, encoding: JSONEncoding.default).responseString(completionHandler:{ r in
            print(r)
        })
        Alamofire.request(API_URL8,method: .post , parameters: json, encoding: JSONEncoding.default).responseJSON { response in
            if response.error != nil {
                print(response.error as Any)
                completion(ApiResponse8<AddPost>.fail(cause: response.error))
                return
            }
            
            guard let data = response.data else {
                print("response data is null")
                completion(ApiResponse8<AddPost>.fail(cause: nil))
                return
            }
            
            let jsonDecoder = JSONDecoder()
            guard let tloaded =  try? jsonDecoder.decode(AddPost.self, from: data) else {
                fatalError("Failed to decode from bundle.")
            }
            completion(ApiResponse8.success(data: tloaded))
          //  completion(ApiResponse8<AddPost>.fail(cause: nil))
        }
    }
}



class ApiResponse8<T> {
    var success = true
    var data: T? = nil
    var cause: Error? = nil
    
    init(success: Bool, data: T?, cause: Error?) {
        self.success = success
        self.data = data
    }
    
    public static func success(data: T) -> ApiResponse8<T> {
        return ApiResponse8(success: true, data: data, cause: nil)
    }
    
    public static func fail(cause: Error?) -> ApiResponse8<T> {
        return ApiResponse8(success: false, data: nil, cause: cause)
    }
}
