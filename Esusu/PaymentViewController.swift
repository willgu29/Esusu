//
//  PaymentViewController.swift
//  Esusu
//
//  Created by William Gu on 5/30/16.
//  Copyright © 2016 Gu Studios. All rights reserved.
//

import UIKit
import Stripe

class PaymentViewController: UIViewController, STPPaymentCardTextFieldDelegate, UITextFieldDelegate {

    let paymentTextField = STPPaymentCardTextField()
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var emailField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        paymentTextField.frame = CGRectMake(15, 80, CGRectGetWidth(self.view.frame) - 30, 44)
        paymentTextField.delegate = self
        view.addSubview(paymentTextField)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true);
    }
    
    func paymentCardTextFieldDidChange(textField: STPPaymentCardTextField) {
        // Toggle navigation, for example
        
        
        saveButton.enabled = textField.valid
    }
    
    
    @IBAction func save(sender: UIButton) {
        let card = paymentTextField.cardParams;
        STPAPIClient.sharedClient().createTokenWithCard(card) { (token, error) -> Void in
            if let error = error  {
                self.handleError(error)
            }
            else if let token = token {
            
                StripeAPI.sharedInstance.createCustomer(token, email: self.emailField.text!);
            }
        }
    }
    
    func handleError(error: NSError) {
        print(error);
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
