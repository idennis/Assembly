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
        event1.eventCategories = ["Technology", "Web"]
        
        var event1Address:address = address()
        event1Address.locationName = "The Royal Melbourne Hotel"
        event1Address.streetNumber = 20
        event1Address.streetName = "Bourke St"
        event1Address.suburb = "Melbourne"
        event1Address.stateName = "VIC"
        event1Address.postcode = 3000
        
        event1.eventAddress = event1Address
        
        events.append(event1)
        
        
        
        var event2:event = event()
        event2.eventName = "Rowing Club 2016"
        event2.eventDateTime = NSDate()
        event2.eventDescription = "asdasdasdads"
        event2.eventCategories = ["Rowing", "Sports"]
        
        var event2Address:address = address()
        event2Address.locationName = "Queensberry Hotel"
        event2Address.streetNumber = 14
        event2Address.streetName = "Swanston St"
        event2Address.suburb = "Carlton"
        event2Address.stateName = "VIC"
        event2Address.postcode = 3053
        
        event2.eventAddress = event2Address
        
        events.append(event2)
        

    }
    

}


