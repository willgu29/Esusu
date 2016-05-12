//
//  CodeViewController.swift
//  Esusu
//
//  Created by William Gu on 5/1/16.
//  Copyright © 2016 Gu Studios. All rights reserved.
//

import UIKit

class CodeViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.textField.keyboardType = UIKeyboardType.NumberPad;
        self.textField.becomeFirstResponder();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func verifyCode(sender: UIButton) {
        SinchVerifyPhoneNumber.sharedInstance.enterCodeDelegate = self;
        SinchVerifyPhoneNumber.sharedInstance.verifyCodeProvided(textField.text!)
    }
    
    
    //TODO: for later
    @IBAction func resendCode(sender: UIButton) {
        
    }
    
    //MARK: After verification success (for delegate)
    
    func verificationSuccess() {
        self.navigationController?.popToRootViewControllerAnimated(true);
        self.createAccountSuccessAlert();
    }
    
    func verificationFailure() {
        //TODO: Display error
    }
    
    func createAccountSuccessAlert() {
        let alertViewVC = UIAlertController(title: "Success", message: "Your account has been created, just login with your number.", preferredStyle: UIAlertControllerStyle.Alert)
        let okayAction = UIAlertAction(title: "Okay", style: .Default) { (action) in
            //...
        }
        alertViewVC.addAction(okayAction)
        self.navigationController!.presentViewController(alertViewVC, animated: true, completion:nil)
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
