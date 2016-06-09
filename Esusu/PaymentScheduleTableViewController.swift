//
//  PaymentScheduleTableViewController.swift
//  Esusu
//
//  Created by William Gu on 5/5/16.
//  Copyright © 2016 Gu Studios. All rights reserved.
//

import UIKit

//Simply returns the row NUMBER back to delegate.

class PaymentScheduleTableViewController: UITableViewController {

    //Update this number if you update the number of rows in storyboard.
    let NUMBER_OF_ROWS_IN_TABLEVIEW = 3;
    
    var delegate: CreateNewGroupViewController!
    
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
        return NUMBER_OF_ROWS_IN_TABLEVIEW;
    }
    
    var selectedRow = -1;
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell?.accessoryType = UITableViewCellAccessoryType.Checkmark;
        
        self.selectedRow = indexPath.row;
        delegate.setScheduleFrom(self.selectedRow);
        
        self.navigationController?.popViewControllerAnimated(true);
    }
   

}
