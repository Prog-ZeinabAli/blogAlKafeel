//
//  testServer.swift
//  blog
//
//  Created by turath alanbiaa on 7/10/20.
//  Copyright © 2020 test1. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

//categry dataSever
typealias CompletionHandlerTest = (_ Success: Bool) -> ()
let API_URLTest = "https://blog-api.turathalanbiaa.com/api/all_block_user"


class TestServer {
    
    static let instance = TestServer()
    var test =  [Test]()
    
    
    func fetchAlltest(json: [String: Any] , completion: @escaping CompletionHandlerTest){
        Alamofire.request(API_URLTest,method: .post ,  parameters: json, encoding: JSONEncoding.default).responseJSON { response in
            if response.error == nil {
                
                guard let data = response.data else { return }
                do {
                    let json =  try JSON(data: data)
                    let responseCode = response.response?.statusCode
                    if responseCode == 200 {
                        self.cleartest()
                        let TestArray:[JSON] = json.arrayValue
                        for test in TestArray {
                            let name = test["name"].stringValue
                            let user_id = test["user_id"].stringValue
                            
                            let test = Test(name: name, user_id: user_id)
                            self.test.append(test)
                            completion(true)
                        }
                    }else{
                        completion(false)
                    }
                }catch {
                    completion(false)
                }
            }else{
                completion(false)
            }
        }
    }
    
    
    func cleartest(){
        self.test.removeAll()
    }
    
    
}

