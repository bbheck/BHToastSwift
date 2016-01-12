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

    @IBAction func showToastAction(sender: UIButton) {
        BHToast(view: self.view, message: "[\(arc4random_uniform(20))] This is an example message.").show()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

