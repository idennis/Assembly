//
//  LoginViewController.swift
//  Assembly
//
//  Created by Dennis Hou on 3/04/2016.
//  Copyright © 2016 RMIT. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    
    // MARK: Model
    //var model = Model.sharedInstance
    
    // MARK: Properties
    @IBOutlet weak var assemblyLogo: UIImageView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    

    
    // MARK: Design
    func setButtonBorderAsWhite() -> UIColor{
        return UIColor(red:255.0/255.0, green:255.0/255.0, blue:255.0/255.0, alpha:1.0)
    }
    
    func setLabelsUppercase(){
        usernameLabel.text = usernameLabel.text!.uppercaseString
        passwordLabel.text = passwordLabel.text!.uppercaseString
    }
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        loginButton.enabled = false
        
        
        // Programmatically changes design
        setLabelsUppercase()
        self.signUpButton.layer.borderWidth = 1
        self.signUpButton.layer.borderColor = setButtonBorderAsWhite().CGColor
        
        // Handle the text field’s user input through delegate callbacks.
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        
        // Check of input fields are empty
        checkLoginEmpty()
        
    }

    
    // MARK: UITextFieldDelegate
    func checkLoginEmpty() -> Bool{
        let usernameFieldValue = usernameTextField.text ?? ""
        let passwordFieldValue = passwordTextField.text ?? ""
        
        if !usernameFieldValue.isEmpty && !passwordFieldValue.isEmpty{
            loginButton.enabled = true
            print("login button enabled")
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
        //self.view.endEditing(true)
        passwordTextField.resignFirstResponder()
        usernameTextField.resignFirstResponder()
    }
    
    
    // MARK: Actions
    @IBAction func loginButton(sender: UIButton) {
    }
    @IBAction func signUpButton(sender: UIButton) {
    }
    @IBAction func passwordTextField(sender: UITextField) {
    }
    
}
