//
//  EventDetailsViewController.swift
//  Assembly
//
//  Created by Dennis Hou on 3/04/2016.
//  Copyright © 2016 RMIT. All rights reserved.
//

import UIKit

class EventDetailsViewController: UIViewController, UINavigationControllerDelegate, UIScrollViewDelegate {

    // MARK:- Properties
    var selectedEvent:[String:AnyObject]?
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var selectedEventNameLabel: UILabel!
    @IBOutlet weak var selectedEventHostUserLabel: UILabel!
    @IBOutlet weak var selectedEventDateLabel: UILabel!
    @IBOutlet weak var selectedEventTimeLabel: UILabel!
    
    @IBOutlet weak var selectedEventAddressNameLabel: UILabel!
    @IBOutlet weak var selectedEventAddressFullLabel: UILabel!
    @IBOutlet weak var viewOnMapLabel: UILabel!
    @IBOutlet weak var viewMoreChevron: UIImageView!
    @IBOutlet var tapEventAddressView: UITapGestureRecognizer!

    
    @IBOutlet weak var selectedEventCoverPhoto: UIImageView!

    @IBOutlet weak var selectedEventNavBar: UINavigationItem!
    
    @IBOutlet weak var selectedEventDateTimeView: UIView!
    @IBOutlet weak var selectedEventLocationView: UIView!
    @IBOutlet weak var selectedEventDescription: UILabel!
    
    @IBOutlet weak var joinEventButton: UIButton!
    
    // Fallback spacing attribute
    var spacingToBottom:NSLayoutConstraint = NSLayoutConstraint()
    
    //MARK:- Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let event = selectedEvent{
            selectedEventNavBar.title = (event["name"] as? String)!
//            if (event.coverPhoto != nil){
//                print("if photo is not null")
//                selectedEventCoverPhoto.image = event.coverPhoto
//            }
//            else{
//                print("if photo is not found")
//                selectedEventCoverPhoto.image = UIImage(named:"coverPhoto-default")
//            }
            selectedEventHostUserLabel.text = "Hosted By "+(event["group"]?["name"] as? String)!
            selectedEventHostUserLabel.text = selectedEventHostUserLabel.text!.uppercaseString
            selectedEventNameLabel.text = (event["name"] as? String)!
            
            if (event["venue"]?["name"] != nil){
                selectedEventAddressNameLabel.text = (event["venue"]?["name"] as? String)!
                selectedEventAddressFullLabel.text = (event["venue"]?["address_1"] as? String)!
            }
            else{
                selectedEventAddressNameLabel.text = ""
                selectedEventAddressFullLabel.text = "Venue information is available for group members only."
                viewOnMapLabel.removeFromSuperview()
                viewMoreChevron.removeFromSuperview()
                loadFallbackConstraints()
                selectedEventLocationView.addConstraint(spacingToBottom)
            }
            
            
            
            
            let eventTime = (event["time"] as? Int)!
            if (event["duration"] != nil){
                let eventDuration = (event["duration"] as? Int)!
                loadAndFormatDate(eventTime, duration: eventDuration)
            }
            else{
                loadAndFormatDate(eventTime, duration:0)
            }
            
