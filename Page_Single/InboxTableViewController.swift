//
//  InboxTableViewController.swift
//  Page_Single
//
//  Created by M Kobayashi on 11/12/14.
//  Copyright (c) 2014 Team 3. All rights reserved.
//

import UIKit

@objc(InboxTableViewController) class InboxTableViewController: UITableViewController, UITableViewDelegate, UITableViewDataSource {
    
    var user: User!
    var database: Database!
    var messages = [Dictionary<String, String>()]
    var sender = ""
    var message = ""
    var refresh = UIRefreshControl()
    var onDutyClinicians = []
    
    let items = [["Dr. Misha Wong", "FYI Call me back as soon as possible"], ["Dr. Aashay Vyas", "Consult MRN: 12345678 Patient consult meeting at 2"]]
    
    @IBOutlet var inboxTableView: UITableView!
    @IBAction func onDutySwitch(sender: UISwitch) {
        println("onDutySwitch")
        println("Username passed to InboxTableView is \(user.username)")
    }
    
    @IBAction func unwindToInbox(s:UIStoryboardSegue) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        // Register the class to control the cell (only do for custom classes)
        //self.inboxTableView.registerClass(UITableViewCell.self,
        //forCellReuseIdentifier: "subtitleCell")
        
        // Get messages from database
        database.getMessages(username: user.username) { (succeeded, messages) -> () in
            
            // Move to the UI thread
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                
                println("succeeded is \(succeeded)")
                if (succeeded)
                {
                    self.messages = messages as Array<Dictionary<String, String>>
                }
                else
                {
                    println("Something went wrong")
                }
            })
        }
    
        database.getSearchUsers(department: "oncology") { (succeeded, onDutyClinicians) -> () in
            
            // Move to the UI thread
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                
                println("succeeded is \(succeeded)")
                if (succeeded)
                {
                    self.onDutyClinicians = onDutyClinicians as NSArray
                }
                else
                {
                    println("Something went wrong")
                }
            })
        }
        
        println("check")
        
            self.inboxTableView.reloadData()
            self.refresh = UIRefreshControl()
            self.refresh.attributedTitle = NSAttributedString(string: "Pull to refersh")
            self.refresh.addTarget(self, action: "refreshTable:", forControlEvents: UIControlEvents.ValueChanged)
            self.tableView.addSubview(self.refresh)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func refreshTable(sender:AnyObject)
    {
        // Code to refresh table view
        self.refresh.beginRefreshing()
        self.inboxTableView.reloadData()
        self.refresh.endRefreshing()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.messages.count
        //return 4
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("subtitleCell", forIndexPath: indexPath) as UITableViewCell
        
        // Configure the cell...
        cell.textLabel.text = self.messages[indexPath.row]["originalSender"]
        //Unwrap cell.detailTextLabel with ! when know it's not nil b/c of
        //? option on the cell type
        cell.detailTextLabel!.text = self.messages[indexPath.row]["message"]
        
//        // Configure the cell...
//        cell.textLabel.text = self.items[indexPath.row][0]
//        // Unwrap cell.detailTextLabel with ! when know it's not nil b/c of
//        // ? option on the cell type
//        cell.detailTextLabel!.text = self.items[indexPath.row][1]
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.sender = self.messages[indexPath.row]["originalSender"]!
        self.message = self.messages[indexPath.row]["message"]!
        
        let test = self.onDutyClinicians[0]["rank"]! as String
        println("clinician is of rank \(test)")
        self.performSegueWithIdentifier("detailsSegue", sender: sender)
        //self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool
    {
        return false
    }
    

    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the specified item to be editable.
    return true
    }
    */
    
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
    // Delete the row from the data source
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    }
    */
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the item to be re-orderable.
    return true
    }
    */
    
    
    // MARK: - Navigation
    
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    // Pass info to InboxTableViewController
        if (segue.identifier == "newPageSegue")
        {
            let svc = segue.destinationViewController as contactsTableViewController;
            svc.user = self.user
            svc.database = self.database
        }
        else if (segue.identifier == "detailsSegue")
        {
            let svc = segue.destinationViewController as PageDetailsViewController;
            svc.user = self.user
            svc.database = self.database
            svc.sender = self.sender
            svc.message = self.message
        }
    
    }
    
    
}
