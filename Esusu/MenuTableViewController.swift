//
//  MenuTableViewController.swift
//  Esusu
//
//  Created by William Gu on 5/1/16.
//  Copyright © 2016 Gu Studios. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
        return 9;
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (indexPath.row == 0) {
            //Complete Setup
        } else if (indexPath.row == 1) {
            //Add bank
        } else if (indexPath.row == 2) {
            //Add card
        } else if (indexPath.row == 3) {
            //Edit Account
        } else if (indexPath.row == 4) {
            //TODO: Coming soon
            //Contact Help
            segueToComingSoonViewController()
        } else if (indexPath.row == 5) {
            //TODO: Coming soon
            //Account Statements
            segueToComingSoonViewController()
        } else if (indexPath.row == 6) {
            //TODO: Coming soon
            //Transfer to Esusu
            segueToComingSoonViewController()
        } else if (indexPath.row == 7) {
            //TODO: Coming soon
            //Transfer to Bank
            segueToComingSoonViewController()
        } else if (indexPath.row == 8) {
            //Logout
            FirebaseAPI.sharedInstance.logout();
            self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil);
        }
    }
    
    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func segueToComingSoonViewController() {
        let viewController = self.storyboard?.instantiateViewControllerWithIdentifier("comingSoon");
        self.navigationController?.pushViewController(viewController!, animated: true);
    }

}
