//
//  StripeAPI.swift
//  Esusu
//
//  Created by William Gu on 5/30/16.
//  Copyright © 2016 Gu Studios. All rights reserved.
//

import UIKit
import Stripe
import Alamofire

//The backend is hosted on heroku (for Stripe and Plaid)
//Data is being stored via Firebase.

protocol StripeAPIDelegate {
    func chargeSuccess();
    func chargeFailure();
}

class StripeAPI: NSObject {

    static let sharedInstance = StripeAPI();
    var delegate: StripeAPIDelegate?
    
    let ROOT_URL = "https://esusu.herokuapp.com"

    
    //Creates a customer from a stripe token, an email is needed for receipts to be sent
    func createCustomer(stripeToken: STPToken, email: String) {
        
        Alamofire.request(.POST, "https://esusu.herokuapp.com/createCustomer",
            parameters: [
                "stripeToken": stripeToken,
                "email" : email,
                "description": description])
            .responseJSON { response in
                print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.data)     // server data
                print(response.result)   // result of response serialization
                
                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                    let status = JSON.valueForKey("status") as! Int
                    if (status == 1) {
                        //customer created
                        let customer = JSON.valueForKey("customer");
                        let customerId = customer?.valueForKey("id");
                        
                        //we save the customerId on the local device for now as an easy way to charge this customer in the future
                        NSUserDefaults.standardUserDefaults().setObject(customerId, forKey: "customerId");
                    } else {
                        //customer not created
                    }
                }
        }
    }
    
    func chargeToken(token:STPCardParams) {
        
    }
    
    func chargeCustomer(amount: Int) {
        
        //we need this ID to charge the customer
        let localCustomerId = NSUserDefaults.standardUserDefaults().stringForKey("customerId");
        
        let amountCents = amount*100;
        
        Alamofire.request(.POST, "https://esusu.herokuapp.com/chargeCustomer",
            parameters: [
                "customerId" : localCustomerId!,
                "description": "Esusu charge",
                "amount": amountCents])
            .responseJSON { response in
                print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.data)     // server data
                print(response.result)   // result of response serialization
                
                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                    let status = JSON.valueForKey("status") as! Int
                    if (status == 1) {
                        //charge success
                        self.delegate?.chargeSuccess();
                    } else {
                        //charge failed
                        self.delegate?.chargeFailure()
                    }
                }
        }
        
    }
    
}
