//
//  LogInServer.swift
//  blog
//
//  Created by turath alanbiaa on 4/24/20.
//  Copyright © 2020 test1. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

//categry dataSever THIS IS THE LINK WHERE I'LL BE GETTING MY POSTS FROM JSON FILE
typealias CompletionHandler4<T> = (_ response: ApiResponse4<T>) -> ()
let API_URL4 = "https://blog-api.turathalanbiaa.com/api/posttpagination"

class LogInServer {
    
    static let instance = LogInServer()
    
    func LogInCheck(json: [String: Any] , completion: @escaping CompletionHandler4<LogInVars>) {
        Alamofire.request(API_URL4,method: .post).responseString(completionHandler:{ r in
            print(r)
        })
        Alamofire.request(API_URL4,method: .post , parameters: json, encoding: JSONEncoding.default).responseJSON { response in
            if response.error != nil {
                print(response.error as Any)
                completion(ApiResponse4<LogInVars>.fail(cause: response.error))
                return
            }
            
            guard let data = response.data else {
                print("response data is null")
                completion(ApiResponse4<LogInVars>.fail(cause: nil))
                return
            }
            
            let jsonDecoder = JSONDecoder()
            guard let tloaded =  try? jsonDecoder.decode(LogInVars.self, from: data) else {
                fatalError("Failed to decode from bundle.")
            }
            completion(ApiResponse4.success(data: tloaded))
          //  completion(ApiResponse4<Posts>.fail(cause: nil))
        }
    }
}



class ApiResponse4<T> {
    var success = true
    var data: T? = nil
    var cause: Error? = nil
    
    init(success: Bool, data: T?, cause: Error?) {
        self.success = success
        self.data = data
    }
    
    public static func success(data: T) -> ApiResponse4<T> {
        return ApiResponse4(success: true, data: data, cause: nil)
    }
    
    public static func fail(cause: Error?) -> ApiResponse4<T> {
        return ApiResponse4(success: false, data: nil, cause: cause)
    }
}
