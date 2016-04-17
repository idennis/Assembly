//
//  PostEventViewController.swift
//  Assembly
//
//  Created by Dennis Hou on 2/04/2016.
//  Copyright © 2016 RMIT. All rights reserved.
//

import UIKit

class PostEventViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    // MARK: Properties
    
    
    // Labels
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var eventNameCharLabel: UILabel!
    @IBOutlet weak var eventLocationLabel: UILabel!
    @IBOutlet weak var eventTimeDateLabel: UILabel!
    @IBOutlet weak var eventDescriptionLabel: UILabel!
    @IBOutlet weak var eventCoverPhotoLabel: UILabel!
    
    
    // Text Fields and Post button
    @IBOutlet weak var eventNameTextField: UITextField!
    @IBOutlet weak var eventLocationTextField: UITextField!
    @IBOutlet weak var eventTimeDateTextField: UITextField!
    @IBOutlet weak var eventDescriptionTextField: UITextView!
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var postEventButton: UIBarButtonItem!
    
    
    var newEvent:event?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabelsUppercase()
        eventNameTextField.delegate = self
        
        checkFieldsAreFilled()
        
        // Styling Text View
        eventDescriptionTextField.layer.borderWidth = 0.50
        eventDescriptionTextField.layer.borderColor = UIColor(red:0.80,green:0.80,blue:0.80,alpha:1.00).CGColor
        
    }

    // Styling labels programmatically
    func setLabelsUppercase(){
        eventNameLabel.text = eventNameLabel.text!.uppercaseString
        eventLocationLabel.text = eventLocationLabel.text!.uppercaseString
        eventTimeDateLabel.text = eventTimeDateLabel.text!.uppercaseString
        eventDescriptionLabel.text = eventDescriptionLabel.text!.uppercaseString
        eventCoverPhotoLabel.text = eventCoverPhotoLabel.text!.uppercaseString
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

    
    // Limits Event Name length to 50 characters
    // Changes character count label's colour in accordance to character count
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if range.length + range.location > eventNameTextField.text?.characters.count
        {
            return false
        }
        
        let NewLength = (eventNameTextField.text?.characters.count)! + string.characters.count - range.length
        if (NewLength==51){
            eventNameCharLabel.textColor = UIColor.redColor()
            eventNameCharLabel.text = "0 character left"
        }
        else if (NewLength == 49 || NewLength == 50){
            eventNameCharLabel.text = "\(50-NewLength) character left"
        }
        else if (NewLength > 40){
            eventNameCharLabel.textColor = UIColor(red:1.00, green:0.53, blue:0.00, alpha:1.0)
            eventNameCharLabel.text = "\(50-NewLength) characters left"
        }
        else{
            eventNameCharLabel.textColor = UIColor(red:0.48, green:0.48, blue:0.48, alpha:1.0)
            eventNameCharLabel.text = "\(50-NewLength) characters left"
        }
        print(NewLength)
        return NewLength <= 50
        
    }
    
    
    
    
    // MARK: Actions
    
    @IBAction func selectImageFromPhotoLibrary(sender: UITapGestureRecognizer) {
        print("safdsghrejt")
        eventNameTextField.resignFirstResponder()
        //view.endEditing(true)
        let imagePickerController = UIImagePickerController()
        
        imagePickerController.sourceType = .PhotoLibrary
        imagePickerController.delegate = self
        presentViewController(imagePickerController, animated: true, completion: nil)
    }
    
    
    // MARK: UIImagePickerControllerDelegate

    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        photoImageView.image = selectedImage
        dismissViewControllerAnimated(true, completion: nil)
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
            var eventCoverPhoto = UIImage(named:"coverPhoto-default")
            
            if photoImageView.image == UIImage(named:"upload-cover-photo")
            {
                eventCoverPhoto = UIImage(named:"coverPhoto-default")
            }
            else{
                eventCoverPhoto = photoImageView.image
            }
            
            // Set event
            newEvent = event(eventName: eventName, eventDateTime: NSDate(), eventDescription: eventDescription, eventAddress: address(), eventCategories: ["sample"], coverPhoto: eventCoverPhoto)
                
            
        }
    }

    
    
    

}
