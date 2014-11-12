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
    @IBOutlet weak var errorLogInLabel: UILabel!
    
    var status = 0
    var user = User(i: true)

//    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?)
//    {
//        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
//        
//        // Custom initialization
//        var user: User
//    }
//    
//    required init(coder aDecoder: (NSCoder!))
//    {
//        super.init(coder: aDecoder)
//    }
    
    @IBAction func logInButton(sender: UIButton) {
        
        // TEST OUTPUT
        println(usernameTextField.text)
        println(passwordTextField.text)
        
        // On Log In button click check database to see if user name
        // and password match
        // For now, hard code
        
        let logInSession = LogIn(username: usernameTextField.text, password: passwordTextField.text)
        
        // If username and password match, segue into navigation controller
        if logInSession.match() == 1
        {
            self.status = 1
            
            // Initialize a user
            user.addProperties(1, name: "Melinda Kobayashi", username: "Melinda", password: "password", department: "Oncology", rank: "Fellow", onDutyStatus: 0)
            shouldPerformSegueWithIdentifier("logInSegue", sender: sender)
        }
        
        // Else, update with "Username or password are incorrect"
        else
        {
            shouldPerformSegueWithIdentifier("logInSegue", sender: sender)
        }
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}