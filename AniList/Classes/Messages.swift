//
//  Messages.swift
//  SofttekRides
//
//  Created by Victor Alfonso Barcenas Monreal on 06/03/17.
//  Copyright © 2017 Softtek. All rights reserved.
//


import Foundation
import UIKit
import Alamofire

@objc protocol AlertsDelegate{
    @objc optional func didCancelAlert(withViewController controller:UIViewController)
    @objc optional func didAcceptAlert(withViewController controller:UIViewController)
}

class Alerts{
    
    private let helpers:Helpers = Helpers()
    private let _currentViewController:UIViewController!
    private var alertDelegate:AlertsDelegate!
    
    //Set the delegate when you wnat to do additional action on alert button clicked
    init (viewController:UIViewController, delegate:AlertsDelegate? = nil){
        _currentViewController = viewController
        if delegate != nil{
            alertDelegate = delegate!
        }
    }
    
    func newAlert(title:String,message:String){
        let alert:UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (UIAlertAction) in
            alert.dismiss(animated: true, completion: nil)
            if self.alertDelegate != nil {
                self.alertDelegate.didAcceptAlert!(withViewController: self._currentViewController)
            }
        }))
        _currentViewController.present(alert, animated: true, completion: nil)
    }
    
    func newActionSheet(title:String,message:String,actions:Array<UIAlertAction>){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        for action in actions{
            alert.addAction(action)
        }
        _currentViewController.present(alert, animated: true, completion: nil)
    }
    
    func errorAlert(error:Error){
        newAlert(title: "Error", message: error.localizedDescription)
    }
    
    func networkError(){
        newAlert(title: "Error", message: "There's no internet connection")
    }
}
