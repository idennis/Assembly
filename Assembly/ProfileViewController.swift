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

        //changeNavTitle()
        styleProfilePhoto()

    }
    
    func styleProfilePhoto(){
        profilePhoto.layer.cornerRadius =
            profilePhoto.frame.size.width / 2
        profilePhoto.clipsToBounds = true
        profilePhoto.layer.borderColor = UIColor.whiteColor().CGColor
        profilePhoto.layer.borderWidth = 2

    }
    
    func changeNavTitle(){
        let titleLabel = UILabel()
        let colour = UIColor.whiteColor()
        let attributes: [String : AnyObject] = [NSFontAttributeName: UIFont.systemFontOfSize(15, weight: UIFontWeightSemibold)
            , NSForegroundColorAttributeName: colour, NSKernAttributeName : 1.2]
        titleLabel.attributedText = NSAttributedString(string: "PROFILE", attributes: attributes)
        titleLabel.sizeToFit()
        self.navigationItem.titleView = titleLabel
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
