//
//  AddMembersTableViewController.swift
//  Esusu
//
//  Created by William Gu on 5/25/16.
//  Copyright © 2016 Gu Studios. All rights reserved.
//

import UIKit


//A subclass of PeopleTableViewController which fetches users from firebase and displays the user string

//TODO: This subclass should automatically select the current user to add them to the group. Don't let the user uncheck it.

class AddMembersTableViewController: PeopleTableViewController {

    var delegate: CreateNewGroupViewController!

    var selectedPeople: NSMutableArray = [];
    var selectedIds: NSMutableArray = [];
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

  
    
    //We save the user object (view in firebase) and their Id for easy referencing.
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let cell = tableView.cellForRowAtIndexPath(indexPath);
        let user = self.users.objectAtIndex(indexPath.row);
        let userId = self.userIds.objectAtIndex(indexPath.row);
        
        if (cell?.accessoryType == UITableViewCellAccessoryType.Checkmark) {
            //Already added
            cell?.accessoryType = UITableViewCellAccessoryType.None;
            selectedPeople.removeObject(user);
            selectedIds.removeObject(userId);
        } else {
            //Not yet added
            cell?.accessoryType = UITableViewCellAccessoryType.Checkmark;
            selectedPeople.addObject(user);
            selectedIds.addObject(userId);
        }
        
    }

    @IBAction func addMembers(sender: UIButton) {
        //Send this information to the delegate (CreateGroupVC)
        self.delegate.setMembersFrom(selectedPeople, ids: selectedIds);
        self.navigationController?.popViewControllerAnimated(true);

        
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
