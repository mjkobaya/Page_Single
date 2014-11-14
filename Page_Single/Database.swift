//
//  Database.swift
//  Page_Single
//
//  Created by M Kobayashi on 11/14/14.
//  Copyright (c) 2014 Team 3. All rights reserved.
//

import UIKit

class Database: NSObject {
    
    let url: String
    
    init(url: String)
    // url in 'http://page-40339.onmodulus.net' without forward slash at end'
    {
        self.url = url
    }

    // Login
    func login(username: String, password: String) -> User
    {
        let url = self.url + "/mobile/login"
        
        return User(i: true)
    }
}
