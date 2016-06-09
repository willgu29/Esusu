//
//  SinchVerifyPhoneNumber.swift
//  Esusu
//
//  Created by William Gu on 5/11/16.
//  Copyright © 2016 Gu Studios. All rights reserved.
//

import UIKit
import SinchVerification

func PhoneNumberUtil() -> PhoneNumberUtil {
    return SharedPhoneNumberUtil();
}


class SinchVerifyPhoneNumber: NSObject {

    static let sharedInstance = SinchVerifyPhoneNumber();
    var verification: Verification!
    var createAccountDelegate: CreateAccountViewController?
    var enterCodeDelegate: CodeViewController?
    
    
    func verifyPhoneNumber(text: String) {
        
        do {
            let phoneNumber = try PhoneNumberUtil().parse(text, defaultRegion:DeviceRegion.currentCountryCode());
                
            let phoneNumberE164 = PhoneNumberUtil().format(phoneNumber, format: PhoneNumberFormat.E164);
            
            self.verification = SMSVerification(applicationKey:"902fb1ed-6cd0-4a59-879c-04477e78af63", phoneNumber: phoneNumberE164);
            
            self.verification.initiate({ (success: Bool, error: NSError?) -> Void in
                if(success){
                    //Verification Successful!
                    print("Success");
                    self.createAccountDelegate?.verifyPhoneNumberSuccess();
                    
                } else {
                    print("Failure");
                    //Verification Failed
                    self.createAccountDelegate?.verifyPhoneNumberFailure();
                }
            });
                
        } catch let error as PhoneNumberParseError {
            print("Invalid phone number: " + String(error));
        } catch {
            print(error);
        }
        
    }
    
    func verifyCodeProvided(code: String) {
        self.verification.verify(code, completion: { (success: Bool, error: NSError?) in
            if (success) {
                //Nice!
                print("Success");
                let updatePhoneVerification = ["verified" : true];
                FirebaseAPI.sharedInstance.updateUser(FirebaseAPI.sharedInstance.currentSessionUID!, user: updatePhoneVerification);
                self.enterCodeDelegate?.verificationSuccess();
            } else {
                print("Failure");
                //TODO: Retry verification, send them a new code
                
            }
        });
    }
    
    
}
