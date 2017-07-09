//
//  BHToastUtils.swift
//  Pods
//
//  Created by Bruno Hecktheuer on 9/24/16.
//
//

import Foundation

open class BHToastUtils {
    
    open static var topViewController: UIViewController {
        var topController = UIApplication.shared.keyWindow!.rootViewController!
        while topController.presentedViewController != nil {
            topController = topController.presentedViewController!
        }
        return topController
    }
    
}
