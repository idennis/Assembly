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
            
            
            
            //selectedEventDateLabel.text = loadAndFormatDate(event.eventDateTime)
            
            
            
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
    
    
    
    
    
    

    
    
    
    // MARK: Load in data
    
    
    
    
    func loadAndFormatDate(eventDateTime:String){
        
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
