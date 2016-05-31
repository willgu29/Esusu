//
//  GroupViewController.swift
//  Esusu
//
//  Created by William Gu on 5/4/16.
//  Copyright © 2016 Gu Studios. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class GroupViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var groupName: UILabel!
    @IBOutlet weak var payAmount: UILabel!
//    @IBOutlet weak var paymentSchedule: UITableView!
    
    var name: String!
    var usersPaid: [AnyObject]?
    var usersInGroup: NSArray!
    
    
    func setup() {
        self.groupName.text = self.name;
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        setup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return usersInGroup.count;
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("usersInGroup", forIndexPath: indexPath)
        
        
        // Configure the cell...
        let userObject = self.usersInGroup.objectAtIndex(indexPath.row);
        let username = userObject.valueForKey("fullName") as! String;
        let dateToBePaid = "TODO";
        
        cell.textLabel?.text = username;
        cell.detailTextLabel?.text = dateToBePaid;
        
        return cell
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
