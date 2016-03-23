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
    var event1:event
    var event1Address:address

    init()
    {
        event1Address = address.init(locationName: "The Royal Melbourne Hotel", streetNumber: 20, streetName: "Bourke St", suburb: "Melbourne", stateName: "VIC", postcode: 3000)
        
        event1 = event.init(eventName: "Web Development Meetup 2016", eventDateTime: NSDate(), eventDescription: "asdasdas", eventCategories: ["Web Development", "Technology"], eventAddress: event1Address)
        
        events.append(event1)

        print(events[0])

    }
    

    
    
    
    
    
}
