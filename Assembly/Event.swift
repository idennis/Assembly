//
//  Event.swift
//  Assembly
//
//  Created by Dennis Hou on 16/03/2016.
//  Copyright © 2016 RMIT. All rights reserved.
//

import Foundation

struct event
{
    var eventName:String
    var eventDateTime:NSDate
    var eventDescription:String
    var eventAddress:address
    
    // Search / Tagging information
    var eventCategories:[String]

    // Users in event
//    var hostUser:user
//    var joinedUsers:[user]
    
    // Photo
//    var coverPhoto:UIImage
    
    init(eventName:String, eventDateTime:NSDate, eventDescription:String, eventCategories:[String], eventAddress:address)
    {
        self.eventName = eventName
        self.eventDateTime = eventDateTime
        self.eventDescription = eventDescription
        self.eventCategories = eventCategories
        self.eventAddress = eventAddress
    }
}




