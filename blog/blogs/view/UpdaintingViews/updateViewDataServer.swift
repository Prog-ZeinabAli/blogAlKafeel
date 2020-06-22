//
//  updateViewDataServer.swift
//  blog
//
//  Created by turath alanbiaa on 5/10/20.
//  Copyright © 2020 test1. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

//categry dataSever THIS IS THE LINK WHERE I'LL BE GETTING MY POSTS FROM JSON FILE
typealias CompletionHandler14<T> = (_ response: ApiResponse14<T>) -> ()
let API_URL14 = "https://blog-api.turathalanbiaa.com/api/updateviews"

class updateViewDataServer {
    
    static let instance = updateViewDataServer()
    
    func Updating(json: [String : Any] ,completion: @escaping CompletionHandler14<UpdateViews>) {
       /* Alamofire.request(API_URL14,method: .post , parameters: json, encoding: JSONEncoding.default).responseString(completionHandler:{ r in
            print(r)
        })*/
        Alamofire.request(API_URL14,method: .post , parameters: json, encoding: JSONEncoding.default).responseJSON { response in
            if response.error != nil {
                print(response.error as Any)
                completion(ApiResponse14<UpdateViews>.fail(cause: response.error))
                return
            }
            
            guard let data = response.data else {
                print("response data is null")
                completion(ApiResponse14<UpdateViews>.fail(cause: nil))
                return
            }
            
            let jsonDecoder = JSONDecoder()
            guard let tloaded =  try? jsonDecoder.decode(UpdateViews.self, from: data) else {
                fatalError("Failed to decode from bundle.")
            }
            completion(ApiResponse14.success(data: tloaded))
          //  completion(ApiResponse14<Profile>.fail(cause: nil))
        }
    }
}



class ApiResponse14<T> {
    var success = true
    var data: T? = nil
    var cause: Error? = nil
    
    init(success: Bool, data: T?, cause: Error?) {
        self.success = success
        self.data = data
    }
    
    public static func success(data: T) -> ApiResponse14<T> {
        return ApiResponse14(success: true, data: data, cause: nil)
    }
    
    public static func fail(cause: Error?) -> ApiResponse14<T> {
        return ApiResponse14(success: false, data: nil, cause: cause)
    }
}
