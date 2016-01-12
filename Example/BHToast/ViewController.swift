//
//  ViewController.swift
//  BHToast
//
//  Created by Bruno Hecktheuer on 01/11/2016.
//  Copyright (c) 2016 Bruno Hecktheuer. All rights reserved.
//

import UIKit

import BHToast

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        BHToast(view: self.view, message: "Thanks for use it, you're awesome.").show()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

