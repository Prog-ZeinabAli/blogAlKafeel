//
//  UpdtProfileDataServer.swift
//  blog
//
//  Created by turath alanbiaa on 4/28/20.
//  Copyright © 2020 test1. All rights reserved.
//
import Foundation
import Alamofire
import SwiftyJSON

//categry dataSever THIS IS THE LINK WHERE I'LL BE GETTING MY POSTS FROM JSON FILE
typealias CompletionHandler13<T> = (_ response: ApiResponse13<T>) -> ()
let API_URL13 = "https://blog-api.turathalanbiaa.com/api/updateprofile"

class UpdtProfileDataServer {
    
    static let instance = UpdtProfileDataServer()
    
    func Updating(json: [String : Any] ,completion: @escaping CompletionHandler13<UpdateProfile>) {
        Alamofire.request(API_URL13,method: .post , parameters: json, encoding: JSONEncoding.default).responseString(completionHandler:{ r in
            print(r)
        })
        Alamofire.request(API_URL13,method: .post , parameters: json, encoding: JSONEncoding.default).responseJSON { response in
            if response.error != nil {
                print(response.error as Any)
                completion(ApiResponse13<UpdateProfile>.fail(cause: response.error))
                return
            }
            
            guard let data = response.data else {
                print("response data is null")
                completion(ApiResponse13<UpdateProfile>.fail(cause: nil))
                return
            }
            
            let jsonDecoder = JSONDecoder()
            guard let tloaded =  try? jsonDecoder.decode(UpdateProfile.self, from: data) else {
                fatalError("Failed to decode from bundle.")
            }
            completion(ApiResponse13.success(data: tloaded))
          //  completion(ApiResponse13<Profile>.fail(cause: nil))
        }
    }
}



class ApiResponse13<T> {
    var success = true
    var data: T? = nil
    var cause: Error? = nil
    
    init(success: Bool, data: T?, cause: Error?) {
        self.success = success
        self.data = data
    }
    
    public static func success(data: T) -> ApiResponse13<T> {
        return ApiResponse13(success: true, data: data, cause: nil)
    }
    
    public static func fail(cause: Error?) -> ApiResponse13<T> {
        return ApiResponse13(success: false, data: nil, cause: cause)
    }
}
