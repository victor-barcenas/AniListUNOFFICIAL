//
//  User.swift
//  AniList
//
//  Created by Victor Alfonso Barcenas Monreal on 16/04/17.
//  Copyright © 2017 Victor Barcenas. All rights reserved.
//

import UIKit
import Alamofire

class User:RESTClient{
    
    func login(delegate:RESTClientDelegate, sender:UIViewController, code:String, refresh:Bool){
        if networkManager.isReachable {
            showActivityIndicator(sender: sender, message: "Loading")
            var params:Dictionary<String,Any> = Dictionary()
            if refresh {
                params = [
                    "grant_type":"refresh_token",
                    "client_id":Config.credentials.clientId,
                    "client_secret":Config.credentials.clientSecret,
                    "refresh_token":User.refreshToken
                ]
            }else{
                params = [
                "grant_type":"authorization_pin",
                "client_id":Config.credentials.clientId,
                "client_secret":Config.credentials.clientSecret,
                "code":code
                ]
            }
            sessionManager.request(Config.endPoints.authentication, method: .post, parameters: params, encoding: URLEncoding.default, headers: [:]).responseJSON{ response in
                self.hideActivityIndicator()
                if (response.result.isFailure){
                    delegate.errorWithNSError(error: response.result.error!)
                }else{
                    self.responseHandler(response: response.result, delegate: delegate, service: .Login)
                }
            }
        }else{
            hideActivityIndicator()
            Alerts(viewController: sender).networkError()
        }
    }
    
    class var sessionToken:String{
        if UserDefaults.standard.object(forKey: "sessionToken") != nil{
            return UserDefaults.standard.object(forKey: "sessionToken") as! String
        }
        return ""
    }
    
    class var refreshToken:String!{
        if UserDefaults.standard.object(forKey: "refreshToken") != nil {
            return UserDefaults.standard.object(forKey: "refreshToken") as! String
        }
        return ""
    }
}
