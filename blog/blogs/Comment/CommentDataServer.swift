//
//  CommentDataServer.swift
//  blog
//
//  Created by turath alanbiaa on 4/27/20.
//  Copyright © 2020 test1. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

//categry dataSever THIS IS THE LINK WHERE I'LL BE GETTING MY POSTS FROM JSON FILE
typealias CompletionHandler6<T> = (_ response: ApiResponse6<T>) -> ()
//let API_URL6 = "https://blog-api.turathalanbiaa.com/api/commentpagination"

class CommentDataServer {
    
    static let instance = CommentDataServer()
    
    func fetchAllComments(API_URL6 : String , json: [String : Any] ,completion: @escaping CompletionHandler6<Comments>) {

        Alamofire.request(API_URL6,method: .post , parameters: json, encoding: JSONEncoding.default).responseString(completionHandler:{ responseString in
           // print(responseString)
        
        })
        
        Alamofire.request(API_URL6,method: .post , parameters: json, encoding: JSONEncoding.default).responseJSON { response in
            if response.error != nil {
               // print(response.error as Any)
                completion(ApiResponse6<Comments>.fail(cause: response.error))
                return
            }
            
            guard let data = response.data else {
                print("response data is null")
                completion(ApiResponse6<Comments>.fail(cause: nil))
                return
            }
            
            let jsonDecoder = JSONDecoder()
            guard let tloaded =  try? jsonDecoder.decode(Comments.self, from: data) else {
                fatalError("Failed to decode from bundle.")
            }
            completion(ApiResponse6.success(data: tloaded))
          //  completion(ApiResponse6<Comments>.fail(cause: nil))
        }
         
    }
}



class ApiResponse6<T> {
    var success = true
    var data: T? = nil
    var cause: Error? = nil
    
    init(success: Bool, data: T?, cause: Error?) {
        self.success = success
        self.data = data
    }
    
    public static func success(data: T) -> ApiResponse6<T> {
        return ApiResponse6(success: true, data: data, cause: nil)
    }
    
    public static func fail(cause: Error?) -> ApiResponse6<T> {
        return ApiResponse6(success: false, data: nil, cause: cause)
    }
}
