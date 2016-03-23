//
//  ViewController.swift
//  Assembly
//
//  Created by Dennis Hou on 15/03/2016.
//  Copyright © 2016 RMIT. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    


    func loadEvent()
    {

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var myModel: Model?
        myModel = Model()
        print(myModel?.events[0])

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

