//
//  EventTableViewCell.swift
//  Assembly
//
//  Created by Dennis Hou on 31/03/2016.
//  Copyright © 2016 RMIT. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {

    //MARK: Properties
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var eventLocationLabel: UILabel!
    @IBOutlet weak var eventCoverPhoto: UIImageView!
    
    // Custom cell view container for border drawing
    @IBOutlet weak var customCellView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        // Draws border
        let border = CALayer()
        let width = CGFloat(5.0)
        border.borderColor = UIColor.init(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0).CGColor
        border.frame = CGRect(x: 0, y: customCellView.frame.size.height - width, width:  customCellView.frame.size.width, height: customCellView.frame.size.height)
        
        border.borderWidth = width
        customCellView.layer.addSublayer(border)
        customCellView.layer.masksToBounds = true
        
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
