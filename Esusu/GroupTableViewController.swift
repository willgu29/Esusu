//
//  GroupTableViewController.swift
//  Esusu
//
//  Created by William Gu on 5/1/16.
//  Copyright © 2016 Gu Studios. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class GroupTableViewController: UITableViewController {

    var groupsIds = [];
    var groups = [];
    var selectedGroup: AnyObject!
    var selectedGroupId: String!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
       
        
    }

    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false;

        
        //Get all the groups and add them to our groups array
        FirebaseAPI.sharedInstance.rootRef.child("groups").observeSingleEventOfType(.Value, withBlock: { snapshot in
            // do some stuff once
            print(snapshot);
            let ids = snapshot.value as? NSDictionary
            if (ids == nil) {
                return;
            }
            let newArray = NSMutableArray();
            let newGroupIdsArray = NSMutableArray();

            for groupIds in ids! {
                newArray.addObject(groupIds.value);
                newGroupIdsArray.addObject(groupIds.key);
            }
            self.groups = newArray;
            self.groupsIds = newGroupIdsArray
            self.tableView.reloadData();
        });
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1;
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return groups.count;
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("groupsCell", forIndexPath: indexPath)
        
        
//        // Configure the cell...
        let groupObject = self.groups.objectAtIndex(indexPath.row);
        let groupName = groupObject.valueForKey("name") as! String;
        
        
        cell.textLabel?.text = groupName;

        return cell
    }

    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        print(indexPath);
        
        self.selectedGroup = self.groups.objectAtIndex(indexPath.row);
        self.selectedGroupId = self.groupsIds.objectAtIndex(indexPath.row) as! String;
        
        let currentUser = FIRAuth.auth()?.currentUser;
        let ids =  self.selectedGroup.valueForKey("ids") as! NSArray
        var userInGroup = false;
        
        //Determine if the current user is in this group or not by looping through userIds
        for id in ids {
            if (currentUser?.uid == (id as! String)) {
                userInGroup = true;
            }
        }
        
        //If in group, go to group view, otherwise, display joinGroup options
        if (userInGroup) {
            self.performSegueWithIdentifier("toGroup", sender: self);
        } else {
            self.performSegueWithIdentifier("toJoinGroup", sender: self);
        }
        
    }
    


    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if (segue.identifier == "toGroup") {
            let groupViewVC = segue.destinationViewController as! GroupViewController
            groupViewVC.id = self.selectedGroupId;
            groupViewVC.name = self.selectedGroup.valueForKey("name") as! String
            groupViewVC.usersInGroup = self.selectedGroup.valueForKey("members") as! NSArray
            groupViewVC.amount = self.selectedGroup.valueForKey("amount") as! Int
            groupViewVC.paymentSchedule = self.selectedGroup.valueForKey("paymentSchedule") as! String
            groupViewVC.dateCreated = self.selectedGroup.valueForKey("dateCreated") as! NSTimeInterval

        } else if (segue.identifier == "toJoinGroup") {
            
        }
        
    }
    

}
