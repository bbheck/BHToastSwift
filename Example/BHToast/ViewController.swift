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
    
    @IBAction func showToastWithImage(sender: UIButton) {
        BHToast(
            view: view,
            message: randomMessage,
            imageView: UIImageView(
                image: UIImage(
                    named: "SuccessIcon"
                )
            ),
            options: BHToastOptions(
                minHeight: 40.0
            )
        ).show()
    }
    
    @IBAction func showToastAction(sender: UIButton) {
        BHToast(
            view: view,
            message: randomMessage
        ).show()
    }
    
    let messages: [String] = [
        "Lorem ipsum dolor sit amet, vim liber iudicabit assentior ut, mel ad aliquid omittantur.",
        "No referrentur adversarium nec.",
        "Usu ne stet autem scripta, has partem forensibus eu.",
        "Ad eos iusto mnesarchum, latine rationibus deterruisset id qui.",
        "Et eum purto malorum alienum, vim ne animal salutatus, cu blandit scaevola officiis vis.",
        "Usu augue oporteat cu, vide vitae an mel.",
        "Ad vix clita mediocritatem, nam in debet doming labitur, dicant molestie necessitatibus mei ne.",
        "Sea nisl atqui eu, sed eu iusto vitae, has ea modo voluptua dissentiet."
    ]
    
    var randomMessage: String {
        let index = Int(arc4random_uniform(UInt32(messages.count - 1)))
        return messages[index]
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

