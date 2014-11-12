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
    
    let id: Int // ID number of the user from database
    let name: String // Name of user
    let username: String // User's username
    let password: String // User's password
    let department: String // User's hospital department
    let rank: String // User's rank
    let onDutyStatus: Int // Integer 0 -> off duty, 1 -> on duty
    
    init(id: Int, name: String, username: String, password: String,
        department: String, rank: String, onDutyStatus: Int)
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
