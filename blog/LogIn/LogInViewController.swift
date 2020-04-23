//
//  LogInViewController.swift
//  blog
//
//  Created by test1 on 4/9/20.
//  Copyright © 2020 test1. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin
import Alamofire
import SwiftyJSON

class LogInViewController: UIViewController {

    @IBOutlet weak var signInWinstution: UISwitch!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var LogInWithFb: UIButton!
    @IBOutlet weak var LogInBtn: UIButton!
    @IBOutlet var MainView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        Utilities.fadedColor(MainView)
         Utilities.styleHollowButton(LogInBtn)
        // Do any additional setup after loading the view.
    }
    @IBAction func FaceBookLogInBtn(_ sender: Any) {
        print("yes")
      
    }
    @IBAction func LogInBtnPressed(_ sender: Any) {
        let json: [String: Any] = ["password": passwordTxt.text,"email": usernameTxt.text , "db":0]
        let x = Alamofire.request("https://blog-api.turathalanbiaa.com/api/loginuser", method: .post, parameters: json, encoding: JSONEncoding.default)
            .responseJSON { (response) in
                if response.result.isSuccess{
                    print(response)
                }
                else{
                    print("error")
                }
        }
        
        
        
/*
print("button was pressed")
        let jsonData = try? JSONSerialization.data(withJSONObject: json)

        // create post request
        let url = URL(string: "https://blog-api.turathalanbiaa.com/api/loginuser")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
print("finnished link")
        // insert json data to the request
        request.httpBody = jsonData

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            print("suppose to print datta")
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print(responseJSON)
            }
        }
print("button was pressed")
        task.resume() */
    }
    /*
    @IBAction func LogInByFB(_ sender: Any) {
        let manager = LoginManager()
                manager.logIn(permissions: [.publicProfile, .email], viewController: self)
                {
                    (Result) in switch Result
                    {
                    case.cancelled:
                        print("user cancelled process")
                        break
                    case.failed(let error):
                        print("failed \(error)")
                        break
                    case.success(granted: let grant, declined: let dec, token: let token):
                        print("access token \(token)")
                        
                        
                        
                }
    }
    
} */
}
