//
//  User.swift
//  Assembly
//
//  Created by Dennis Hou on 16/03/2016.
//  Copyright © 2016 RMIT. All rights reserved.
//

import UIKit

struct user
{
    // MARK: Properties 
    // UN, PW
    var username:String
    var password:String
    
    // Basic information
    var firstName:String
    var lastName:String
    var BOD:NSDate
    var location:String
    var profilePhoto:UIImage?

    // Joined Events
    var joinedEvents:[event]
    
}