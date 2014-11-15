//
//  ViewController.swift
//  Page_Single
//
//  Created by M Kobayashi on 11/7/14.
//  Copyright (c) 2014 Team 3. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    // Member variables and constants
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLogInLabel: UILabel!
    
    var status = 0
    let user = User()
    
    // When Log In button is pressed
    @IBAction func logInButton(sender: UIButton) {
        
        // TEST OUTPUT
        println(usernameTextField.text)
        println(passwordTextField.text)
        
        // Get username and password from text fields
        let logInSession = LogIn(username: usernameTextField.text, password: passwordTextField.text)
        
        // If username and password match, segue into navigation controller
        if logInSession.match() == 1
        {
            //self.status = 1
            
            // Initialize a user
            let database = Database(url: "http://page-40339.onmodulus.net")
            let b = database.login(username: "Melind", password: "password")
                {(succeeded: Bool, user: User) -> () in
                    if (succeeded)
                    {
                        self.status = 1
                        self.shouldPerformSegueWithIdentifier("logInSegue", sender: sender)
                    }
                    else
                    {
                        self.shouldPerformSegueWithIdentifier("logInSegue", sender: sender)
                    }
                }
            println(b)
            //shouldPerformSegueWithIdentifier("logInSegue", sender: sender)
        }
        
        // Else, update with "Username or password are incorrect"
        else
        {
            //shouldPerformSegueWithIdentifier("logInSegue", sender: sender)
        }
    }
    
   
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        if (textField == usernameTextField)
        {
            passwordTextField.becomeFirstResponder()
            //return true
        }
        
        else if (textField == passwordTextField)
        {
            textField.resignFirstResponder()
            //return true
        }
        
        return true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        // Pass info to InboxTableViewController
        if (segue.identifier == "logInSegue")
        {
            let nav: AnyObject = segue.destinationViewController
            var svc = nav.topViewController as InboxTableViewController;
            svc.user = self.user
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
            errorLogInLabel.hidden = false
            return false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        usernameTextField.delegate = self
        passwordTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}