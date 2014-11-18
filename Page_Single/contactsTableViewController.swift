//
//  contactsTableViewController.swift
//  Page_Single
//
//  Created by Kay Lab on 11/14/14.
//  Copyright (c) 2014 Team 3. All rights reserved.
//

import UIKit

class contactsTableViewController: UITableViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    
    var user: User!
    var database: Database!
    var pickerSelection = ""
    var onDuty = [[String : String]]()
    var status = 0
    var sender = ""
    
    @IBOutlet var contactsTableView: UITableView!
    @IBOutlet weak var myPicker: UIPickerView!
    let pickerData = ["", "Radiology", "Pediatrics", "Oncology", "Cardiology"]
    let onDutyClinicians = [["username" : "AashayVyas", "rank" : "Resident"],
        ["username" : "MelindaKobayashi", "rank" : "Fellow"], ["username" : "AashayVyas", "rank" : "Resident"]]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myPicker.delegate = self
        myPicker.dataSource = self
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        println("In contactsTableViewController user.username is \(self.user.username)")
        
    }
    
//    func getOnDutyClinicians()
//    {
//        database.getSearchUsers(department: self.pickerSelection) { (succeeded, onDutyClinicians) -> () in
//            
//            // Move to the UI thread
//            // Suspend getMessages queue
//            dispatch_suspend(dispatch_get_main_queue())
//            
//            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), { () -> Void in
//                
//                println("succeeded is \(succeeded)")
//                if (succeeded)
//                {
//                    let limit = onDutyClinicians.count - 1
//                    for index in 0...limit
//                    {
//                        var tempDict = [String : String]()
//                        let d = onDutyClinicians[index] as NSDictionary
//                        for (key, value) in d
//                        {
//                            if (key as String != "local")
//                            {
//                                let k: String = key as String
//                                let v: String = value as String
//                                println("k is \(k)")
//                                println("v is \(v)")
//                                tempDict.updateValue(v, forKey: k)
//                            }
//                        }
//                        self.onDuty.append(tempDict)
//                    }
//                    //onDutyClinicians as Array<Dictionary<String, String>>
//                }
//                    
//                else
//                {
//                    println("Something went wrong")
//                }
//                self.contactsTableView.reloadData()
//            })
//        }
//
//    }
    //MARK: - Delegates and data sources
    //MARK: Data Sources
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    //MARK: Delegates
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return pickerData[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
//        // Reset onDuty to count 0
//        //self.onDuty = [[String : String]]()
//        
//        // Set self.pickerSelection to the currently selected department
//        self.pickerSelection = pickerData[row]
//        
//        //Get the onDutyClinicians in the department
//        getOnDutyClinicians()
//        
//        // Reload table view
//        self.contactsTableView.reloadData()
//        println("contactsTableView data was reloaded")
        self.contactsTableView.reloadData()
        
    }

    
    //func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    //   myLabel.text = pickerData[row]
    // }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        return self.onDutyClinicians.count
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.sender = self.onDutyClinicians[indexPath.row]["username"]!
        //let test = self.onDutyClinicians[0]["rank"]! as String
        //println("clinician is of rank \(test)")
        self.performSegueWithIdentifier("composeSegue", sender: sender)
        //self.presentViewController(alert, animated: true, completion: nil)
        
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("clinician", forIndexPath: indexPath) as UITableViewCell

//        // Configure the cell...
//        println("outside of if onDutyClinicians has count \(self.onDuty.count)")
//        if (self.onDuty.count != 0)
//        {
//            let a = self.onDuty[indexPath.row]["rank"]
//            cell.textLabel.text = a
//            println(a)
//        }
        
        // Configure the cell...
        cell.textLabel.text = self.onDutyClinicians[indexPath.row]["rank"]
        //Unwrap cell.detailTextLabel with ! when know it's not nil b/c of
        //? option on the cell type
        var message = self.onDutyClinicians[indexPath.row]["username"]
        cell.detailTextLabel!.text = message

        return cell
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
        
        if (segue.identifier == "composeSegue")
        {
            // Need name of next view's view controller
            let svc = segue.destinationViewController as ComposeViewController;
            svc.user = self.user
            svc.database = self.database
        }
    }
    
    
  

    
}
