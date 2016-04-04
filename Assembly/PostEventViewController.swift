//
//  PostEventViewController.swift
//  Assembly
//
//  Created by Dennis Hou on 2/04/2016.
//  Copyright © 2016 RMIT. All rights reserved.
//

import UIKit

class PostEventViewController: UIViewController,UITextFieldDelegate,UINavigationControllerDelegate {

    
    // MARK: Properties
    
    
    
    @IBOutlet weak var eventNameTextField: UITextField!
    @IBOutlet weak var eventLocationTextField: UITextField!
    @IBOutlet weak var eventTimeDateTextField: UITextField!
    @IBOutlet weak var eventDescriptionTextField: UITextField!
    @IBAction func eventCoverPhotoUploadButton(sender: UIButton) {
    }
    
    @IBOutlet weak var postEventButton: UIBarButtonItem!
    
    
    var newEvent:event?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        eventNameTextField.delegate = self
        
        checkFieldsAreFilled()

        
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
    
    func textFieldDidEndEditing(textField: UITextField) {
        checkFieldsAreFilled()
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        // Disable the Save button while editing.
        postEventButton.enabled = false
        
    }
    
    func checkFieldsAreFilled() {
        // Disable the Save button if the text field is empty.
        let text = eventNameTextField.text
        postEventButton.enabled = !text!.isEmpty
    }

    

    
    // MARK: - Navigation
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // ===  check that the object referenced by the saveButton outlet is the same object instance as sender. If it is, the if statement is executed.
        print("in prepareForSegue")
        if postEventButton === sender {
            print("post success")
            let eventName = eventNameTextField.text
            //let eventLocation = eventLocationTextField.text
            //let eventTimeDate = eventTimeDateTextField.text
            let eventDescription = eventDescriptionTextField.text
            //let eventCoverPhoto = eventCoverPhotoUploadButton.image
            
            
            // Set event
            newEvent = event(eventName: eventName, eventDateTime: NSDate(), eventDescription: eventDescription, eventAddress: address(), eventCategories: ["sample"], coverPhoto: nil)
                
            
        }
    }

    
    
    

}
