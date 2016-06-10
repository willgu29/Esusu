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

//This class displays for the members that are in the group
//Will need to show members in group, give them a way to chat, and a way to know when the next payment dates are and who is getting paid

class GroupViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, StripeAPIDelegate {

    @IBOutlet weak var groupName: UILabel!
    @IBOutlet weak var payAmount: UILabel!
    @IBOutlet weak var schedule: UILabel!
    
    var name: String!
    var amount: Int!
    var usersInGroup: NSArray!
    var paymentSchedule: String!
    var id: String!
    var dateCreated: NSTimeInterval! //since 1970
    
    
    let scheduleOptions: [String] = ["Every Monday (weekly)", "On the 1st (monthly)", "On the 1st and 15th (bi-weekly)"];
    
    
    var paymentDates:NSMutableArray = []
    
    func setup() {
        self.groupName.text = self.name;
        
        let amountString = String(self.amount);
        self.payAmount.text = "Amount: $\(amountString)";
        
        self.schedule.text = paymentSchedule
        
        
        if (paymentSchedule == scheduleOptions[0]) {
            setPayOnMonday();
        } else if (paymentSchedule == scheduleOptions[1]) {
            setPayOnFirst();
        } else if (paymentSchedule == scheduleOptions[2]) {
            setPayOnFirstAndFifteen()
        }
       
        
        
    }
    
    func setPayOnMonday() {
        var date: NSDate = NSDate(timeIntervalSince1970: dateCreated);
        var i = 0;
        while (i < usersInGroup.count) {
            i += 1
            let mondayDate = findNextMonday(date);
            paymentDates.addObject(mondayDate);
            
            //We add a time interval because the findNextMonday only finds current monday OR next monday. Add a day to make sure it finds next monday
            date = mondayDate.dateByAddingTimeInterval(60*60*24);
        }
    }
    
    func setPayOnFirst() {
        var date: NSDate = NSDate(timeIntervalSince1970: dateCreated);
        var i = 0;
        while (i < usersInGroup.count) {
            i += 1;
            let firstDate = findNextFirst(date);
            paymentDates.addObject(firstDate);
            date = firstDate;
        }
    }
    
    func setPayOnFirstAndFifteen() {
        var date: NSDate = NSDate(timeIntervalSince1970: dateCreated);
        var getFifteenFirst: Bool
        let currentCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian);
        let unitFlags: NSCalendarUnit = [.Year, .Month, .WeekOfYear, .Weekday];
        let components = currentCalendar?.components(unitFlags, fromDate: date);
        if (components!.day >= 15) {
            //1 .. 15 .. 1 .. 15
            getFifteenFirst = false;
        } else {
            //15 .. 1 .. 15 .. 1
            getFifteenFirst = true;
        }
        
        var i = 0;
        var dateFound: NSDate!
        while (i < usersInGroup.count) {
            i += 1;
            if (getFifteenFirst == true) {
                dateFound = findNextFifteenth(date);
                getFifteenFirst = false;
            } else {
                dateFound = findNextFirst(date);
                getFifteenFirst = true;
            }
            paymentDates.addObject(dateFound);
            date = dateFound;
            
        }
    }
    
    //Fetches CURRENT monday or next one if not on current
    func findNextMonday(date: NSDate) -> NSDate {
        let currentCalendar =  NSCalendar(calendarIdentifier:NSCalendarIdentifierGregorian);
        
        let unitFlags: NSCalendarUnit = [.Year, .Month, .WeekOfYear, .Weekday];
        
        let components = currentCalendar?.components(unitFlags, fromDate: date);
        
        let weekdayToday = components?.weekday;
        let daysToMonday = (9 - weekdayToday!) % 7;
        let nextMonday: NSDate = date.dateByAddingTimeInterval(60*60*24*Double(daysToMonday));
        return nextMonday;
    }
    
    func findNextFirst(date:NSDate) -> NSDate {
        
        let comp = NSDateComponents();
        comp.month = 1;
        let newMonth = NSCalendar.currentCalendar().dateByAddingComponents(comp, toDate: date, options: NSCalendarOptions.MatchFirst);
        
        let currentCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian);
        let unitFlags: NSCalendarUnit = [.Year, .Month, .WeekOfYear, .Weekday];
        
        let components = currentCalendar?.components(unitFlags, fromDate: newMonth!);
        components!.day = 1;
        let currentMonthDayOne = currentCalendar?.dateFromComponents(components!);
        return currentMonthDayOne!;
    }
    
    func findNextFifteenth(date:NSDate) -> NSDate {
        let currentCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian);
        let unitFlags: NSCalendarUnit = [.Year, .Month, .WeekOfYear, .Weekday];
        
        let components = currentCalendar?.components(unitFlags, fromDate: date);
        components!.day = 15;
        let currentMonthDayFifteen = currentCalendar?.dateFromComponents(components!);
        return currentMonthDayFifteen!;
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
        return 1;
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Payment Order";
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
        let dateToBePaid = paymentDates[indexPath.row] as! NSDate
        
        let dateFormatter = NSDateFormatter();
        dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle;
        let stringDate = dateFormatter.stringFromDate(dateToBePaid);
        
        cell.textLabel?.text = username;
        cell.detailTextLabel?.text = stringDate;
        
        return cell
    }
    

    @IBAction func payGroup(sender:UIButton) {
        
        let localCustomerId = NSUserDefaults.standardUserDefaults().stringForKey("customerId");

        if (localCustomerId == nil) {
            errorAlert()
            return;
        }
        
        StripeAPI.sharedInstance.delegate = self;
        StripeAPI.sharedInstance.chargeCustomer(self.amount);
    }
    
    func errorAlert() {
        let alertViewVC = UIAlertController(title: "Error", message: "Please add a valid card to your account in the settings tab, then try again!", preferredStyle: UIAlertControllerStyle.Alert)
        let okayAction = UIAlertAction(title: "Okay", style: .Default) { (action) in
            //...
        }
        alertViewVC.addAction(okayAction)
        self.tabBarController!.presentViewController(alertViewVC, animated: true, completion:nil)
    }
    
    //MARK: Delegate methods (StripeAPIDelegate)
    func chargeSuccess() {
        let alertViewVC = UIAlertController(title: "Success", message: "Your payment has been processed!", preferredStyle: UIAlertControllerStyle.Alert)
        let okayAction = UIAlertAction(title: "Great", style: .Default) { (action) in
            //...
        }
        alertViewVC.addAction(okayAction)
        self.tabBarController!.presentViewController(alertViewVC, animated: true, completion:nil)
    }
    
    func chargeFailure() {
        let alertViewVC = UIAlertController(title: "Error", message: "Your payment was not processed, make sure you have a valid card or bank account and internet connection.", preferredStyle: UIAlertControllerStyle.Alert)
        let okayAction = UIAlertAction(title: "Okay", style: .Default) { (action) in
            //...
        }
        alertViewVC.addAction(okayAction)
        self.tabBarController!.presentViewController(alertViewVC, animated: true, completion:nil)
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
