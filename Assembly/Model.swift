//
//  Model.swift
//  Assembly
//
//  Created by Dennis Hou on 16/03/2016.
//  Copyright © 2016 RMIT. All rights reserved.
//

import Foundation

class Model
{


    init()
    {
        var event1:event
        
        event1.eventName = "Web Dev Meetup 2016"
        event1.eventDateTime = NSDate()
        event1.eventDesription = "Lorem Ipsum"

        event1.eventAddress.locationName = "The Royal Melbourne Hotel"
        event1.eventAddress.streetNumber = 20
        event1.eventAddress.streetName = "Bourke St"
        event1.eventAddress.suburb = "Melbourne"
        event1.eventAddress.stateName = "VIC"
        event1.eventAddress.postcode = 3000

        
        
//        event1.hostUser =
        
    }
}