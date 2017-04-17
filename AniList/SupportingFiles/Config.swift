//
//  Config.swift
//  AniList
//
//  Created by Victor Alfonso Barcenas Monreal on 16/04/17.
//  Copyright © 2017 Victor Barcenas. All rights reserved.
//

import UIKit

struct Config {
    struct endPoints {
        private static let api = "https://anilist.co/api/"
        static let authorize = api + "auth/authorize"
        static let authorizationPinUrl = authorize + "?grant_type=authorization_pin&client_id=" + credentials.clientId + "&response_type=pin"
        static let authentication = api + "auth/access_token"
    }
    
    struct credentials{
        static let clientId = "victorbarcenas-xkl0k"
        static let clientSecret = "VwjdBNi4JPkq28Yw3nvrVK9dOJ"
    }
    
    struct Colors{
        struct Indicator{
            static let font = UIColor.white
            static let background = UIColor(red:0.15, green:0.74, blue:0.98, alpha:1.0)
        }
    }
}
