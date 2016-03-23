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
    
    var events:[event] = []


    init()
    {
        var event1:event = event()
        event1.eventName = "Web Development Meetup 2016"
        event1.eventDateTime = NSDate()
        event1.eventDescription = "asdasdasdads"
        
        var event1Address:address = address()
        event1Address.locationName = "The Royal Melbourne Hotel"
        event1Address.streetNumber = 20
        event1Address.streetName = "Bourke St"
        event1Address.suburb = "Melbourne"
        event1Address.stateName = "VIC"
        event1Address.postcode = 3000
        
        event1.eventAddress = event1Address
        
        events.append(event1)
        
        

    }
    

}


