//
//  EventAddress.swift
//  Assembly
//
//  Created by Dennis Hou on 16/03/2016.
//  Copyright © 2016 RMIT. All rights reserved.
//

import Foundation

struct address
{
    var locationName:String
    var streetNumber:Int
    var streetName:String
    var suburb:String
    var stateName:String
    var postcode:Int
    
    
    init()
    {
        locationName = "The Royal Melbourne Hotel"
        streetNumber = 20
        streetName = "Bourke St"
        suburb = "Melbourne"
        stateName = "VIC"
        postcode = 3000

    }
    
}