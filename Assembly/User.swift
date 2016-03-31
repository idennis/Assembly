//
//  User.swift
//  Assembly
//
//  Created by Dennis Hou on 16/03/2016.
//  Copyright © 2016 RMIT. All rights reserved.
//

import Foundation

struct user
{
    // UN, PW
    var username:String
    var password:String
    
    // Basic information
    var firstName:String
    var lastName:String
    var BOD:NSDate
    var location:String
    

    // Joined Events
    var joinedEvents:[Event]
    
}