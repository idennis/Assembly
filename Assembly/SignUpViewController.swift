//
//  SignUpViewController.swift
//  Assembly
//
//  Created by Dennis Hou on 15/05/2016.
//  Copyright © 2016 RMIT. All rights reserved.
//

import UIKit
import CoreData

class SignUpViewController: UIViewController {

    
    // MARK: - Properties
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var signupButton: UIButton!
    
    
    // Text Fields
    @IBOutlet weak var fullNameField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var locationField: UITextField!
    
    
    // Core Data
    let moc = DataController().managedObjectContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    // Cancel
    @IBAction func cancel(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // Sign up
    @IBAction func signupTapped(sender: AnyObject){
        let userFullName = fullNameField.text
        let username = usernameField.text
        let userPassword = passwordField.text
        let userLocation = locationField.text
        
        if (userFullName!.isEmpty || username!.isEmpty || userPassword!.isEmpty || userLocation!.isEmpty){
            let alert = UIAlertController(title: "Oops!", message: "You need to fill in all the fields.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Got it", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
        else{

            let newUser = NSEntityDescription.insertNewObjectForEntityForName("User", inManagedObjectContext: moc) as! User
            
            newUser.setValue(userFullName, forKey: "fullName")
            newUser.setValue(userPassword, forKey: "password")
            newUser.setValue(username, forKey: "username")
            newUser.setValue(nil, forKey: "profilePhoto")
            newUser.setValue(nil, forKey: "savedEvents")
            newUser.setValue(userLocation, forKey: "userLocation")
            
            
            do {
                try
                    moc.save()
                    let alert = UIAlertController(title: "Register complete", message: "Let's log in.", preferredStyle: UIAlertControllerStyle.Alert)
                    // Redirect user back to the login screen
                    let alertAction = UIAlertAction(title: "Got it", style: .Default) { (action) -> Void in
                        self.dismissViewControllerAnimated(true, completion: nil)
                    }
                    alert.addAction(alertAction)
                    self.presentViewController(alert, animated: true, completion: nil)
                
            } catch {
                fatalError("fail to save context: \(error)")
            }

        }
        
        
    }
    
}
