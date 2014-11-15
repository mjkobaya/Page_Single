//
//  SettingsViewController.swift
//  Page_Single
//
//  Created by M Kobayashi on 11/15/14.
//  Copyright (c) 2014 Team 3. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBAction func logOutButtonPressed(sender: UIButton) {
        self.performSegueWithIdentifier("unwindToLogin", sender: sender)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        println("prepareForSegue called")
        super.prepareForSegue(segue, sender: sender)
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        println("shouldPerformSegueWithIdentifier called")
        //super.shouldPerformSegueWithIdentifier(identifier, sender: sender)
        return true
    }
    
}
