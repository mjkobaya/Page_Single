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

    var name = "default name" // Name of user
    var username = "default username" // User's username
    var department = "default department" // User's hospital department
    var rank = "default rank" // User's rank
    var onDutyStatus = "off" // String on / off
    
    func addProperties(#infoDict: [String : String])
    {
        for (property, value) in infoDict
        {
            if (property == "name")
            {
                self.name = value
            }
            else if (property == "username")
            {
                self.username = value
            }
            else if (property == "department")
            {
                self.department = value
            }
            else if (property == "rank")
            {
                self.rank = value
            }
            else if (property == "onDutyStatus")
            {
                self.onDutyStatus = value
            }
            else
            {
                println("Error in User.addProperties: Property given is not a member of the User class")
            }
        }
        
    }
   
}
