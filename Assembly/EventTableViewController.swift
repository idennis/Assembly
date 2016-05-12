//
//  EventTableViewController.swift
//  Assembly
//
//  Created by Dennis Hou on 31/03/2016.
//  Copyright © 2016 RMIT. All rights reserved.
//
//  Modified from Apple's official tutorial on Swift
//

import UIKit



class EventTableViewController: UITableViewController {

    
    //MARK: Properties
    var events = Model.sharedInstance.events
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.translucent = false
        changeNavTitle()
        
        // Set table view to full screen width
        tableView.layoutMargins = UIEdgeInsetsZero
        tableView.separatorInset = UIEdgeInsetsZero
    }

    
    func changeNavTitle(){
        let titleLabel = UILabel()
        let colour = UIColor.whiteColor()
        let attributes: [String : AnyObject] = [NSFontAttributeName: UIFont.systemFontOfSize(15, weight: UIFontWeightSemibold)
, NSForegroundColorAttributeName: colour, NSKernAttributeName : 1.2]
        titleLabel.attributedText = NSAttributedString(string: "WHAT'S ON", attributes: attributes)
        titleLabel.sizeToFit()
        self.navigationItem.titleView = titleLabel
    }
    
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    
    
    // MARK: - Table view data source

    // There will be ONE section for now.
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    // Returns all events for now
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }


    
    
    // Load Table Cell contents
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "EventTableViewCell"
    
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! EventTableViewCell
        
        // Extend the cell border from side to side
        cell.layoutMargins = UIEdgeInsetsZero
        // Fetch event for data source layout
        let event = events[indexPath.row]
        
        // Assign event data from array into cell UI 
        cell.eventNameLabel.text = event.eventName
        cell.eventLocationLabel.text = event.eventAddress?.locationName
        
        // Show default cover photo if no image uploaded
        if (event.coverPhoto == nil){
            cell.eventCoverPhoto.image = UIImage(named:"coverPhoto-default")
        }
        else{
            cell.eventCoverPhoto.image = event.coverPhoto
        }
        
        
        return cell
    }


    
    // MARK: - Navigation

    @IBAction func searchButton(sender: UIBarButtonItem) {
        
    }
    
    
    
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "ShowDetail" {
            let eventDetailsViewController = segue.destinationViewController as! EventDetailsViewController
            
            // Get the cell that generated this segue.
            if let selectedEventCell = sender as? EventTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedEventCell)!
                let selectedEvent = events[indexPath.row]
                eventDetailsViewController.selectedEvent = selectedEvent
                
            }
        }

    }
 
    
    
    
    @IBAction func unwindToEventList(sender:UIStoryboardSegue)
    {
        if let sourceViewController = sender.sourceViewController as? PostEventViewController, newEvent = sourceViewController.newEvent {
            
            let newIndexPath = NSIndexPath(forRow: events.count, inSection: 0)
            events.append(newEvent)
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)

        }
    }

}
