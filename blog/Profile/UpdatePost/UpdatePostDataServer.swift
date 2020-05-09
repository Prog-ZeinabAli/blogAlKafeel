//
//  UpdatePostDataServer.swift
//  blog
//
//  Created by turath alanbiaa on 5/8/20.
//  Copyright © 2020 test1. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

//categry dataSever THIS IS THE LINK WHERE I'LL BE GETTING MY POSTS FROM JSON FILE
typealias CompletionHandler10<T> = (_ response: ApiResponse10<T>) -> ()
let API_URL10 = "https://blog-api.turathalanbiaa.com/api/updatepost"

class UpdatePostDataServer {
    
    static let instance = UpdatePostDataServer()
    
    func fetchAllProfile(json: [String : Any] ,completion: @escaping CompletionHandler10<Profiles>) {
        Alamofire.request(API_URL10,method: .post , parameters: json, encoding: JSONEncoding.default).responseString(completionHandler:{ r in
            print(r)
        })
        Alamofire.request(API_URL10,method: .post , parameters: json, encoding: JSONEncoding.default).responseJSON { response in
            if response.error != nil {
                print(response.error as Any)
                completion(ApiResponse10<Profiles>.fail(cause: response.error))
                return
            }
            
            guard let data = response.data else {
                print("response data is null")
                completion(ApiResponse10<Profiles>.fail(cause: nil))
                return
            }
            
            let jsonDecoder = JSONDecoder()
            guard let tloaded =  try? jsonDecoder.decode(Profiles.self, from: data) else {
                fatalError("Failed to decode from bundle.")
            }
            completion(ApiResponse10.success(data: tloaded))
          //  completion(ApiResponse10<Profile>.fail(cause: nil))
        }
    }
}



class ApiResponse10<T> {
    var success = true
    var data: T? = nil
    var cause: Error? = nil
    
    init(success: Bool, data: T?, cause: Error?) {
        self.success = success
        self.data = data
    }
    
    public static func success(data: T) -> ApiResponse10<T> {
        return ApiResponse10(success: true, data: data, cause: nil)
    }
    
    public static func fail(cause: Error?) -> ApiResponse10<T> {
        return ApiResponse10(success: false, data: nil, cause: cause)
    }
}
