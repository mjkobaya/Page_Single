//
//  ComposeViewController.swift
//  Page_Single
//
//  Created by Kay Lab on 11/14/14.
//  Copyright (c) 2014 Team 3. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController ,UIPickerViewDataSource,UIPickerViewDelegate {
    
    var user: User!
    var database: Database!

  
    @IBOutlet weak var loadingBar: UIProgressView!
    @IBOutlet weak var quickReplies: UILabel!
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var MRNtext: UITextField!
    @IBOutlet weak var newPage: UITextField!
    @IBOutlet weak var picker2: UIPickerView!
    let pickerData = [["","Consult", "Quick Question", "FYI"],["", "Meet me at the office", "Call me ASAP","This is so much better than a pager!!","There is a patient seeking your medical attention","Developers > Doctors"]
        ]
    override func viewDidLoad() {
        super.viewDidLoad()
        picker2.delegate = self
        picker2.dataSource = self
        // Do any additional setup after loading the view.
        
        println("In ComposeViewController \(user.username)")
    }
    
    
    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return pickerData.count
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData[component].count
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return pickerData[component][row]
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
         updateLabel()
    }
    //MARK -Instance Methods
    func updateLabel(){
        let size = pickerData[0][picker2.selectedRowInComponent(0)]
        let topping = pickerData[1][picker2.selectedRowInComponent(1)]
        myLabel.text = size + " " + topping
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //@IBAction func sendPage(sender: AnyObject) {
    //    println(myLabel.text + " " + newPage)
    //}

    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "sendInboxSegue")
        {
            // Need name of next view's view controller
            let svc = segue.destinationViewController as InboxTableViewController;
            svc.user = self.user
            svc.database = self.database
        }
        
    }


}
