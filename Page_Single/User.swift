//
//  User.swift
//  Page_Single
//
//  Class for User object which represents the user when app is signed into
//
//  Created by M Kobayashi on 11/11/14.
//  Copyright (c) 2014 Team 3. All rights reserved.
//

import UIKit

class User: NSObject {
    
    var id: Int // ID number of the user from database
    var name: String // Name of user
    var username: String // User's username
    var password: String // User's password
    var department: String // User's hospital department
    var rank: String // User's rank
    var onDutyStatus: Int // Integer 0 -> off duty, 1 -> on duty
    
    init(i: Bool)
    {
        self.id = 0
        self.name = ""
        self.username = ""
        self.password = ""
        self.department = ""
        self.rank = ""
        self.onDutyStatus = 0
    }
    
    func addProperties(id: Int, name: String, username: String,
        password: String, department: String, rank: String,
        onDutyStatus: Int)
    {
        self.id = id
        self.name = name
        self.username = username
        self.password = password
        self.department = department
        self.rank = rank
        self.onDutyStatus = onDutyStatus
    }
   
}
