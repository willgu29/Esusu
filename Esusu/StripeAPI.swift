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

class StripeAPI: NSObject {

    static let sharedInstance = StripeAPI();
    
    let ROOT_URL = "https://esusu.herokuapp.com"

    
    
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
                        NSUserDefaults.standardUserDefaults().setObject(customerId, forKey: "customerId");
                    } else {
                        //customer not created
                    }
                }
        }
    }
    
    func chargeToken(token:STPCardParams) {
        
    }
    
    func chargeCustomer() {
        let localCustomerId = NSUserDefaults.standardUserDefaults().stringForKey("customerId");
        
        Alamofire.request(.POST, "https://esusu.herokuapp.com/chargeCustomer",
            parameters: [
                "customerId" : localCustomerId!,
                "description": "Esusu charge"])
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
                    } else {
                        //charge failed
                    }
                }
        }
        
    }
    
}
