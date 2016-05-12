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
    @IBOutlet weak var dateContainerView: UIView!
    
    @IBOutlet weak var eventDayLabel: UILabel!
    @IBOutlet weak var eventDateLabel: UILabel!
    
    
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
        
        
        drawBorderOnDateContainer()

        
    }

    
    func drawBorderOnDateContainer(){
        // Draws date view border
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.init(red: 100/255, green: 100/255, blue: 100/255, alpha: 0.5).CGColor
        border.frame = CGRectMake(0, 0, 1, dateContainerView.frame.size.height)
        border.borderWidth = width
        dateContainerView.layer.addSublayer(border)
        
        
    }
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
