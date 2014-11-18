//
//  ComposeViewController.swift
//  Page_Single
//
//  Created by Kay Lab on 11/14/14.
//  Copyright (c) 2014 Team 3. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController ,UIPickerViewDataSource,UIPickerViewDelegate, UITextFieldDelegate {
    
    var user: User!
    var database: Database!
    var sender: String!
    var message: String!


  
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var quickReplies: UILabel!
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var MRNtext: UITextField!
    @IBOutlet weak var picker2: UIPickerView!
    @IBOutlet weak var activeTextField: UITextField!

    
    let pickerData = [["","Consult", "Quick Question", "FYI", "Nursing", "Pharmacy"],["", "Call back ASAP", "Working on patient ","Need to staff with attending","In a meeting","My recs are", "Text you recs ASAP", "Stop by After rounds", "Thank you for the consult"]
        ]
    override func viewDidLoad() {
        super.viewDidLoad()
        picker2.delegate = self
        picker2.dataSource = self
        
        MRNtext.delegate = self
        activeTextField.delegate = self
        // Do any additional setup after loading the view.
        
        println("In ComposeViewController user name is\(user.username)")
        println("In ComposeViewController Sender passed is \(sender)")

        
        registerForKeyboardNotifications()
    }
  
    
    
    //MARK: - Keyboard Management Methods
    
    // Call this method somewhere in your view controller setup code.
    func registerForKeyboardNotifications() {
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(self,
            selector: "keyboardWillBeShown:",
            name: UIKeyboardWillShowNotification,
            object: nil)
        notificationCenter.addObserver(self,
            selector: "keyboardWillBeHidden:",
            name: UIKeyboardWillHideNotification,
            object: nil)
    }
    
    // Called when the UIKeyboardDidShowNotification is sent.
    func keyboardWillBeShown(sender: NSNotification) {
        let info: NSDictionary = sender.userInfo!
        let value: NSValue = info.valueForKey(UIKeyboardFrameBeginUserInfoKey) as NSValue
        let keyboardSize: CGSize = value.CGRectValue().size
        let contentInsets: UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize.height, 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
        
        // If active text field is hidden by keyboard, scroll it so it's visible
        // Your app might not need or want this behavior.
        var aRect: CGRect = self.view.frame
        aRect.size.height -= keyboardSize.height
        let activeTextFieldRect: CGRect? = activeTextField?.frame
        let activeTextFieldOrigin: CGPoint? = activeTextFieldRect?.origin
        if (!CGRectContainsPoint(aRect, activeTextFieldOrigin!)) {
            scrollView.scrollRectToVisible(activeTextFieldRect!, animated:true)
        }
    }
    
    // Called when the UIKeyboardWillHideNotification is sent
    func keyboardWillBeHidden(sender: NSNotification) {
        let contentInsets: UIEdgeInsets = UIEdgeInsetsZero
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    //MARK: - UITextField Delegate Methods
    
//    func textFieldDidBeginEditing(textField: UITextField!) {
//        activeTextField = textField
//        scrollView.scrollEnabled = true
//    }
//    
//    func textFieldDidEndEditing(textField: UITextField!) {
//        activeTextField = nil
//        scrollView.scrollEnabled = false
//    }
    
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
        myLabel.text = size + ": " + topping
    }
    
    // Configure the return key to go to next text field or hide keyboard
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        if (textField == MRNtext)
        {
            textField.resignFirstResponder()
        }
            
        else if (textField == activeTextField)
        {
            textField.resignFirstResponder()
        }
        
        return true
    }

    
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 
    
    // MARK: - Navigation
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool
    {
        if (identifier == "unwindToInbox")
        {
            message = myLabel.text! + " " + activeTextField.text
            println("In ComposeViewController message to be sent is \(self.message)")
            self.database.sendMessage(sender: user.username, receiver: self.sender, message: self.message, postCompleted: { (succeeded) -> () in
                println("succeeded is \(succeeded)")
                })
            return true
        }
        
        return false
    }
    
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
