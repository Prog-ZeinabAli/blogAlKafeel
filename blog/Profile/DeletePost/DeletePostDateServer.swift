//
//  DeletePostDataServer.swift
//  blog
//
//  Created by turath alanbiaa on 5/8/20.
//  Copyright © 2020 test1. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

//categry dataSever THIS IS THE LINK WHERE I'LL BE GETTING MY POSTS FROM JSON FILE
typealias CompletionHandler11<T> = (_ response: ApiResponse11<T>) -> ()
let API_URL11 = "https://blog-api.turathalanbiaa.com/api/deletepost"

class DeletePostDataServer {
    
    static let instance = DeletePostDataServer()
    
    func Delete(json: [String : Any] ,completion: @escaping CompletionHandler11<DeletePost>) {
        Alamofire.request(API_URL11,method: .post , parameters: json, encoding: JSONEncoding.default).responseString(completionHandler:{ r in
            print(r)
        })
        Alamofire.request(API_URL11,method: .post , parameters: json, encoding: JSONEncoding.default).responseJSON { response in
            if response.error != nil {
                print(response.error as Any)
                completion(ApiResponse11<DeletePost>.fail(cause: response.error))
                return
            }
            
            guard let data = response.data else {
                print("response data is null")
                completion(ApiResponse11<DeletePost>.fail(cause: nil))
                return
            }
            
            let jsonDecoder = JSONDecoder()
            guard let tloaded =  try? jsonDecoder.decode(DeletePost.self, from: data) else {
                fatalError("Failed to decode from bundle.")
            }
            completion(ApiResponse11.success(data: tloaded))
          //  completion(ApiResponse11<Profile>.fail(cause: nil))
        }
    }
}



class ApiResponse11<T> {
    var success = true
    var data: T? = nil
    var cause: Error? = nil
    
    init(success: Bool, data: T?, cause: Error?) {
        self.success = success
        self.data = data
    }
    
    public static func success(data: T) -> ApiResponse11<T> {
        return ApiResponse11(success: true, data: data, cause: nil)
    }
    
    public static func fail(cause: Error?) -> ApiResponse11<T> {
        return ApiResponse11(success: false, data: nil, cause: cause)
    }
}
