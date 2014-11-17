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
    
    // Send message
    func sendMessage(#sender: String, receiver: String, message: String,
        postCompleted: (succeeded: Bool) -> ())
    {
        // http://page-40339.onmodulus.net/mobile/messages
        let url: String = self.url + "/mobile/messages"
        let method = "POST"
        let nsurl = NSURL(string: url)
        
        var request = NSMutableURLRequest(URL: nsurl!)
        var session = NSURLSession.sharedSession()
        request.HTTPMethod = method
        
        var params = ["originalSender" : sender, "receiver" : receiver,
            "message" : message]
        
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
                
                if let parseJSON = json {
                    // Okay, the parsedJSON is here
                    // Check that there's an _id key which means the login
                    // succeeded.
                    //                    if let message: AnyObject = json!["message"]
                    //                    {
                    //                        println("Successfully posted message")
                    //                        postCompleted(succeeded: true)
                    //                        return
                    //                    }
                    // Not currently any way to check if the message was posted
                    // or not.
                    //                    else
                    //                    {
                    //                        let error: AnyObject? = json!["error"] as NSString
                    //                        println("Error: \(error)")
                    //                        postCompleted(succeeded: false, user: user)
                    //                        return
                    //                    }
                    println("Message posted")
                    return
                }
                else {
                    // Woa, okay the json object was nil, something went worng. Maybe the server isn't running?
                    let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
                    println("Error could not parse JSON: \(jsonStr)")
                    postCompleted(succeeded: false)
                }
            }
        })
        
        task.resume()
    }
    
    
    // Get messages
    func getMessages(#username: String,
        postCompleted: (succeeded: Bool, messages: AnyObject) -> ())
    {
        // http://page-40339.onmodulus.net/mobile/messages?email=Melinda
        let url: String = self.url + "/mobile/messages?email=" + username
        println(url)
        let method = "GET"
        let nsurl = NSURL(string: url)
        
        var request = NSMutableURLRequest(URL: nsurl!)
        var session = NSURLSession.sharedSession()
        request.HTTPMethod = method
        
        //var params = ["email" : username]
        
        var err: NSError?
        //request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params,
        //    options: nil, error: &err)
        //request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        //request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            println("Response: \(response)")
            var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
            println("Body: \(strData)")
            var err: NSError?
            var json = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &err) as NSArray?
            println("Check")
            
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
                
                if let parseJSON = json {
                    // Okay, the parsedJSON is here
                    // Check that there's an _id key which means the login
                    // succeeded.
                    //if let message: AnyObject = json[0]
                    //{
                    println("Successfully got messages")
                    postCompleted(succeeded: true, messages: json! as Array<Dictionary<String, String>>)
                    return
                    //}
                    // Not currently any way to check if the message was posted
                    // or not.
                    //                    else
                    //                    {
                    //                        let error: AnyObject? = json!["error"] as NSString
                    //                        println("Error: \(error)")
                    //                        postCompleted(succeeded: false, user: user)
                    //                        return
                    //                    }
                }
                else {
                    // Woa, okay the json object was nil, something went worng. Maybe the server isn't running?
                    let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
                    println("Error could not parse JSON: \(jsonStr)")
                    postCompleted(succeeded: false, messages: json! as NSArray)
                }
            }
        })
        
        task.resume()
        
        
    }
    
    // Get user for search
    func getSearchUsers(#department: String,
        postCompleted: (succeeded: Bool, onDutyClinicians: AnyObject) -> ())
    {
        // http://page-40339.onmodulus.net/mobile/search/department?department=oncology
        let url: String = self.url + "/mobile/search/department?department=" + department
        println(url)
        let method = "GET"
        let nsurl = NSURL(string: url)
        
        var request = NSMutableURLRequest(URL: nsurl!)
        var session = NSURLSession.sharedSession()
        request.HTTPMethod = method
        
        //var params = ["email" : username]
        
        var err: NSError?
        //request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params,
        //    options: nil, error: &err)
        //request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        //request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            println("Response: \(response)")
            var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
            println("Body: \(strData)")
            var err: NSError?
            var json = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &err) as NSArray?
            println("Check")
            
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
                
                if let parseJSON = json {
                    // Okay, the parsedJSON is here
                    // Check that there's an _id key which means the login
                    // succeeded.
                    //if let message: AnyObject = json[0]
                    //{
                    println("Successfully got onDutyClinicians")
                    postCompleted(succeeded: true, onDutyClinicians: json! as NSArray)
                    return
                    //}
                    // Not currently any way to check if the message was posted
                    // or not.
                    //                    else
                    //                    {
                    //                        let error: AnyObject? = json!["error"] as NSString
                    //                        println("Error: \(error)")
                    //                        postCompleted(succeeded: false, user: user)
                    //                        return
                    //                    }
                }
                else {
                    // Woa, okay the json object was nil, something went worng. Maybe the server isn't running?
                    let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
                    println("Error could not parse JSON: \(jsonStr)")
                    postCompleted(succeeded: false, onDutyClinicians: json! as NSArray)
                }
            }
        })
        
        task.resume()
        
        
    }
    
    // Get user info
    func getUserInfo(#username: String,
        postCompleted: (succeeded: Bool, userInfo: AnyObject) -> ())
    {
        // http://page-40339.onmodulus.net/mobile/user?email=user3
        let url: String = self.url + "/mobile/user?email=" + username
        println(url)
        let method = "GET"
        let nsurl = NSURL(string: url)
        
        var request = NSMutableURLRequest(URL: nsurl!)
        var session = NSURLSession.sharedSession()
        request.HTTPMethod = method
        
        //var params = ["email" : username]
        
        var err: NSError?
        //request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params,
        //    options: nil, error: &err)
        //request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        //request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            println("Response: \(response)")
            var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
            println("Body: \(strData)")
            var err: NSError?
            var json = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &err) as NSDictionary?
            println("Check")
            
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
                
                if let parseJSON = json {
                    // Okay, the parsedJSON is here
                    // Check that there's an _id key which means the login
                    // succeeded.
                    //if let message: AnyObject = json[0]
                    //{
                    println("Successfully got userInfo")
                    postCompleted(succeeded: true, userInfo: json! as Dictionary<String, String>)
                    return
                    //}
                    // Not currently any way to check if the message was posted
                    // or not.
                    //                    else
                    //                    {
                    //                        let error: AnyObject? = json!["error"] as NSString
                    //                        println("Error: \(error)")
                    //                        postCompleted(succeeded: false, user: user)
                    //                        return
                    //                    }
                }
                else {
                    // Woa, okay the json object was nil, something went worng. Maybe the server isn't running?
                    let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
                    println("Error could not parse JSON: \(jsonStr)")
                    postCompleted(succeeded: false, userInfo: json! as NSDictionary)
                }
            }
        })
        
        task.resume()
        
        
    }
}

