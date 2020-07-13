//
//  getImage.swift
//  blog
//
//  Created by turath alanbiaa on 5/27/20.
//  Copyright © 2020 test1. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class Get{
    
    

static func Image(from string: String)  -> UIImage? {
    let urlString = "https://alkafeelblog.edu.turathalanbiaa.com/aqlam/image/" + string
           guard let url = URL(string: urlString)
               else{
                   return nil }
           var image: UIImage? = nil
           do {
           // [imageView hnk_setImageFromURL:url];
               let data = try Data(contentsOf: url, options: [])
               image = UIImage(data: data)
           }
           catch {
               print(error.localizedDescription)
           }

           return image
    }

    
   


    
    static func Picture(from string: String) -> UIImage? {
        //2. Get valid URL
        guard let url = URL(string: string )
            else{
                return nil }
        var image: UIImage? = nil
        do {
            let data = try Data(contentsOf: url, options: [])
            image = UIImage(data: data)
        }
        catch {
            print(error.localizedDescription)
        }

        return image
    }
    

static func NightMode(from string: UIViewController) {

if UserDefaults.standard.object(forKey: "NightMode") as? String  == "True"
           {
            string.overrideUserInterfaceStyle = .dark
           }else{
           string.overrideUserInterfaceStyle = .light
           }
          
}
    
    static func BtnNightMode(from string: UIButton) {

    if UserDefaults.standard.object(forKey: "NightMode") as? String  == "True"
               {
                string.overrideUserInterfaceStyle = .dark
               }else{
               string.overrideUserInterfaceStyle = .light
               }
              
    }
    
    
   /* static func upload <T: StaticMappable> (type: T.Type, params:Dictionary<String, Any>, imageData: Data, imageName: String, success: @escaping (_ response:T) -> Void, fail: @escaping (_ error:String)->Void ,login: ((_ message:String?)->Void)? = nil)->Void where T:Meta {
        //CircularSpinner.show()
        APIManager.sharedManager.upload(multipartFormData: {(multipartFormData)in
            
            
            for (key , value) in params {
                multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
                
            }
            multipartFormData.append(imageData, withName: "file_upload", fileName: imageName, mimeType: "image/png")
            
        }, to: type.url(), method : .post, encodingCompletion: {(encodingResults) in
            
            switch encodingResults {
            case .success(let uploads,_,_) :
                
                uploads.responseJSON(completionHandler: { response in
                    // debugPrint(response)
                    let outputResponse = Mapper<BaseResponse>().map(JSONObject: response.result.value)//.map(JSON: response )
                    //response.result.value as? BaseResponse
                    var message = "Your request failed. Please try again later"
                    if let  msg = outputResponse?.message {
                        message = msg
                    }
                    CircularSpinner.hide()
                    if let status = outputResponse?.status, String(describing: status) == "0" {
                        let oResponse = Mapper<T>().map(JSONObject: response.result.value)
                        success(oResponse!)
                    }else if let status = outputResponse?.status, String(describing: status) == "-1" {
                        
                        login?(message)
                    }else{
                        fail(message)
                    }
                    //debugPrint(uploads.request.debugDescription)
                })
                
            case .failure(let error):
                CircularSpinner.hide()
                if let err = error as? URLError, err.code  == URLError.Code.notConnectedToInternet
                {
                    // No internet
                    fail(Constants.DEFAULT_CONNECTIVITY_ERROR_MSG)
                }
                else
                {
                    fail(Constants.DEFAULT_ERROR_MSG)
                }
            }
            
        })
        
        
    }*/
  
    

     
}
