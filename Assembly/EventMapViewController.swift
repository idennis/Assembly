//
//  EventMapViewController.swift
//  Assembly
//
//  Created by Dennis Hou on 13/05/2016.
//  Copyright © 2016 RMIT. All rights reserved.
//

import UIKit

class EventMapViewController: UIViewController {

    // MARK: - Properties
    var selectedEventDetails:[String:AnyObject]?
    
    @IBOutlet weak var locationName: UILabel!
    @IBOutlet weak var locationAddress: UILabel!
    
    
    // MARK: - Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadLocationDetails()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Location Labels
    func loadLocationDetails(){
        if selectedEventDetails != nil{
            if selectedEventDetails!["venue"]?["name"] != nil{
                locationName.text = (selectedEventDetails!["venue"]?["name"] as? String)!
                locationAddress.text = (selectedEventDetails!["venue"]?["address_1"] as? String)!
            }
            else{
                locationName.text = "Available to members only."
                locationAddress.text = ""
            }
        }
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