            // Label to HTML Formatting from http://stackoverflow.com/questions/11153810/why-does-nstextstorage-setattributedstring-crash-with-nsmutableattributedstrin
            var descStr = NSMutableAttributedString()
            do{
            descStr = try NSMutableAttributedString(data: (event["description"] as? String)!.dataUsingEncoding(NSUnicodeStringEncoding, allowLossyConversion: true)!, options: [ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType], documentAttributes: nil)
                
                let fullRange : NSRange = NSMakeRange(0, descStr.length)
                descStr.addAttributes([NSFontAttributeName : UIFont.systemFontOfSize(16)], range: fullRange)
                
            } catch {
                print ("Error parsing event description")
            }
            selectedEventDescription.attributedText = descStr
            
            
            scrollView.delegate = self

        }
        drawBorders()
    }
    
    
    
    // MARK: - Styling
    func drawBorders(){
        
        // Draw borders on views
        selectedEventDateTimeView.layer.borderWidth = 1
        selectedEventDateTimeView.layer.borderColor = UIColor.init(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0).CGColor
        selectedEventLocationView.layer.borderWidth = 1
        selectedEventLocationView.layer.borderColor = UIColor.init(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0).CGColor
    }
    
    // Once View On Map link is removed due to privated addresses, programmatically set new constraints to ensure subview is correctly rendered
    func loadFallbackConstraints(){
        self.spacingToBottom = NSLayoutConstraint(item: selectedEventLocationView, attribute: .Bottom , relatedBy: .Equal, toItem: selectedEventAddressFullLabel, attribute: .Bottom, multiplier: 1.0, constant: 15)
    }
    
    
    // MARK: Date Formatting
    func loadAndFormatDate(time:Int, duration:Int){
        // Conversion from Epoch time to Gregorian calendar time
        let intTimeValue:Int = time
        let ti = NSTimeInterval(intTimeValue)
        
        // Divided by milliseconds as given from Meetup's Database
        let date = NSDate(timeIntervalSince1970: ti/1000.0)
        
        // Conversion from ms to hours (Event Duration)
        let intDurationValue:Int = duration
        
        // Add duration of event in ms to event start time since epoch
        let intEventEndTime:Int = intTimeValue + intDurationValue
        
        let durationInterval = NSTimeInterval(intEventEndTime)
        // Convert end time to readable time format
        let endDate = NSDate(timeIntervalSince1970: durationInterval/1000.0)
        
        let endTimeStringFormatter = NSDateFormatter()
        endTimeStringFormatter.dateFormat = "h:mmaa"
        let endTimeString = endTimeStringFormatter.stringFromDate(endDate)
        
        // Human readable date, nicely formatted :)
        let dateStringFormatter = NSDateFormatter()
        dateStringFormatter.dateFormat = "EEEE, dd MMMM yyyy"
        let dateString = dateStringFormatter.stringFromDate(date)
        
        let timeStringFormatter = NSDateFormatter()
        timeStringFormatter.dateFormat = "h:mmaa"
        let timeString = timeStringFormatter.stringFromDate(date)
        
        selectedEventDateLabel.text = dateString

        // If no duration supplied, display "From <time>" instead
        if (duration == 0){
            selectedEventTimeLabel.text = "From "+timeString
        }
        else{
            selectedEventTimeLabel.text = timeString+" - "+endTimeString
        }
        
        
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: ACTION
    
    @IBAction func tapJoinButton(sender: UIButton) {
        UIView.animateWithDuration(0.2, animations: {
            self.joinEventButton.backgroundColor = UIColor(red:0.17, green:0.17, blue:0.21, alpha:1.0)
            //self.joinEventButton.titleLabel!.text = "JOINED"
        }, completion: nil)
        
    }
    
    
    
    
    func scrollViewDidScroll(sender: UIScrollView){
    }
    
    
    
    
    
    
    

    
    // MARK: - Navigation
    
    // Validate segue (disable map segue if address is not public)
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject!) -> Bool {
        
        if identifier == "ShowMap"{
            if (selectedEvent!["venue"] == nil) || (selectedEventAddressNameLabel.text == "TBA") {
                return false
            }
            else{
                return true
            }
        }
        // Fallback
        return true
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowMap" {
            let eventMapViewController = segue.destinationViewController as! EventMapViewController
                eventMapViewController.selectedEventDetails = selectedEvent
        }
    }
    
    
    @IBAction func tapEventAddress(sender: UIGestureRecognizer){
        selectedEventLocationView.backgroundColor = UIColor.init(red:0.77,green:0.77,blue:0.77,alpha:1.00)
    }
    
}
