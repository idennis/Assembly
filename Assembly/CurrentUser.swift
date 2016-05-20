//
//  CurrentUser.swift
//  Assembly
//
//  Created by Dennis Hou on 20/05/2016.
//  Copyright © 2016 RMIT. All rights reserved.
//

import Foundation

struct CurrentUser{
    
    var fullName: String?
    var userLocation: String?
    var savedEvents: NSObject?
    var profilePhoto: NSData?
    var username: String?
    var password: String?
    var loggedIn: NSNumber?
    var userHasEvent: NSSet?

}