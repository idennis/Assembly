//
//  LoginViewController.swift
//  Assembly
//
//  Created by Dennis Hou on 3/04/2016.
//  Copyright © 2016 RMIT. All rights reserved.
//

import UIKit
import CoreData

class LoginViewController: UIViewController, UITextFieldDelegate {

    
    // MARK: Model
    //var model = Model.sharedInstance
    let moc = DataController().managedObjectContext
    
    
    // MARK: Properties
    @IBOutlet weak var assemblyLogo: UIImageView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    

    
    
    
    // MARK: Design
    func setLabelsUppercaseAndDrawBorder(){
        usernameLabel.text = usernameLabel.text!.uppercaseString
        passwordLabel.text = passwordLabel.text!.uppercaseString
        self.signUpButton.layer.borderWidth = 1
        self.signUpButton.layer.borderColor = UIColor(red:255.0/255.0, green:255.0/255.0, blue:255.0/255.0, alpha:1.0).CGColor

    }
    
    
    // MARK: - Load
    override func viewDidLoad() {
        
        super.viewDidLoad()
        loginButton.enabled = false

        setLabelsUppercaseAndDrawBorder()
        
        // Handle the text field’s user input through delegate callbacks.
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        
        // Check of input fields are empty
        checkLoginEmpty()
        
        //seedUsers()
        fetchUser()
        
    }

    
    // MARK: UITextFieldDelegate
    func checkLoginEmpty() -> Bool{
        let usernameFieldValue = usernameTextField.text ?? ""
        let passwordFieldValue = passwordTextField.text ?? ""
        
        if !usernameFieldValue.isEmpty && !passwordFieldValue.isEmpty{
            loginButton.enabled = true
            return false
        }
        return true
    }
    
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // Check if first responder is username textfield, then jumps to password textfield
        if self.usernameTextField.isFirstResponder(){
            self.passwordTextField.becomeFirstResponder()
            checkLoginEmpty()
        }
        // If first responder is password textfield, resign first responder, hide keyboard, and activate Login touch up inside action
        else{
            textField.resignFirstResponder()
            
            if checkLoginEmpty() == false{
                print("check empty fields")
                loginButton.sendActionsForControlEvents(.TouchUpInside)
            }
            return true
        }
        return false
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        checkLoginEmpty()
    }
    
    
    @IBAction func userTappedBackground(sender: AnyObject) {
        passwordTextField.resignFirstResponder()
        usernameTextField.resignFirstResponder()
    }
    
    
    // MARK: - Actions
    
    // User press Login Button
    @IBAction func loginButton(sender: UIButton) {
        if checkUserAndPassword(usernameTextField.text!, password: passwordTextField.text!) == true{
            print("USER FOUND")
            
        }
        else{
            let alert = UIAlertController(title: "Oops", message: "The username and password you have entered does not match our records. Double-check and try again.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)

            print("NOT FOUND")
            
        }
        
    }
    @IBAction func signUpButton(sender: UIButton) {
        
    }
    @IBAction func passwordTextField(sender: UITextField) {
    }
    
    
    // MARK: - Find User in DB
    func checkUserAndPassword(username:String, password:String)->Bool{
        let predicate = NSPredicate(format:"username = %@", username)
        let fetchRequest = NSFetchRequest(entityName: "User")
        fetchRequest.predicate = predicate
        
        
        
        do{
            let fetchResult = try moc.executeFetchRequest(fetchRequest)
            
            if fetchResult.count > 0 {
                let fetchedUser:User = fetchResult.first as! User
                
                if fetchedUser.username == username && fetchedUser.password == password {
                    fetchedUser.loggedIn = true
                    let currUser = fetchedUser
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
    
    
    // MARK: - Fetch User
    func fetchUser(){
        let userFetch = NSFetchRequest(entityName: "User")
        
        do{
            let fetchedUser = try moc.executeFetchRequest(userFetch) as! [User]
            print(fetchedUser.count)
            for user in fetchedUser{
                user.loggedIn = false
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
    
    
    // MARK: - Segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Pass the selected object to the new view controller.
        if segue.identifier == "LoginSegue" {
            //let eventTableViewController = segue.destinationViewController as! EventTableViewController
            //eventTableViewController = loggedIn
        }
        
    }
    
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if identifier == "LoginSegue" {
            if checkUserAndPassword(usernameTextField.text!, password: passwordTextField.text!) == true{
                
                return true
            }
        }
        
        if identifier == "SignupSegue"{
            return true
        }
        return false
    }
}
