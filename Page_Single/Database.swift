//
//  Database.swift
//  Page_Single
//
//  Created by M Kobayashi on 11/14/14.
//  Copyright (c) 2014 Team 3. All rights reserved.
//

import UIKit

class Database: NSObject {
    
    // Member variables and constants
    let url: String
    
    // Initialize with url of host database
    init(url: String)
    {
        // 'http://page-40339.onmodulus.net' without forward slash at end'
        self.url = url
    }
    
    // Login
    func login(#username: String, password: String, postCompleted: (succeeded: Bool, user: User) -> ())
    {
        // http://page-40339.onmodulus.net/mobile/login
        let url: String = self.url + "/mobile/login"
        let method = "POST"
        let nsurl = NSURL(string: url)
        
        var request = NSMutableURLRequest(URL: nsurl!)
        var session = NSURLSession.sharedSession()
        request.HTTPMethod = method
        
        var params = ["email" : username, "password" : password]
        
        var err: NSError?
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params,
            options: nil, error: &err)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            println("Response: \(response)")
            var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
            println("Body: \(strData)")
            var err: NSError?
            var json = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &err) as NSDictionary?
            
            // How to access the values in dictionary. Must be downcasted type
            // get rid of Optional() wrapping
            //var id: NSString = json!["_id"] as NSString
            //println("id is \(id)")
            
            
            var msg = "No message"
            
            // Did the JSONObjectWithData constructor return an error? If so, log the error to the console
            if(err != nil) {
                println(err!.localizedDescription)
                let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
                println("Error could not parse JSON: '\(jsonStr)'")
            }
            else {
                // The JSONObjectWithData constructor didn't return an error.
                // Check that the json has a value and that the login was
                // successful.
                let user = User()
                
                if let parseJSON = json {
                    // Okay, the parsedJSON is here
                    // Check that there's an _id key which means the login
                    // succeeded.
                    if let id: AnyObject = json!["_id"]
                    {
                        let userDictionary = ["username" : username]
                        user.addProperties(infoDict: userDictionary)
                        println("Successfully logged in")
                        postCompleted(succeeded: true, user: user)
                        return
                    }
                    else
                    {
                        let error: AnyObject? = json!["error"] as NSString
                        println("Error: \(error)")
                        postCompleted(succeeded: false, user: user)
                        return
                    }
                }
                else {
                    // Woa, okay the json object was nil, something went worng. Maybe the server isn't running?
                    let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
                    println("Error could not parse JSON: \(jsonStr)")
                    postCompleted(succeeded: false, user: user)
                }
            }
        })
        
        task.resume()
    }

}

