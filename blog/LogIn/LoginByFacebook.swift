//
//  LoginByFacebook.swift
//  blog
//
//  Created by turath alanbiaa on 5/5/20.
//  Copyright © 2020 test1. All rights reserved.
//

import Foundation

import Alamofire
import SwiftyJSON

//categry dataSever THIS IS THE LINK WHERE I'LL BE GETTING MY FBUser FROM JSON FILE
typealias CompletionHandler9<T> = (_ response: ApiResponse9<T>) -> ()
let API_URL9 = "https://blog-api.turathalanbiaa.com/api/registerbyfacebook"

class LoginByFacebook {
    
    static let instance = LoginByFacebook()
    
    func FaceBookLogin(json: [String : Any],completion: @escaping CompletionHandler9<FBUser>) {
        
        Alamofire.request(API_URL9,method: .post, parameters: json, encoding: JSONEncoding.default).responseString(completionHandler:{ r in
            print(r)
        })
        Alamofire.request(API_URL9,method: .post ,  parameters: json, encoding: JSONEncoding.default).responseString { response in
            if response.error != nil {
                print(response.error as Any)
                completion(ApiResponse9<FBUser>.fail(cause: response.error))
                return
            }
            
            guard let data = response.data else {
                print("response data is null")
                completion(ApiResponse9<FBUser>.fail(cause: nil))
                return
            }
            
            let jsonDecoder = JSONDecoder()
            guard let tloaded =  try? jsonDecoder.decode(FBUser.self, from: data) else {
                fatalError("Failed to decode from bundle.")
            }
            completion(ApiResponse9.success(data: tloaded))
          //  completion(ApiResponse9<FBUser>.fail(cause: nil))
        }
    }
}



class ApiResponse9<T> {
    var success = true
    var data: T? = nil
    var cause: Error? = nil
    
    init(success: Bool, data: T?, cause: Error?) {
        self.success = success
        self.data = data
    }
    
    public static func success(data: T) -> ApiResponse9<T> {
        return ApiResponse9(success: true, data: data, cause: nil)
    }
    
    public static func fail(cause: Error?) -> ApiResponse9<T> {
        return ApiResponse9(success: false, data: nil, cause: cause)
    }
}
