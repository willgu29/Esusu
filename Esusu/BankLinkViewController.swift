//
//  BankLinkViewController.swift
//  Esusu
//
//  Created by William Gu on 5/30/16.
//  Copyright © 2016 Gu Studios. All rights reserved.
//

import UIKit
import plaid_ios_link

class BankLinkViewController: UIViewController, PLDLinkNavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func plaidConnectButton(sender: AnyObject) {
        let plaidLink = PLDLinkNavigationViewController(environment: .Tartan, product: .Connect)
        plaidLink.linkDelegate = self
        plaidLink.providesPresentationContextTransitionStyle = true
        plaidLink.definesPresentationContext = true
        plaidLink.modalPresentationStyle = .Custom
        
        self.presentViewController(plaidLink, animated: true, completion: nil)
    }
    
    
    
    func linkNavigationContoller(navigationController: PLDLinkNavigationViewController!, didFinishWithAccessToken accessToken: String!) {
        print("success \(accessToken)")
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func linkNavigationControllerDidFinishWithBankNotListed(navigationController: PLDLinkNavigationViewController!) {
        print("Manually enter bank info?")
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func linkNavigationControllerDidCancel(navigationController: PLDLinkNavigationViewController!) {
        self.dismissViewControllerAnimated(true, completion: nil)
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
