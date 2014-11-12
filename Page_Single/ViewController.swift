//
//  ViewController.swift
//  Page_Single
//
//  Created by M Kobayashi on 11/7/14.
//  Copyright (c) 2014 Team 3. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var status = 0
    @IBAction func logInButton(sender: UIButton) {
        
        println(usernameTextField.text)
        println(passwordTextField.text)
        
        // On Log In button click check database to see if user name
        // and password match
        // For now, hard code
        
        let logInSession = LogIn(username: usernameTextField.text, password: passwordTextField.text)
        
        // If username and password match, segue into navigation controller
        if logInSession.match() == 1
        {
            println("inside if statement")
            self.status = 1
            shouldPerformSegueWithIdentifier("logInSegue", sender: sender)
        }
        
        // Else, update with "Username or password are incorrect"
        else
        {
            println("Username and password did not match.")
            shouldPerformSegueWithIdentifier("logInSegue", sender: sender)
        }
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool
    {
        if self.status == 1
        {
            return true
        }
        
        else
        {
            return false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}