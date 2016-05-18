//
//  User+CoreDataProperties.swift
//  
//
//  Created by Dennis Hou on 16/05/2016.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension User {

    @NSManaged var fullName: String?
    @NSManaged var userLocation: String?
    @NSManaged var savedEvents: NSObject?
    @NSManaged var profilePhoto: NSData?
    @NSManaged var username: String?
    @NSManaged var password: String?
    @NSManaged var loggedIn: NSNumber?
    @NSManaged var userHasEvent: NSSet?

}
