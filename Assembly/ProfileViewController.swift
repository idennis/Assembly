//
//  ProfileViewController.swift
//  Assembly
//
//  Created by Dennis Hou on 3/04/2016.
//  Copyright © 2016 RMIT. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var profilePhoto: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        profilePhoto.layer.cornerRadius =
            profilePhoto.frame.size.width / 2
        profilePhoto.clipsToBounds = true
        profilePhoto.layer.borderColor = UIColor.whiteColor().CGColor
        profilePhoto.layer.borderWidth = 2

    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
