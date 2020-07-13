//
//  UnblockDataServefr.swift
//  blog
//
//  Created by turath alanbiaa on 7/10/20.
//  Copyright © 2020 test1. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

//categry dataSever THIS IS THE LINK WHERE I'LL BE GETTING MY POSTS FROM JSON FILE
typealias CompletionHandler20<T> = (_ response: ApiResponse20<T>) -> ()
let API_URL20 = "https://blog-api.turathalanbiaa.com/api/unblock_user"

class UnBlockUserDataServer {
    
    static let instance = UnBlockUserDataServer()
    
    func UnBlocking(json: [String : Any] ,completion: @escaping CompletionHandler20<UnBlockUser>) {
        Alamofire.request(API_URL20,method: .post , parameters: json, encoding: JSONEncoding.default).responseString(completionHandler:{ r in
            print(r)
        })
        Alamofire.request(API_URL20,method: .post , parameters: json, encoding: JSONEncoding.default).responseJSON { response in
            if response.error != nil {
                print(response.error as Any)
                completion(ApiResponse20<UnBlockUser>.fail(cause: response.error))
                return
            }
            
            guard let data = response.data else {
                print("response data is null")
                completion(ApiResponse20<UnBlockUser>.fail(cause: nil))
                return
            }
            
            let jsonDecoder = JSONDecoder()
            guard let tloaded =  try? jsonDecoder.decode(UnBlockUser.self, from: data) else {
                fatalError("Failed to decode from bundle.")
            }
            completion(ApiResponse20.success(data: tloaded))
          //  completion(ApiResponse20<Profile>.fail(cause: nil))
        }
    }
}



class ApiResponse20<T> {
    var success = true
    var data: T? = nil
    var cause: Error? = nil
    
    init(success: Bool, data: T?, cause: Error?) {
        self.success = success
        self.data = data
    }
    
    public static func success(data: T) -> ApiResponse20<T> {
        return ApiResponse20(success: true, data: data, cause: nil)
    }
    
    public static func fail(cause: Error?) -> ApiResponse20<T> {
        return ApiResponse20(success: false, data: nil, cause: cause)
    }
}
