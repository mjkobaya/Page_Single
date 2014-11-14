//
//  Message.swift
//  Page_Single
//
//  Message object class
//
//  Created by M Kobayashi on 11/12/14.
//  Copyright (c) 2014 Team 3. All rights reserved.
//

import UIKit

class Message: NSObject {
    
    // Default values
    var numberMessages = 2
    
    // Test messages
    var messages: [[String : String]] = [["senderName" : "Dr. Misha Wong",
        "message" : "Hello this is a test"], ["senderName" : "Dr. Claire Wong",
        "message" : "Patient lalala test"]]
    
    func getUserMessages() -> [[String : String]]
    {
        return self.messages
    }
    
    func getNumberMessages() -> Int
    {
        return self.numberMessages
    }
    
}
