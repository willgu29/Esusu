//
//  GroupViewController.swift
//  Esusu
//
//  Created by William Gu on 5/4/16.
//  Copyright © 2016 Gu Studios. All rights reserved.
//

import UIKit

class GroupViewController: UIViewController {

    @IBOutlet weak var groupName: UILabel!
    @IBOutlet weak var paymentNumber: UILabel!
    @IBOutlet weak var payeeName: UILabel!
    @IBOutlet weak var payAmount: UILabel!
    
    
    var usersPaid: [User]?
    var usersInGroup: [User]?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
