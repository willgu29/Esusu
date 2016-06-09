//
//  PeopleTableViewController.swift
//  Esusu
//
//  Created by William Gu on 5/1/16.
//  Copyright © 2016 Gu Studios. All rights reserved.
//

import UIKit

//Displays all the people on Esusu

class PeopleTableViewController: UITableViewController {


    var userIds = [];
    var users = [];
    var selectedUser: AnyObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
      
    }
    
    override func viewWillAppear(animated: Bool) {
        // Retrieve new users as they are added to our database
        FirebaseAPI.sharedInstance.rootRef.child("users").observeSingleEventOfType(.Value, withBlock: { snapshot in
            
            print(snapshot);
            let ids = snapshot.value as? NSDictionary
            if (ids == nil) {
                return;
            }
            let newArray = NSMutableArray();
            let newUserIdsArray = NSMutableArray();
            
            //Get the userIds and user objects
            for userId in ids! {
                newUserIdsArray.addObject(userId.key);
                newArray.addObject(userId.value);
            }
            self.users = newArray;
            self.userIds = newUserIdsArray;
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
        return users.count;
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("peopleCell", forIndexPath: indexPath)

        
        print("People: \(users)");

        let userObject = self.users.objectAtIndex(indexPath.row);
        let fullName = userObject.valueForKey("fullName");
        let phoneNumber = userObject.valueForKey("phoneNumber");
        
        // Configure the cell...
        cell.textLabel?.text = fullName as? String;

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.selectedUser = self.users.objectAtIndex(indexPath.row);
        self.performSegueWithIdentifier("toUserView", sender: self);
        
    }


    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "toUserView") {
            let userViewVC = segue.destinationViewController as! ViewUserTableViewController
            userViewVC.name = self.selectedUser.valueForKey("fullName") as! String
            
        }
        
    }


}
