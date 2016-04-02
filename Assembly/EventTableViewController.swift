//
//  EventTableViewController.swift
//  Assembly
//
//  Created by Dennis Hou on 31/03/2016.
//  Copyright © 2016 RMIT. All rights reserved.
//

import UIKit

class EventTableViewController: UITableViewController {

    
    //MARK: Properties
    var events:[event] = []
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadSampleEvents()
        print(events)
    }

    func loadSampleEvents(){
        var event1:event = event()
        event1.eventName = "Web Development Meetup 2016"
        event1.eventDateTime = NSDate()
        event1.eventDescription = "asdasdasdads"
        event1.eventCategories = ["Technology", "Web"]
        
        var event1Address:address = address()
        event1Address.locationName = "The Royal Melbourne Hotel"
        event1Address.streetNumber = 20
        event1Address.streetName = "Bourke St"
        event1Address.suburb = "Melbourne"
        event1Address.stateName = "VIC"
        event1Address.postcode = 3000
        
        event1.eventAddress = event1Address
        
        events.append(event1)
        
        
        
        var event2:event = event()
        event2.eventName = "Rowing Club 2016"
        event2.eventDateTime = NSDate()
        event2.eventDescription = "asdasdasdads"
        event2.eventCategories = ["Rowing", "Sports"]
        
        var event2Address:address = address()
        event2Address.locationName = "Queensberry Hotel"
        event2Address.streetNumber = 14
        event2Address.streetName = "Swanston St"
        event2Address.suburb = "Carlton"
        event2Address.stateName = "VIC"
        event2Address.postcode = 3053
        
        event2.eventAddress = event2Address
        
        events.append(event2)
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
        print(events.count)
        return events.count
    }


    
    // Load Table Cell contents
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "EventTableViewCell"
    
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! EventTableViewCell
        
        // Fetch event for data source layout
        let event = events[indexPath.row]
        
        // Assign event data from array into cell UI 
        cell.eventNameLabel.text = event.eventName
        cell.eventLocationLabel.text = event.eventAddress?.locationName
        
        print("in tableView(), should print event name")
        print(cell.eventNameLabel?.text)
        return cell
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
