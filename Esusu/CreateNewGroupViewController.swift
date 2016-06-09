//
//  CreateNewGroupViewController.swift
//  Esusu
//
//  Created by William Gu on 5/5/16.
//  Copyright © 2016 Gu Studios. All rights reserved.
//

import UIKit

class CreateNewGroupViewController: UIViewController, UITextFieldDelegate {

    
    //TODO: Some way to set the amount charged per schedule
    //TODO: Some way to set up a cron job for notifications on the appropriate dates that the user needs to pay the group
    
    
    @IBOutlet weak var groupName: UITextField!
    @IBOutlet weak var paymentSchedule: UITextField!
    @IBOutlet weak var addMembers: UITextField!

    var members: NSMutableArray = [] //of UIDs prob
    var userIds: NSMutableArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        groupName.keyboardType = UIKeyboardType.Default;
        addMembers.keyboardType = UIKeyboardType.Default;
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func createGroup(sender: UIButton) {
        
        //TODO: Add error handling, make sure all fields are filled.
        
        //Create that group via Firebase, saving the member objects and userIds involved
        FirebaseAPI.sharedInstance.createGroup(groupName.text!, paymentSchedule: paymentSchedule.text!, members: self.members, ids: self.userIds);
        
        
        self.navigationController?.popViewControllerAnimated(true);
        
        
        let alertViewVC = UIAlertController(title: "Success", message: "Your group has been created! Just head over to the groups tab to see it!", preferredStyle: UIAlertControllerStyle.Alert)
        let okayAction = UIAlertAction(title: "Okay", style: .Default) { (action) in
            //...
        }
        alertViewVC.addAction(okayAction)
        self.tabBarController!.presentViewController(alertViewVC, animated: true, completion:nil)
        
        
    }
    
    //MARK: Delegates
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        
        //segue to separate tableview to choose payment schedule
        if (textField == paymentSchedule) {
            let paymentVC = self.storyboard?.instantiateViewControllerWithIdentifier("PaymentScheduleVC") as! PaymentScheduleTableViewController
            paymentVC.delegate = self;
            self.navigationController?.pushViewController(paymentVC, animated: true);
            return false;
        //segue to separate tableview to choose members in group
        } else if (textField == addMembers) {
            //TODO: currently doesn't automatically add the current user to group automatically
            //TOOD: Think they wanted an invite system, so would need to add that to the database as well
            let addMembersVC = self.storyboard?.instantiateViewControllerWithIdentifier("AddMembersVC") as! AddMembersTableViewController
            addMembersVC.delegate = self;
            self.navigationController?.pushViewController(addMembersVC, animated: true);
            return false;
        }
        
        return true;
    }
    
    //MARK: Delegate methods
    
    let scheduleOptions: [String] = ["Weekly", "Bi-weekly", "Monthly"];
    internal func setScheduleFrom(rowNumber: Int) {
        if (rowNumber == -1) {
            //Schedule not set
        } else {
            paymentSchedule.text = scheduleOptions[rowNumber];
        }
    }
    
    internal func setMembersFrom(members: NSMutableArray, ids: NSMutableArray) {
        self.members = members;
        self.userIds = ids;
        addMembers.text = constructMemberString();
    }
    
    
    //MARK: Helper method 
    
    //Formats string for who is in group textfield
    func constructMemberString() -> String {
        var memberNamesArray: [String] = [];
        
        for memberObject in self.members {
            let name = memberObject.valueForKey("fullName") as! String;
            memberNamesArray.append(name);
        }
        let string = memberNamesArray.joinWithSeparator(", ");
        return string;
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true);
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
