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
        
    @IBOutlet weak var selectedEventDateLabel: UILabel!
    @IBOutlet weak var selectedEventTimeLabel: UILabel!
    
    @IBOutlet weak var selectedEventAddressNameLabel: UILabel!
    @IBOutlet weak var selectedEventAddressFullLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let event = selectedEvent{
            navigationItem.title = event.eventName
            selectedEventNameLabel.text = event.eventName
            selectedEventAddressNameLabel.text = event.eventAddress?.locationName
            print(event.eventAddress?.locationName)
            selectedEventAddressFullLabel.text = loadAddress()
        }
        
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
