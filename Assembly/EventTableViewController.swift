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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Style overrides
            self.navigationController?.navigationBar.translucent = false
            changeNavTitle()
            // Set table view to full screen width
            tableView.layoutMargins = UIEdgeInsetsZero
            tableView.separatorInset = UIEdgeInsetsZero
        
        
        getNewEvents()
        
        
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
    func getNewEvents(){
        // Data load-ins from Meetup.com
        Alamofire.request(.GET, "https://api.meetup.com/2/open_events?key="+APIKEY+"&sign=true&photo-host=secure&host=public&country=AU&city=melbourne&state=VC&time=,5w&group_photo&page=10").responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                print("Success")
                
                let swiftyJsonVar = JSON(responseData.result.value!)
                
                
                if let data = swiftyJsonVar["results"].arrayObject{
                    
                    self.eventsDictionaryArray = data as! [[String:AnyObject]]
                    
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
    
    
    // MARK: Group Name
    func getGroupImageURL(groupID:Int64){
        let stringID = String(groupID)
        //var imageURL:String? = ""
        
        Alamofire.request(.GET, "https://api.meetup.com/2/groups?&sign=true&photo-host=public&group_id="+stringID+"&page=20&key="+APIKEY).responseJSON { (response) in
            
            if let JsonVar = response.result.value {
                if let groupData = JsonVar["results"]{
                    self.groupPhotoDictionaryArray = groupData as! [[String:AnyObject]]
                    print ("in getGroupImageURL")
                    self.imageURL = self.groupPhotoDictionaryArray[0]["group_photo"]?["photo_link"] as? String
                    print("IN IF STATEMENT")
                    print(self.imageURL)
                }
            }

        }
        print("OUTSIDE IF")
        print(self.imageURL)
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

        
        
        // Decode URL to Image
        getGroupImageURL(groupID)
        let fullPath = String(self.imageURL)
        //print("FULL PATH: "+fullPath)
        
        let url = NSURL(string:fullPath)
        //print ("URL: ",url)
        
        if url != nil{
            print("URL is NOT NULL")
            let data = NSData(contentsOfURL: url!)
            
            if data != nil {
                print("DATA IS NOT NULL")
                cell.eventCoverPhoto.image = UIImage(data:data!)
            }
        }
        
        
        
        
        //let NSDateValue = convertDateToNSDate(dateFromJSON!)
        //let formattedDate = convertNSDateToString(NSDateValue!)
        
        
        
        
//        let baseURL = "http://photos2.meetupstatic.com/photos/event/3/9/1/8/"
//        let picURL = dict["backdrop_path"] as? String
//        let fullPath = baseURL + picURL!
//        let url = NSURL(string: fullPath)
//        let data = NSData(contentsOfURL: url!)
//        
//        if data != nil{
//            cell.eventCoverPhoto?.image = UIImage(data: data!)
//        }

        
        
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
        
        
        
        
        // Fetch event for data source layout
//        let event = events[indexPath.row]
//        
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


    
    // MARK: - Navigation

    @IBAction func searchButton(sender: UIBarButtonItem) {
        
    }
    
    
    
    
    //In a storyboard-based application, you will often want to do a little preparation before navigation
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

}
