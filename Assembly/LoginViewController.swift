//
//  LoginViewController.swift
//  Assembly
//
//  Created by Dennis Hou on 3/04/2016.
//  Copyright © 2016 RMIT. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    
    // MARK: Properties
    @IBOutlet weak var assemblyLogo: UIImageView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    
    @IBAction func loginButton(sender: UIButton) {
    }
    @IBAction func signUpButton(sender: UIButton) {
    }
    @IBOutlet weak var signUpButton: UIButton!
    
    
    
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
        
        
        setLabelsUppercase()
        
        // Set sign up button border width and color
        self.signUpButton.layer.borderWidth = 1
        self.signUpButton.layer.borderColor = setButtonBorderAsWhite().CGColor
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

}
