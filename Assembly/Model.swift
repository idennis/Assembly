//
//  Model.swift
//  Assembly
//
//  Created by Dennis Hou on 16/03/2016.
//  Copyright © 2016 RMIT. All rights reserved.
//

import UIKit
import CoreData


class Model
{
    
    var users = [User]()
    var currUser = CurrentUser()
    //var currUser = User()

    // Managed Object Controller:
    let moc = DataController().managedObjectContext
    
    
    // MARK: - User Registration
    func saveNewUser(userFullName:String, username:String, userPassword:String, userLocation:String)->Bool {
        
        
        if takenUsername(username) == true{
            return false
        }
        
        else {
            let newUser = NSEntityDescription.insertNewObjectForEntityForName("User", inManagedObjectContext: moc) as! User
            
            newUser.setValue(userFullName, forKey: "fullName")
            newUser.setValue(userPassword, forKey: "password")
            newUser.setValue(username, forKey: "username")
            newUser.setValue(nil, forKey: "profilePhoto")
            newUser.setValue(nil, forKey: "savedEvents")
            newUser.setValue(userLocation, forKey: "userLocation")
            newUser.setValue(false, forKey: "loggedIn")
            
            
            do {
                try
                    moc.save()
                    return true
                
            } catch {
                fatalError("fail to save context: \(error)")
            }
        }
    }
    
    // MARK: - User Login
    // MARK: Find User
    func checkUserAndPassword(username:String, password:String)->Bool{
        let predicate = NSPredicate(format:"username = %@", username)
        let fetchRequest = NSFetchRequest(entityName: "User")
        fetchRequest.predicate = predicate
        
        do{
            let fetchResult = try moc.executeFetchRequest(fetchRequest)
            
            if fetchResult.count > 0 {
                let fetchedUser:User = fetchResult.first as! User
                
                if fetchedUser.username == username && fetchedUser.password == password {
                    self.currUser.fullName = fetchedUser.fullName
                    self.currUser.password = fetchedUser.password
                    self.currUser.userLocation = fetchedUser.userLocation
                    
                    return true
                }
                else{
                    return false
                }
            }
        } catch {
            fatalError("could not fetch users \(error)")
        }
        
        return false
    }

    // MARK: - Sign Up
    // Check if username is taken
    func takenUsername(username:String) -> Bool {
        let predicate = NSPredicate(format:"username = %@", username)
        let fetchRequest = NSFetchRequest(entityName: "User")
        fetchRequest.predicate = predicate
        
        do{
            let fetchResult = try moc.executeFetchRequest(fetchRequest)
            
            if fetchResult.count > 0 {
                let fetchedUser:User = fetchResult.first as! User
                
                if fetchedUser.username == username{
                    return true
                }
                else{
                    return false
                }
            }
        } catch {
            fatalError("could not execute query \(error)")
        }
        
        return false

    }
    
    
    
    
    // MARK: Fetch All Users
    func fetchUser(){
        let userFetch = NSFetchRequest(entityName: "User")
        
        do{
            let fetchedUser = try moc.executeFetchRequest(userFetch) as! [User]
            print(fetchedUser.count)
            for user in fetchedUser{
                
                print(user.fullName, user.password, user.username)
            }
        } catch {
            fatalError("could not fetch user \(error)")
        }
    }
    
    
    // MARK: - Seed Users (use this when model is changed)
    func seedUsers(){
        let newUser = NSEntityDescription.insertNewObjectForEntityForName("User", inManagedObjectContext: moc) as! User
        
        newUser.setValue("Sean Wilkes", forKey: "fullName")
        newUser.setValue("testpassword", forKey: "password")
        newUser.setValue("sean.w", forKey: "username")
        newUser.setValue(nil, forKey: "profilePhoto")
        newUser.setValue(nil, forKey: "savedEvents")
        newUser.setValue("melb au", forKey: "userLocation")
        newUser.setValue(false, forKey: "loggedIn")
        
        
        let newUser2 = NSEntityDescription.insertNewObjectForEntityForName("User", inManagedObjectContext: moc) as! User
        
        newUser2.setValue("Anita Schmidt", forKey: "fullName")
        newUser2.setValue("123456", forKey: "password")
        newUser2.setValue("anita_schmidt", forKey: "username")
        newUser2.setValue(nil, forKey: "profilePhoto")
        newUser2.setValue(nil, forKey: "savedEvents")
        newUser2.setValue("down under", forKey: "userLocation")
        newUser2.setValue(false, forKey: "loggedIn")
        
        
        let newUser3 = NSEntityDescription.insertNewObjectForEntityForName("User", inManagedObjectContext: moc) as! User
        
        newUser3.setValue("Owen Bright", forKey: "fullName")
        newUser3.setValue("password", forKey: "password")
        newUser3.setValue("owen.bright", forKey: "username")
        newUser3.setValue(nil, forKey: "profilePhoto")
        newUser3.setValue(nil, forKey: "savedEvents")
        newUser3.setValue("Melbourne", forKey: "userLocation")
        newUser3.setValue(false, forKey: "loggedIn")
        
        
        let newUser4 = NSEntityDescription.insertNewObjectForEntityForName("User", inManagedObjectContext: moc) as! User
        
        newUser4.setValue("Sara Kindler", forKey: "fullName")
        newUser4.setValue("saraspassword", forKey: "password")
        newUser4.setValue("kindler", forKey: "username")
        newUser4.setValue(nil, forKey: "profilePhoto")
        newUser4.setValue(nil, forKey: "savedEvents")
        newUser4.setValue("Melbourne, AU", forKey: "userLocation")
        newUser4.setValue(false, forKey: "loggedIn")
        
        
        // we save our entity
        do {
            try moc.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
        
    }
    
    
    
    
    // Singleton instance
    private struct Static
    {
        static var instance: Model?
    }
    

    
    
    class var sharedInstance: Model
    {
        // If no instance of model, instantiate new instance
        if !(Static.instance != nil)
        {
            Static.instance = Model()
        }
        return Static.instance!
    }
}


