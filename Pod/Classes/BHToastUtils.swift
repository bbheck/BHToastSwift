//
//  BHToastUtils.swift
//  Pods
//
//  Created by Bruno Hecktheuer on 9/24/16.
//
//

import Foundation

public class BHToastUtils {
    
    public static var topViewController: UIViewController {
        var topController = UIApplication.sharedApplication().keyWindow!.rootViewController!
        while topController.presentedViewController != nil {
            topController = topController.presentedViewController!
        }
        return topController
    }
    
}
