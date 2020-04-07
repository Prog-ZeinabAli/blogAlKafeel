//
//  PostDataServer.swift
//  blog
//
//  Created by test1 on 4/6/20.
//  Copyright © 2020 test1. All rights reserved.
//
import Foundation

import Alamofire
import SwiftyJSON

//categry dataSever THIS IS THE LINK WHERE I'LL BE GETTING MY POSTS FROM JSON FILE
typealias CompletionHandler1<T> = (_ response: ApiResponse<T>) -> ()
let API_URL2 = "https://blog-api.turathalanbiaa.com/api/posttpagination"

class PostDataServer {

    static let instance = PostDataServer()

    func fetchAllPosts(completion: @escaping CompletionHandler1<[Post]>) {
        Alamofire.request(API_URL2,method: .post).responseString(completionHandler:{ r in
            print(r)
        })
        Alamofire.request(API_URL2,method: .post).responseJSON { response in
            if response.error != nil {
                print(response.error as Any)
                completion(ApiResponse<[Post]>.fail(cause: response.error))
                return
            }

            guard let data = response.data else {
                print("response data is null")
                completion(ApiResponse<[Post]>.fail(cause: nil))
                return
            }

            do {
                let json = try JSON(data: data)
                let responseCode = response.response?.statusCode
                if responseCode == 200 {
                    var postsObjects = [Post]()
                    let postsArray: [JSON] = json["data"].arrayValue
                    for posts in postsArray {
                        let id = posts["id"].intValue
                        let name = posts["name"].stringValue
                        let userId = posts["userId"].stringValue
                        let title = posts["title"].stringValue
                        let content = posts["content"].stringValue
                        let image = posts["image"].stringValue
                        let categoryId = posts["categoryId"].stringValue
                        let tags = posts["tags"].stringValue
                        let picture = posts["picture"].stringValue
                        let rate = posts["rate"].intValue
                        let view = posts["view"].intValue
                        let status = posts["status"].intValue

                        let post = Post(userId: userId, id: id, title: title, content: content, image: image, categoryId: categoryId, tags: tags, name: name, picture: picture, rate: rate, view: view, status: status)
                        postsObjects.append(post)
                    }
                    completion(ApiResponse.success(data: postsObjects))
                } else {
                    completion(ApiResponse<[Post]>.fail(cause: nil))
                }
            } catch {
                print(error)
                completion(ApiResponse<[Post]>.fail(cause: error))
            }
        }
    }
    
}


class ApiResponse<T> {
    var success = true
    var data: T? = nil
    var cause: Error? = nil

    init(success: Bool, data: T?, cause: Error?) {
        self.success = success
        self.data = data
    }

    public static func success(data: T) -> ApiResponse<T> {
        return ApiResponse(success: true, data: data, cause: nil)
    }

    public static func fail(cause: Error?) -> ApiResponse<T> {
        return ApiResponse(success: false, data: nil, cause: cause)
    }
}
