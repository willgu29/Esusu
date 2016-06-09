//
//  LoginViewController.swift
//  Esusu
//
//  Created by William Gu on 5/11/16.
//  Copyright © 2016 Gu Studios. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FBSDKLoginKit

class LoginViewController: UIViewController, FirebaseAPIDelegate, FBSDKLoginButtonDelegate {

    
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var password: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        //FB Login, disabled for now: need to save created account to Firebase /users endpoint (name, phone number, etc.)
//        let loginButton = FBSDKLoginButton();
//        loginButton.delegate = self;
//        loginButton.center = self.view.center;
//        self.view.addSubview(loginButton);
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError?) {
        if let error = error {
            print(error.localizedDescription)
            return
        }
        // ...
        let credential = FIRFacebookAuthProvider.credentialWithAccessToken(FBSDKAccessToken.currentAccessToken().tokenString)
        FIRAuth.auth()?.signInWithCredential(credential) { (user, error) in
            // ...
        }

    }
    func loginButtonDidLogOut(loginButton:FBSDKLoginButton){
    
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true;
    }
    
    
    override func viewDidAppear(animated: Bool) {
        if let user = FIRAuth.auth()?.currentUser {
            // User is signed in.
            print(user);
            self.performSegueWithIdentifier("toMainApp", sender: self);

        } else {
            // No user is signed in.
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func login(sender:UIButton) {
        FirebaseAPI.sharedInstance.delegate = self;
        FirebaseAPI.sharedInstance.login(phoneNumber.text!, password: password.text!);
        //Will go to delegate methods
    }
    
    @IBAction func findOutMore(sender: UIButton) {
        UIApplication.sharedApplication().openURL(NSURL(string: "https://voice.adobe.com/a/5n0EP/")!)

    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true);
    }
    
    // MARK: Delegate
    
    func loginSuccess(authData: AnyObject) {
        self.performSegueWithIdentifier("toMainApp", sender: self);
        
        self.phoneNumber.text = "";
        self.password.text = "";
    }
    
    func loginError(error: NSError) {
        print(error);
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
