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
        
        
        
        // Assign delegate to text fields
        eventNameTextField.delegate = self
        eventLocationTextField.delegate = self
        eventTimeDateTextField.delegate = self
        eventLocationTextField.delegate = self
        
        
        eventNameTextField.becomeFirstResponder()
        
        checkFieldsAreFilled()
        
    }

    
    // MARK: Styling
    // Styling labels programmatically
    func setLabelsUppercase(){
        eventNameLabel.text = eventNameLabel.text!.uppercaseString
        eventLocationLabel.text = eventLocationLabel.text!.uppercaseString
        eventTimeDateLabel.text = eventTimeDateLabel.text!.uppercaseString
        eventDescriptionLabel.text = eventDescriptionLabel.text!.uppercaseString
        eventCoverPhotoLabel.text = eventCoverPhotoLabel.text!.uppercaseString
        eventDescriptionTextField.layer.borderWidth = 0.50
        eventDescriptionTextField.layer.borderColor = UIColor(red:0.80,green:0.80,blue:0.80,alpha:1.00).CGColor
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    // MARK: UITextFieldDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        print("Return button pressed")
        checkFieldsAreFilled()
        
        if (textField == eventNameTextField){
            eventNameTextField.resignFirstResponder()
            eventLocationTextField.becomeFirstResponder()
        }
        else if (textField == eventLocationTextField){
            eventLocationTextField.resignFirstResponder()
            eventTimeDateTextField.becomeFirstResponder()
        }
        else if (textField == eventTimeDateTextField){
            eventTimeDateTextField.resignFirstResponder()
            eventDescriptionTextField.becomeFirstResponder()
        }
        
        // Fallback check input
        checkFieldsAreFilled()
        
        // Hide the keyboard.
        textField.resignFirstResponder()
        
        return true
    }
    
    
    func textFieldDidEndEditing(textField: UITextField) {
        checkFieldsAreFilled()
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        print("Start editing text field")
        checkFieldsAreFilled()
        if (textField == eventTimeDateTextField){
            // Fallback date picker
            print("eventTimeDateTextField active")
            let datePicker = UIDatePicker()
            datePicker.minuteInterval = 15
            eventTimeDateTextField.inputView = datePicker
            print("date picker assigned")
            datePicker.addTarget(self, action: #selector(PostEventViewController.datePickerChanged(_:)), forControlEvents: .ValueChanged)
        }
        print("end of editing function")
        checkFieldsAreFilled()
    }
    
    
    // MARK: Date Picker
    func datePickerChanged(sender: UIDatePicker){
        let formatter = NSDateFormatter()
        formatter.timeStyle = .ShortStyle
        formatter.dateStyle = .LongStyle
        eventTimeDateTextField.text = formatter.stringFromDate(sender.date)
    }
    
    
    // MARK: Filled Text Fields
    func checkFieldsAreFilled() {
        print("Check evoked")
        if (eventNameTextField.text!.isEmpty || eventTimeDateTextField.text!.isEmpty || eventDescriptionTextField.text!.isEmpty || eventLocationTextField.text!.isEmpty){
            postEventButton.enabled = false
        }
        else if (eventNameTextField.hasText() == false || eventDescriptionTextField.hasText() == false || eventLocationTextField.hasText() == false){
            postEventButton.enabled = false
        }
        else if (eventNameTextField.text == "" || eventDescriptionTextField.text == "" || eventLocationTextField.text == ""){
            postEventButton.enabled = false
        }
        else{
            print("it thinks it's not empty")
            print(eventNameTextField.text)
            postEventButton.enabled = true
        }
    }
    
    
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        checkFieldsAreFilled()
        print("live editing!!!!")
        
        if (textField == eventNameTextField){
            
            print("eventNameTextField active")
            checkFieldsAreFilled()
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
            
            checkFieldsAreFilled()
            return NewLength <= 50
        }
        
        else if (textField == eventTimeDateTextField){
            checkFieldsAreFilled()
            let datePicker = UIDatePicker()
            datePicker.minuteInterval = 15
            eventTimeDateTextField.inputView = datePicker
            print("date picker assigned")
            datePicker.addTarget(self, action: #selector(PostEventViewController.datePickerChanged(_:)), forControlEvents: .ValueChanged)
            checkFieldsAreFilled()
            return true
        }
        
        else if (textField == eventLocationTextField){
            print("eventLocation active")
            return true
        }
            
        else {
            print("not detecting :(")
        }
        
        checkFieldsAreFilled()
        return true
    }

    
    
    // MARK: Actions
    @IBAction func dismissKeyBoardOnScroll(sender: UITapGestureRecognizer) {
        print("SCROLL VIEW TAPPED")
        checkFieldsAreFilled()
        self.view.endEditing(true)
    }
    
    
    
    
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

    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if identifier == "postEventSegue" {
            
            if (eventNameTextField.text == "" || eventDescriptionTextField.text == "" || eventLocationTextField.text == "")
            {
                postEventButton.enabled = false
                return false
                
            }
            else{
                return true
            }
        }
        return true
    }
    
 /*   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // ===  check that the object referenced by the saveButton outlet is the same object instance as sender. If it is, the if statement is executed.
        print("in prepareForSegue")
        
        if postEventButton === sender {
            
            if (eventNameTextField.text == "" || eventDescriptionTextField.text == "" || eventLocationTextField.text == "")
            {
                postEventButton.enabled = false
                
            }
            else{
                print("post success")
                let eventName = eventNameTextField.text
                //let eventLocation = eventLocationTextField.text
                let eventTimeDate = eventTimeDateTextField.text
                let eventDescription = eventDescriptionTextField.text
                //let eventDateTime = myDatePicker.date
                var eventCoverPhoto = UIImage(named:"coverPhoto-default")
                
                if photoImageView.image == UIImage(named:"upload-cover-photo")
                {
                    eventCoverPhoto = UIImage(named:"coverPhoto-default")
                }
                else{
                    eventCoverPhoto = photoImageView.image
                }
                
                // Set event
                newEvent = event(eventName: eventName, eventDateTime: eventTimeDate, eventDescription: eventDescription, eventAddress: address(), eventCategories: ["sample"], coverPhoto: eventCoverPhoto)
                
            }
        }
    }

    
    
    */

}
