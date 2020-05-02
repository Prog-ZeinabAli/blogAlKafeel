//
//  ProfileDataServer.swift
//  blog
//
//  Created by turath alanbiaa on 4/28/20.
//  Copyright © 2020 test1. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

//categry dataSever THIS IS THE LINK WHERE I'LL BE GETTING MY POSTS FROM JSON FILE
typealias CompletionHandler7<T> = (_ response: ApiResponse7<T>) -> ()
let API_URL7 = "https://blog-api.turathalanbiaa.com/api/PosttPaginationByUserId"

class ProfiletDataServer {
    
    static let instance = ProfiletDataServer()
    
    func fetchAllProfile(json: [String : Any] ,completion: @escaping CompletionHandler7<Profile>) {
        Alamofire.request(API_URL7,method: .post , parameters: json, encoding: JSONEncoding.default).responseString(completionHandler:{ r in
            print(r)
        })
        Alamofire.request(API_URL7,method: .post , parameters: json, encoding: JSONEncoding.default).responseJSON { response in
            if response.error != nil {
                print(response.error as Any)
                completion(ApiResponse7<Profile>.fail(cause: response.error))
                return
            }
            
            guard let data = response.data else {
                print("response data is null")
                completion(ApiResponse7<Profile>.fail(cause: nil))
                return
            }
            
            let jsonDecoder = JSONDecoder()
            guard let tloaded =  try? jsonDecoder.decode(Profile.self, from: data) else {
                fatalError("Failed to decode from bundle.")
            }
            completion(ApiResponse7.success(data: tloaded))
          //  completion(ApiResponse7<Profile>.fail(cause: nil))
        }
    }
}



class ApiResponse7<T> {
    var success = true
    var data: T? = nil
    var cause: Error? = nil
    
    init(success: Bool, data: T?, cause: Error?) {
        self.success = success
        self.data = data
    }
    
    public static func success(data: T) -> ApiResponse7<T> {
        return ApiResponse7(success: true, data: data, cause: nil)
    }
    
    public static func fail(cause: Error?) -> ApiResponse7<T> {
        return ApiResponse7(success: false, data: nil, cause: cause)
    }
}
