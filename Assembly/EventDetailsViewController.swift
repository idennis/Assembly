//
//  EventDetailsViewController.swift
//  Assembly
//
//  Created by Dennis Hou on 3/04/2016.
//  Copyright © 2016 RMIT. All rights reserved.
//

import UIKit

class EventDetailsViewController: UIViewController, UINavigationControllerDelegate, UIScrollViewDelegate {

    
    var selectedEvent:[String:AnyObject]?
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var selectedEventNameLabel: UILabel!
    @IBOutlet weak var selectedEventHostUserLabel: UILabel!
    
        
    @IBOutlet weak var selectedEventDateLabel: UILabel!
    @IBOutlet weak var selectedEventTimeLabel: UILabel!
    
    @IBOutlet weak var selectedEventAddressNameLabel: UILabel!
    @IBOutlet weak var selectedEventAddressFullLabel: UILabel!

    @IBOutlet weak var selectedEventCoverPhoto: UIImageView!

    @IBOutlet weak var selectedEventNavBar: UINavigationItem!
    
    @IBOutlet weak var selectedEventDateTimeView: UIView!
    @IBOutlet weak var selectedEventLocationView: UIView!
    
    @IBOutlet weak var selectedEventDescription: UILabel!
    
    @IBOutlet weak var joinEventButton: UIButton!
    
    
    
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
            }
            
            
            
            
            let eventTime = (event["time"] as? Int)!
            if (event["duration"] != nil){
                let eventDuration = (event["duration"] as? Int)!
                loadAndFormatDate(eventTime, duration: eventDuration)
            }
            else{
                loadAndFormatDate(eventTime, duration:0)
            }
            //selectedEventDateLabel.text = loadAndFormatDate(time)
            
            
            
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
        
        // Draw borders on views
        selectedEventDateTimeView.layer.borderWidth = 1
        selectedEventDateTimeView.layer.borderColor = UIColor.init(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0).CGColor
        selectedEventLocationView.layer.borderWidth = 1
        selectedEventLocationView.layer.borderColor = UIColor.init(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0).CGColor
        
        
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

//            let calendar = NSCalendar.currentCalendar()
        // Split date into components
//            let components = calendar.components([.Day,.Month,.Year], fromDate: date)
//            
//            let year = components.year
//            let month = components.month
//            let day = components.day
//            
//            let allMonths = formatter.shortMonthSymbols
//            let monthEnglish = allMonths[month-1]
//            print (year,monthEnglish,day)

        
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
    
    
    
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
