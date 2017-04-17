//
//  RESTClientDelegate.swift
//  SofttekRides
//
//  Created by Victor Alfonso Barcenas Monreal on 06/03/17.
//  Copyright © 2017 Softtek. All rights reserved.
//

import Foundation

@objc protocol RESTClientDelegate{
    
    @objc optional func successWithArray(response: Array<AnyObject>, service:ServiceType)
    @objc optional func successWithDictionary(response: Dictionary<String, AnyObject>, service:ServiceType)
    @objc optional func successWithDictionary(response: Dictionary<String, AnyObject>, service:ServiceType, user:User)
    func errorWithNSError(error:Error)
}

@objc enum ServiceType:Int{
    case None
    case Login
}
