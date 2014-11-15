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
    func login(#username: String, password: String, postCompleted : (succeeded: Bool, msg: String) -> ())
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
            var json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: &err) as? NSDictionary
            
            var msg = "No message"
            
            // Did the JSONObjectWithData constructor return an error? If so, log the error to the console
            if(err != nil) {
                println(err!.localizedDescription)
                let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
                println("Error could not parse JSON: '\(jsonStr)'")
                postCompleted(succeeded: false, msg: "Error")
            }
            else {
                // The JSONObjectWithData constructor didn't return an error. But, we should still
                // check and make sure that json has a value using optional binding.
                if let parseJSON = json {
                    // Okay, the parsedJSON is here, let's get the value for 'success' out of it
                    if let success = parseJSON["success"] as? Bool {
                        println("Succes: \(success)")
                        postCompleted(succeeded: success, msg: "Logged in.")
                    }
                    return
                }
                else {
                    // Woa, okay the json object was nil, something went worng. Maybe the server isn't running?
                    let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
                    println("Error could not parse JSON: \(jsonStr)")
                    postCompleted(succeeded: false, msg: "Error")
                }
            }
        })
        
        task.resume()
        
        //println(task.response)
        
    }
}

let database = Database(url: "http://page-40339.onmodulus.net/mobile/login")
database.login(username: "Melinda", password: "password") {(succeeded: Bool, msg: String) -> () in

    println(succeeded)}


let optional: String? = "0"
let i = optional!.toInt()
let a = 1 + i!