//
//  RESTClient.swift
//  SofttekRides
//
//  Created by Victor Alfonso Barcenas Monreal on 06/03/17.
//  Copyright © 2017 Softtek. All rights reserved.
//

import Foundation
import UIKit
import Alamofire


class RESTClient : NSObject{
    
    var sessionManager:Alamofire.SessionManager
    var networkManager:Alamofire.NetworkReachabilityManager
    var activityIndicator:ActivityIndicatorView?
    let headers = [
        "Authorization":"Bearer \(User.sessionToken)",
        "Content-Type":"application/x-www-form-urlencoded"
    ]
    
    override init(){
        self.activityIndicator = ActivityIndicatorView(title: "", center: CGPoint(x: 0, y: 0))
        self.sessionManager = SessionManager()
        self.sessionManager.session.configuration.timeoutIntervalForRequest = 30
        self.networkManager = Alamofire.NetworkReachabilityManager()!
        networkManager.startListening()
        
    }
    
    func showActivityIndicator(sender:UIViewController, message:String){
        self.activityIndicator = ActivityIndicatorView(title: message, center: sender.view.center)
        sender.view.addSubview(self.activityIndicator!.getViewActivityIndicator())
        self.activityIndicator?.startAnimating()
    }
    
    func hideActivityIndicator(){
        self.activityIndicator?.stopAnimating()
    }
    
    func networkError()->NSError{
        self.networkManager.stopListening()
        return NSError(domain: "NetworkError", code: 0, userInfo: nil)
    }
    
    func customError(message:String, domain:String,code:Int)->NSError{
        self.networkManager.stopListening()
        return NSError(domain: domain, code: code, userInfo: [domain:message])
    }
    
    func responseHandler(response:Result<Any>, delegate:RESTClientDelegate, service:ServiceType){
        if response.value != nil {
            let isDictionary = response.value is Dictionary<String,AnyObject>
            var JSON:AnyObject = "" as AnyObject
            if  isDictionary {
                JSON = response.value! as AnyObject
                delegate.successWithDictionary!(response: JSON as! Dictionary<String, AnyObject>, service: service)
            }else{
                JSON = response.value! as AnyObject
                delegate.successWithArray!(response: JSON as! Array<AnyObject>, service: service)
            }
            
        }
    }
}

