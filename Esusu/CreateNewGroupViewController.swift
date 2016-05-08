//
//  CreateNewGroupViewController.swift
//  Esusu
//
//  Created by William Gu on 5/5/16.
//  Copyright © 2016 Gu Studios. All rights reserved.
//

import UIKit

class CreateNewGroupViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var groupName: UITextField!
    @IBOutlet weak var paymentSchedule: UITextField!
    @IBOutlet weak var addMembers: UITextField!
    
    var name: String?
    var schedule: String?
    var members: [String]?
    
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
        //TODO: Create that group via Firebase
        
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
        
        
        if (textField == paymentSchedule) {
            let paymentVC = self.storyboard?.instantiateViewControllerWithIdentifier("PaymentScheduleVC") as! PaymentScheduleTableViewController
            paymentVC.delegate = self;
            self.navigationController?.pushViewController(paymentVC, animated: true);
            return false;
        }
        
        return true;
    }
    
    
    let scheduleOptions: [String] = ["Weekly", "Bi-weekly", "Monthly"];
    internal func setScheduleFrom(rowNumber: Int) {
        if (rowNumber == -1) {
            //Schedule not set
        } else {
            paymentSchedule.text = scheduleOptions[rowNumber];
        }
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
