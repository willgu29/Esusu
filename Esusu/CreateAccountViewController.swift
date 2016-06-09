//
//  CreateAccountViewController.swift
//  Esusu
//
//  Created by William Gu on 5/10/16.
//  Copyright © 2016 Gu Studios. All rights reserved.
//

import UIKit

class CreateAccountViewController: UIViewController, UITextFieldDelegate{

    
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var fullName: UITextField!
    @IBOutlet weak var password: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false;

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func createAccount(sender: UIButton) {
        FirebaseAPI.sharedInstance.createUser(phoneNumber.text!, password: password.text!, fullName: fullName.text!);
        SinchVerifyPhoneNumber.sharedInstance.createAccountDelegate  = self;
        SinchVerifyPhoneNumber.sharedInstance.verifyPhoneNumber(phoneNumber.text!);
        
    }
    
    // MARK: (for delegate)
    
    func verifyPhoneNumberSuccess() {
        self.performSegueWithIdentifier("toEnterCode", sender: self);
    }

    func verifyPhoneNumberFailure() {
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true);
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if (segue.identifier == "toEnterCode") {

        }
    }
    

}
