//
//  DeleteCmntDataServer.swift
//  blog
//
//  Created by turath alanbiaa on 5/18/20.
//  Copyright © 2020 test1. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

//categry dataSever THIS IS THE LINK WHERE I'LL BE GETTING MY POSTS FROM JSON FILE
typealias CompletionHandler16<T> = (_ response: ApiResponse16<T>) -> ()
let API_URL16 = "https://blog-api.turathalanbiaa.com/api/deletecomment"

class DeleteCmntDataServer {
    
    static let instance = DeleteCmntDataServer()
    
    func Delete(json: [String : Any] ,completion: @escaping CompletionHandler16<DeletePost>) {
        Alamofire.request(API_URL16,method: .post , parameters: json, encoding: JSONEncoding.default).responseString(completionHandler:{ r in
            print(r)
        })
        Alamofire.request(API_URL16,method: .post , parameters: json, encoding: JSONEncoding.default).responseJSON { response in
            if response.error != nil {
                print(response.error as Any)
                completion(ApiResponse16<DeletePost>.fail(cause: response.error))
                return
            }
            
            guard let data = response.data else {
                print("response data is null")
                completion(ApiResponse16<DeletePost>.fail(cause: nil))
                return
            }
            
            let jsonDecoder = JSONDecoder()
            guard let tloaded =  try? jsonDecoder.decode(DeletePost.self, from: data) else {
                fatalError("Failed to decode from bundle.")
            }
            completion(ApiResponse16.success(data: tloaded))
          //  completion(ApiResponse16<Profile>.fail(cause: nil))
        }
    }
}



class ApiResponse16<T> {
    var success = true
    var data: T? = nil
    var cause: Error? = nil
    
    init(success: Bool, data: T?, cause: Error?) {
        self.success = success
        self.data = data
    }
    
    public static func success(data: T) -> ApiResponse16<T> {
        return ApiResponse16(success: true, data: data, cause: nil)
    }
    
    public static func fail(cause: Error?) -> ApiResponse16<T> {
        return ApiResponse16(success: false, data: nil, cause: cause)
    }
}
