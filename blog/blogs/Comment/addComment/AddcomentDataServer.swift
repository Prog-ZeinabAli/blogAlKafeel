//
//  AddcomentDataServer.swift
//  blog
//
//  Created by turath alanbiaa on 5/10/20.
//  Copyright © 2020 test1. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

//categry dataSever THIS IS THE LINK WHERE I'LL BE GETTING MY POSTS FROM JSON FILE
typealias CompletionHandler12<T> = (_ response: ApiResponse12<T>) -> ()
let API_URL12 = "https://blog-api.turathalanbiaa.com/api/addcomment"

class AddcomentDataServer {
    
    static let instance = AddcomentDataServer()
    
    func addComment(json: [String : Any] ,completion: @escaping CompletionHandler12<AddComment>) {

        
        Alamofire.request(API_URL12,method: .post , parameters: json, encoding: JSONEncoding.default).responseJSON { response in
            if response.error != nil {
                print(response.error as Any)
                completion(ApiResponse12<AddComment>.fail(cause: response.error))
                return
            }
            
            guard let data = response.data else {
                print("response data is null")
                completion(ApiResponse12<AddComment>.fail(cause: nil))
                return
            }
            
            let jsonDecoder = JSONDecoder()
            guard let tloaded =  try? jsonDecoder.decode(AddComment.self, from: data) else {
                fatalError("Failed to decode from bundle.")
            }
            completion(ApiResponse12.success(data: tloaded))
          //  completion(ApiResponse12<AddComment>.fail(cause: nil))
        }
         
    }
}



class ApiResponse12<T> {
    var success = true
    var data: T? = nil
    var cause: Error? = nil
    
    init(success: Bool, data: T?, cause: Error?) {
        self.success = success
        self.data = data
    }
    
    public static func success(data: T) -> ApiResponse12<T> {
        return ApiResponse12(success: true, data: data, cause: nil)
    }
    
    public static func fail(cause: Error?) -> ApiResponse12<T> {
        return ApiResponse12(success: false, data: nil, cause: cause)
    }
}
