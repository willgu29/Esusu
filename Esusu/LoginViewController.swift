//
//  LoginViewController.swift
//  Esusu
//
//  Created by William Gu on 5/11/16.
//  Copyright © 2016 Gu Studios. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, FirebaseAPIDelegate {

    
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func login(sender:UIButton) {
        FirebaseAPI.sharedInstance.login(phoneNumber.text!, password: password.text!);
        //Will go to delegate methods
    }
    
    // MARK: Delegate
    
    func loginSuccess(authData: AnyObject) {
        self.performSegueWithIdentifier("toMainApp", sender: self);
    }
    
    func loginError(error: NSError) {
        
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if (segue.identifier == "toMainApp") {
            //Verify login
        } else {
            //Create account screen
        }
        
    }
  
    

}
