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
import Alamofire
import SwiftyJSON

class EventTableViewController: UITableViewController {

    
    //MARK: Properties
    let APIKEY:String = "4826197d35111d936346b52d2476b"
    
    
    //var events = Model.sharedInstance.events
    
    // Array of dictionary to store culled data from Meetup via API
    var eventsDictionaryArray:[[String:AnyObject]] = []
    var groupPhotoDictionaryArray:[[String:AnyObject]] = []
    
    var imageURL:String?

    
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Style overrides
            self.navigationController?.navigationBar.translucent = false
        
            // Set table view to full screen width
            tableView.layoutMargins = UIEdgeInsetsZero
            tableView.separatorInset = UIEdgeInsetsZero
        
        

        getNewEvents()
        
        
    }


    
    
    // MARK: - Table view data source
    func getNewEvents(){
        // Data load-ins from Meetup.com
        Alamofire.request(.GET, "https://api.meetup.com/2/open_events?key="+APIKEY+"&sign=true&photo-host=secure&host=public&country=AU&city=melbourne&state=VC&time=,5w&desc=true&group_photo&page=20").progress({ (bytesRead, totalBytesRead, totalBytesExpectedToRead) in
            
            print(totalBytesRead)
            self.activityIndicator.startAnimating()
            
        }).responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                print("Success")
                
                // Stop and hides activity indicator if data is found and loaded
                self.activityIndicator.stopAnimating()
                self.loadingView.hidden = true
                self.loadingView.removeFromSuperview()
                
                
                let swiftyJsonVar = JSON(responseData.result.value!)
                print(swiftyJsonVar)
                
                if let data = swiftyJsonVar["results"].arrayObject{
                    self.eventsDictionaryArray = data as! [[String:AnyObject]]
                    print(self.eventsDictionaryArray)
                }
                if self.eventsDictionaryArray.count > 0{
                    self.tableView.reloadData()
                }
            }
                
            else if ((responseData.result.value) == nil){
                let alert = UIAlertController(title: "Uh oh", message: "We couldn't connect to the server, try switching on Wi-Fi or cellular data and restart the app.", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }

    }
    
    
    // MARK: Group Photo
    func getGroupImageURL(groupID:Int64){
        let stringID = String(groupID)
        //var imageURL:String? = ""
        
        Alamofire.request(.GET, "https://api.meetup.com/2/groups?&sign=true&photo-host=public&group_id="+stringID+"&page=20&key="+APIKEY).responseJSON { (response) in
            
            if let JsonVar = response.result.value {
                if let groupData = JsonVar["results"]{
                    if (groupData != nil){
                        self.groupPhotoDictionaryArray = groupData as! [[String:AnyObject]]
//                          print ("in getGroupImageURL")
                        self.imageURL = self.groupPhotoDictionaryArray[0]["group_photo"]?["photo_link"] as? String
//                          print("IN IF STATEMENT")
//                          print(self.imageURL)
                    }
                    
                }
            }

        }
//        print("OUTSIDE IF")
//        print(self.imageURL)
    }
    
    
    
    // There will be ONE section for now.
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    // Returns all events for now
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventsDictionaryArray.count
    }


    // Assign Cell Data
    func loadContentForCell(cell:EventTableViewCell, indexPath: NSIndexPath){
        var dict = eventsDictionaryArray[indexPath.row]
        
        let groupID = (dict["group"]!["id"] as! NSNumber).longLongValue
        
        
        cell.eventNameLabel?.text = dict["name"] as? String
        
        if (dict["venue"]?["name"] as? String == nil){
            cell.eventLocationLabel?.text = "Location visible to group members only."
        }
        else{
            cell.eventLocationLabel?.text = dict["venue"]?["name"] as? String
        }

        loadAndFormatDate((dict["time"] as? Int)!, cell: cell)
        
        
        
        // Decode URL to Image
        getGroupImageURL(groupID)
        let fullPath = String(self.imageURL)
        //print("FULL PATH: "+fullPath)
        
        let url = NSURL(string:fullPath)
        //print ("URL: ",url)
        
        if url != nil{
//            print("URL is NOT NULL")
            let data = NSData(contentsOfURL: url!)
            
            if data != nil {
//                print("DATA IS NOT NULL")
                cell.eventCoverPhoto.image = UIImage(data:data!)
            }
        }
        
        
    }
    
    

    // Load Table Cell contents
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "EventTableViewCell"
    
        
        if let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as? EventTableViewCell{
                loadContentForCell(cell, indexPath: indexPath)
                cell.layoutMargins = UIEdgeInsetsZero
                return cell
        }
        
        
//        if indexPath.row == eventsDictionaryArray.count - 1 {
//            
//            if let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as? EventTableViewCell{
//                
//                loadContentForCell(cell, indexPath: indexPath)
//                cell.layoutMargins = UIEdgeInsetsZero
//                return cell
//            }
//        }
        
        
        
//        // Assign event data from array into cell UI
//        cell.eventNameLabel.text = event.eventName
//        cell.eventLocationLabel.text = event.eventAddress?.locationName
//        
//        // Show default cover photo if no image uploaded
//        if (event.coverPhoto == nil){
//            cell.eventCoverPhoto.image = UIImage(named:"coverPhoto-default")
//        }
//        else{
//            cell.eventCoverPhoto.image = event.coverPhoto
//        }
//        

        return EventTableViewCell()
    }

    
    
    // MARK: Date Formatting
    func loadAndFormatDate(time:Int,cell:EventTableViewCell){
        // Conversion from Epoch time to Gregorian calendar time
        let intTimeValue:Int = time
        let ti = NSTimeInterval(intTimeValue)
        
        // Divided by milliseconds as given from Meetup's Database
        let date = NSDate(timeIntervalSince1970: ti/1000.0)
        
        // Human readable date, nicely formatted :)
        let dateStringFormatter = NSDateFormatter()
        dateStringFormatter.dateFormat = "MMMM dd"
        let dateString = dateStringFormatter.stringFromDate(date)
        
        let dayStringFormatter = NSDateFormatter()
        dayStringFormatter.dateFormat = "E"
        let dayString = dayStringFormatter.stringFromDate(date)
        
        
        cell.eventDayLabel.text = dayString.uppercaseString
        cell.eventDateLabel.text = dateString
        
    }

    
    
    
    

    
    // MARK: - Navigation

    @IBAction func searchButton(sender: UIBarButtonItem) {
        
    }
    
    
    
    // MARK: - Segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "ShowDetail" {
            let eventDetailsViewController = segue.destinationViewController as! EventDetailsViewController
            
            // Get the cell that generated this segue.
            if let selectedEventCell = sender as? EventTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedEventCell)!
                let selectedEvent = eventsDictionaryArray[indexPath.row]
                eventDetailsViewController.selectedEvent = selectedEvent
                
            }
        }

    }
//
    
//    
//    
//    @IBAction func unwindToEventList(sender:UIStoryboardSegue)
//    {
//        if let sourceViewController = sender.sourceViewController as? PostEventViewController, newEvent = sourceViewController.newEvent {
//            
//            let newIndexPath = NSIndexPath(forRow: events.count, inSection: 0)
//            events.append(newEvent)
//            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
//
//        }
//    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
