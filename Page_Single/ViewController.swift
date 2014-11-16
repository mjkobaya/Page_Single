//
//  ViewController.swift
//  Page_Single
//
//  Created by M Kobayashi on 11/7/14.
//  Copyright (c) 2014 Team 3. All rights reserved.
//

import UIKit

@objc(ViewController) class ViewController: UIViewController, UITextFieldDelegate {
    
    // Member variables and constants
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLogInLabel: UILabel!
    
    var status = 0
    var user = User()
    let database = Database(url: "http://page-40339.onmodulus.net")
    
    @IBAction func unwindToLogin(s:UIStoryboardSegue) {
    }
    
    // When Log In button is pressed
    @IBAction func logInButton(sender: UIButton) {
        
        // TEST OUTPUT
        println(usernameTextField.text)
        println(passwordTextField.text)
        
        // Ask database if login was a success
        self.database.login(username: usernameTextField.text, password: passwordTextField.text)
            {(succeeded: Bool, user: User) -> () in
                
                // Move to the UI thread
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    
                    println("succeeded is \(succeeded)")
                    if (succeeded)
                    {
                        self.user = user
                        self.errorLogInLabel.hidden = true
                        self.performSegueWithIdentifier("logInSegue", sender: sender)
                    }
                    else
                    {
                        self.errorLogInLabel.hidden = false
                    }
                })
        }
    }
    
    
    // Configure the return key to go to next text field or hide keyboard
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        if (textField == usernameTextField)
        {
            passwordTextField.becomeFirstResponder()
        }
            
        else if (textField == passwordTextField)
        {
            textField.resignFirstResponder()
        }
        
        return true
    }
    
    // Pass the User object to the InboxTableViewController
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        // Pass info to InboxTableViewController
        if (segue.identifier == "logInSegue")
        {
            let nav: AnyObject = segue.destinationViewController
            var svc = nav.topViewController as InboxTableViewController;
            svc.user = self.user
            svc.database = self.database
        }
    }
    
    // Perform the segue if status is 1. Show invalid username and password
    // label if status is 0.
    // Need to keep override function to override default to allow all segues
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool
    {
        //        if self.status == 2
        //        {
        //            println("status 1 got called")
        //            return true
        //        }
        //
        //        else if self.status == 1
        //        {
        //            self.errorLogInLabel.hidden = false
        //            return false
        //        }
        //        else
        //        {
        //            return false
        //        }
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Set ViewController as delegate for text fields
        usernameTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}