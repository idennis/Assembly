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
