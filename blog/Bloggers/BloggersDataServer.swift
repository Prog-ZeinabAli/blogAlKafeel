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
typealias CompletionHandler3<T> = (_ response: ApiResponse3<T>) -> ()
//let API_URL3 = "https://blog-api.turathalanbiaa.com/api/userpagination"

class BloggersDataServer {
    
    static let instance = BloggersDataServer()
    
    func fetchAllBloggers(API_URL3 : String , completion: @escaping CompletionHandler3<Blogger>) {
        Alamofire.request(API_URL3,method: .post).responseString(completionHandler:{ r in
            print(r)
        })
        Alamofire.request(API_URL3,method: .post).responseJSON { response in
            if response.error != nil {
                print(response.error as Any)
                completion(ApiResponse3<Blogger>.fail(cause: response.error))
                return
            }
            
            guard let data = response.data else {
                print("response data is null")
                completion(ApiResponse3<Blogger>.fail(cause: nil))
                return
            }
            
            let jsonDecoder = JSONDecoder()
            guard let tloaded =  try? jsonDecoder.decode(Blogger.self, from: data) else {
                fatalError("Failed to decode from bundle.")
            }
            completion(ApiResponse3.success(data: tloaded))
          //  completion(ApiResponse3<Blogger>.fail(cause: nil))
        }
    }
}



class ApiResponse3<T> {
    var success = true
    var data: T? = nil
    var cause: Error? = nil
    
    init(success: Bool, data: T?, cause: Error?) {
        self.success = success
        self.data = data
    }
    
    public static func success(data: T) -> ApiResponse3<T> {
        return ApiResponse3(success: true, data: data, cause: nil)
    }
    
    public static func fail(cause: Error?) -> ApiResponse3<T> {
        return ApiResponse3(success: false, data: nil, cause: cause)
    }
}
