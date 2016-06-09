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

    
    var groups = [];
    var selectedGroup: AnyObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
       
        
    }

    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false;

        
        let user = FIRAuth.auth()?.currentUser;
        
        FirebaseAPI.sharedInstance.rootRef.child("groups").observeSingleEventOfType(.Value, withBlock: { snapshot in
            // do some stuff once
            print(snapshot);
            let ids = snapshot.value as? NSDictionary
            if (ids == nil) {
                return;
            }
            let newArray = NSMutableArray();
            for groupIds in ids! {
                newArray.addObject(groupIds.value);
            }
            self.groups = newArray;
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
        
        
        let currentUser = FIRAuth.auth()?.currentUser;
        let ids =  self.selectedGroup.valueForKey("ids") as! NSArray
        var userInGroup = false;
        
        for id in ids {
            if (currentUser?.uid == (id as! String)) {
                userInGroup = true;
            }
        }
        
        if (userInGroup) {
            self.performSegueWithIdentifier("toGroup", sender: self);
        } else {
            self.performSegueWithIdentifier("toJoinGroup", sender: self);
        }
        
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if (segue.identifier == "toGroup") {
            let groupViewVC = segue.destinationViewController as! GroupViewController
            groupViewVC.name = self.selectedGroup.valueForKey("name") as! String;
            groupViewVC.usersInGroup = self.selectedGroup.valueForKey("members") as! NSArray

        } else if (segue.identifier == "toJoinGroup") {
            
        }
        
    }
    

}
