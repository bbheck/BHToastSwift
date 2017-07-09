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
    
    lazy var toast = BHToast()
    
    let messages = [
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

}

// MARK: - Actions

extension ViewController {
    
    @IBAction func showToastWithImage(sender: UIButton) {
        let isSuccess = arc4random_uniform(10) % 2 == 0
        
        BHToast(
            view: view,
            message: randomMessage,
            imageView: UIImageView(
                image: UIImage(
                    named: isSuccess ? "SuccessIcon" : "ErrorIcon"
                )
            ),
            options: BHToastOptions(
                minHeight: 40.0,
                margin: 44.0,
                imagePosition: isSuccess ? .Left : .Right,
                position: .Top
            )
            ).show()
    }
    
    @IBAction func showToastAction(sender: UIButton) {
        toast.message = randomMessage
        toast.show()
    }
    
}

