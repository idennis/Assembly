//
//  PostEventViewController.swift
//  Assembly
//
//  Created by Dennis Hou on 2/04/2016.
//  Copyright © 2016 RMIT. All rights reserved.
//

import UIKit

class PostEventViewController: UIViewController {

    
    // MARK: Properties
    @IBOutlet weak var eventNameTextField: UITextField!
    @IBOutlet weak var eventLocationTextField: UITextField!
    @IBOutlet weak var eventTimeDateTextField: UITextField!
    @IBOutlet weak var eventDescriptionTextField: UITextField!
    @IBAction func eventCoverPhotoUploadButton(sender: UIButton) {
    }
    @IBAction func postEventButton(sender: UIBarButtonItem) {
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    // MARK: UITextFieldDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
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
