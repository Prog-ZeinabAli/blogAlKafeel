//
//  SearchDataServer.swift
//  blog
//
//  Created by turath alanbiaa on 5/18/20.
//  Copyright © 2020 test1. All rights reserved.
//

import Foundation

import Alamofire
import SwiftyJSON

//categry dataSever THIS IS THE LINK WHERE I'LL BE GETTING MY POSTS FROM JSON FILE
typealias CompletionHandler15<T> = (_ response: ApiResponse15<T>) -> ()
let API_URL15 = "https://blog-api.turathalanbiaa.com/api/GetSearchResults"

class SearchDataServer {
    
    static let instance = SearchDataServer()
    
    func Search(json: [String: Any] , completion: @escaping CompletionHandler15<Blogger>) {
        Alamofire.request(API_URL15,method: .post ,  parameters: json, encoding: JSONEncoding.default).responseString(completionHandler:{ r in
            print(r)
        })
        Alamofire.request(API_URL15,method: .post ,  parameters: json, encoding: JSONEncoding.default).responseJSON { response in
            if response.error != nil {
                print(response.error as Any)
                completion(ApiResponse15<Blogger>.fail(cause: response.error))
                return
            }
            
            guard let data = response.data else {
                print("response data is null")
                completion(ApiResponse15<Blogger>.fail(cause: nil))
                return
            }
            
            let jsonDecoder = JSONDecoder()
            guard let tloaded =  try? jsonDecoder.decode(Blogger.self, from: data) else {
                fatalError("Failed to decode from bundle.")
            }
            completion(ApiResponse15.success(data: tloaded))
          //  completion(ApiResponse15<Blogger>.fail(cause: nil))
        }
    }
}



class ApiResponse15<T> {
    var success = true
    var data: T? = nil
    var cause: Error? = nil
    
    init(success: Bool, data: T?, cause: Error?) {
        self.success = success
        self.data = data
    }
    
    public static func success(data: T) -> ApiResponse15<T> {
        return ApiResponse15(success: true, data: data, cause: nil)
    }
    
    public static func fail(cause: Error?) -> ApiResponse15<T> {
        return ApiResponse15(success: false, data: nil, cause: cause)
    }
}
