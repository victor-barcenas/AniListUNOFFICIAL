//
//  Login.swift
//  AniList
//
//  Created by Victor Alfonso Barcenas Monreal on 16/04/17.
//  Copyright © 2017 Victor Barcenas. All rights reserved.
//

import UIKit

class Login: UIViewController, UITextFieldDelegate, RESTClientDelegate{
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var codeTextField: UITextField!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: 667)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
         self.navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func loginAction(_ sender: Any) {
        let code = codeTextField.text!
        if code != "" {
            User().login(delegate: self, sender: self, code: code, refresh: false)
        }else{
            Alerts(viewController: self).newAlert(title: "Error", message: "You should provide a valid code")
        }
    }
    
    @IBAction func getCodeAction(_ sender: Any) {
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        var point:CGPoint!
        point  = CGPoint(x: 0, y: ((textField.superview?.frame.origin.y)! + textField.frame.origin.y)-300)
        scrollView.setContentOffset(point , animated: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let point = CGPoint(x: 0, y: 0)
        scrollView.setContentOffset(point , animated: true)
    }
    
    func errorWithNSError(error: Error) {
        print(error.localizedDescription)
    }
    
    func successWithDictionary(response: Dictionary<String, AnyObject>, service: ServiceType) {
        print(response)
        let helpers = Helpers()
        let errorDict = helpers.checkIfDictionaryExistsInDictionary(key: "error", dictionary: response)
        if errorDict != nil{
            Alerts(viewController: self).newAlert(title: "Error", message: "The code provided is invalid or is not longer valid")
        }else{
            let defaults = UserDefaults.standard
            let sessionToken = helpers.checkIfStringExistsInDictionary(key: "access_token", dictionary: response)
            let refreshToken = helpers.checkIfStringExistsInDictionary(key: "refresh_token", dictionary: response)
            defaults.set(sessionToken, forKey: "sessionToken")
            defaults.set(refreshToken, forKey: "refreshToken")
            defaults.synchronize()
        }
    }
}
