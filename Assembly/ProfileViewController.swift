//
//  ProfileViewController.swift
//  Assembly
//
//  Created by Dennis Hou on 3/04/2016.
//  Copyright © 2016 RMIT. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    
    // MARK: - Properties
    @IBOutlet weak var profilePhoto: UIImageView!
    @IBOutlet weak var signOutButton: UIBarButtonItem!
    
    @IBOutlet weak var userFullNameLabel: UILabel!
    @IBOutlet weak var userLocationLabel: UILabel!
    
    
    
    // Model
    var model = Model.sharedInstance
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        styleProfilePhoto()
        loadUserInfo()

    }
    
    // MARK: Style
    func styleProfilePhoto(){
        profilePhoto.layer.cornerRadius =
            profilePhoto.frame.size.width / 2
        profilePhoto.clipsToBounds = true
        profilePhoto.layer.borderColor = UIColor.whiteColor().CGColor
        profilePhoto.layer.borderWidth = 2
    }

    
    // MARK: - User Information
    func loadUserInfo(){
        
        userFullNameLabel.text = model.currUser.fullName
        userLocationLabel.text = model.currUser.userLocation
        
    }
 

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    
    // MARK: - Actions
    @IBAction func signOutButtonTapped(sender: UIBarButtonItem) {
        
        
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
