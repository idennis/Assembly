//
//  ViewController.swift
//  Assembly
//
//  Created by Dennis Hou on 15/03/2016.
//  Copyright © 2016 RMIT. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // Property referencing the label in the view
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var eventDateLabel: UILabel!
    @IBOutlet weak var eventLocationNameLabel: UILabel!
    
    // Property referencing cover photo image in the view
    //@IBOutlet weak var eventCoverPhoto: UIImageView!
    

    
    var model = Model()
    
    func loadEvent()
    {
        eventNameLabel?.text = model.getEventName()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        // This is just onLoad()
        // for testing purposes
        eventNameLabel?.text = model.getEventName()
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

