//
//  AuthenticationCodeVC.swift
//  AniList
//
//  Created by Victor Alfonso Barcenas Monreal on 16/04/17.
//  Copyright © 2017 Victor Barcenas. All rights reserved.
//

import UIKit

class AuthenticationCodeVC:UIViewController{
    
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let request = NSURLRequest(url: NSURL(string: Config.endPoints.authorizationPinUrl)! as URL)
        webView.loadRequest(request as URLRequest)
    }
}
