//
//  PageDetailsViewController.swift
//  Page_Single
//
//  Created by M Kobayashi on 11/15/14.
//  Copyright (c) 2014 Team 3. All rights reserved.
//

import UIKit

class PageDetailsViewController: UIViewController {
    
    var user: User!
    var database: Database!
    var sender: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        println("Sender passed is \(sender)")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
        if (segue.identifier == "replySegue")
        {
            // Need name of next view's view controller
            let svc = segue.destinationViewController as ComposeViewController;
            svc.user = self.user
            svc.database = self.database
        }
    }

    
}
