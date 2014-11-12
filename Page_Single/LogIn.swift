//
//  LogIn.swift
//  Page_Single
//
//  Class specifying a LogIn object to create a log in session
//
//  Created by M Kobayashi on 11/9/14.
//  Copyright (c) 2014 Team 3. All rights reserved.
//

import UIKit

class LogIn: NSObject {
    
    let username: String
    let password: String
    
    init(username: String, password: String)
    {
        self.username = username
        self.password = password
    }
    
    func match() -> Int
    {
        // Check that username and password given match the ones on the database
        
        // Contact database and retrieve user info
        
        // Check that they match
        if self.username == "Melinda" && self.password == "password"
        {
            return 1
        }
        
        else
        {
            return 0
        }
    }
   
}
