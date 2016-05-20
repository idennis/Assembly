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
    var model = Model.sharedInstance
    
    
    
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
        
        //model.seedUsers()
        model.fetchUser()
        
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
        if model.checkUserAndPassword(usernameTextField.text!, password: passwordTextField.text!) == true{
            print(model.currUser)
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
            if model.checkUserAndPassword(usernameTextField.text!, password: passwordTextField.text!) == true{
                
                return true
            }
        }
        
        if identifier == "SignupSegue"{
            return true
        }
        return false
    }
}
