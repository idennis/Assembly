//
//  ViewController.swift
//  Assembly
//
//  Created by Dennis Hou on 15/03/2016.
//  Copyright © 2016 RMIT. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    // MARK: Properties
    //var events = [Event]()

    
    
    

    func loadEvent()
    {

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var myModel: Model?
        myModel = Model()
        print(myModel)
//        print(myModel?.events[0])
//        print(myModel?.events[1])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

