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
    var eventDesription:String
    var eventAddress:address

//    var hostUser:user
//    var joinedUsers:[user]
    
//    var coverPhoto:UIImage
    
    
    init()
    {
        
        eventName = "Web Dev Meetup 2016"
        eventDateTime = NSDate()
        eventDesription = "Lorem Ipsum"
        eventAddress = address()
        
        
    }
    
    
    
    
}




