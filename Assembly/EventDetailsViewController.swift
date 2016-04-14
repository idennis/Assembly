//
//  EventDetailsViewController.swift
//  Assembly
//
//  Created by Dennis Hou on 3/04/2016.
//  Copyright © 2016 RMIT. All rights reserved.
//

import UIKit

class EventDetailsViewController: UIViewController, UINavigationControllerDelegate {

    
    var selectedEvent:event?
    
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
    
    
    @IBOutlet weak var joinEventButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        if let event = selectedEvent{
            selectedEventNavBar.title = event.eventName
            if (event.coverPhoto != nil){
                print("if photo is not null")
                selectedEventCoverPhoto.image = event.coverPhoto
            }
            else{
                print("if photo is not found")
                selectedEventCoverPhoto.image = UIImage(named:"coverPhoto-default")
            }
            selectedEventHostUserLabel.text = selectedEventHostUserLabel.text!.uppercaseString
            selectedEventNameLabel.text = event.eventName
            selectedEventAddressNameLabel.text = event.eventAddress?.locationName
            selectedEventAddressFullLabel.text = loadAddress()
        }
        
        // Draw borders on views
        selectedEventDateTimeView.layer.borderWidth = 1
        selectedEventDateTimeView.layer.borderColor = UIColor.init(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0).CGColor
        selectedEventLocationView.layer.borderWidth = 1
        selectedEventLocationView.layer.borderColor = UIColor.init(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0).CGColor
        joinButtonDefault()
        setGradientOnView(selectedEventCoverPhoto)
    }
    
    
    
    func setGradientOnView(view:UIView)
        
    {
        
        // Create a Gradient Layer and set the frame (size and position to the same as the image view).
        
        let gradient:CAGradientLayer = CAGradientLayer(layer:view.layer);
        gradient.frame = view.frame;
        
    
        // This is a Black to White gradient. Change these values to get desired effect.
        let beginColor:UIColor = UIColor(red:0, green:0, blue:0, alpha: 0.5)
        
        // let endColor:UIColor = UIColor(red:0, green:255, blue:0, alpha: 0.25)
        let endColor:UIColor = UIColor(red:255, green:255, blue:255, alpha: 0.25)
        
        // Color Array may contain more than 2 just colors. Depends on the effect being attempted.
        let colorArray:[CGColor] = [beginColor.CGColor, endColor.CGColor];
        
        
        
        // Attach color array to gradient.
        
        gradient.colors = colorArray;
        
        
        
        // Finally, add gradient layer onto UIView.
        
        view.layer.insertSublayer(gradient, atIndex:0);
        
    }
    
    
    
    
    func joinButtonDefault(){
        //joinEventButton.layer.shadowColor = UIColor.blackColor().CGColor
        joinEventButton.layer.shadowOffset = CGSizeMake(3, 3)
        joinEventButton.layer.shadowRadius = 5
        joinEventButton.layer.shadowOpacity = 0.3
        
    }

    
    
    
    // MARK: Load in data
    
    // VERY VERY VERY HACKY AND LAZY WAY OF CONCATENATING
    func loadAddress() -> String{
        var catenate:String
        
        if (selectedEvent!.eventAddress?.streetNumber != nil)
        {
            catenate = (selectedEvent?.eventAddress?.streetNumber?.description)!+(" ")
        }
        else
        {
            catenate = ""
        }
        if (selectedEvent?.eventAddress?.streetName != nil){
            catenate += (selectedEvent?.eventAddress?.streetName)!+(", ")
        }
        else
        {
            catenate = ""
        }
        if (selectedEvent?.eventAddress?.suburb != nil){
            catenate += (selectedEvent?.eventAddress?.suburb)!+(" ")
        }
        else
        {
            catenate = ""
        }
        if (selectedEvent?.eventAddress?.stateName != nil){
            catenate += (selectedEvent?.eventAddress?.stateName)!+(" ")
        }
        else
        {
            catenate = ""
        }
        if (selectedEvent?.eventAddress?.postcode != nil){
            catenate += (selectedEvent?.eventAddress?.postcode?.description)!
        }
        else
        {
            catenate = ""
        }
        
        return catenate
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
