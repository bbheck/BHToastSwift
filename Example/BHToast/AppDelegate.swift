//
//  AppDelegate.swift
//  BHToast
//
//  Created by Bruno Hecktheuer on 01/11/2016.
//  Copyright (c) 2016 Bruno Hecktheuer. All rights reserved.
//

import UIKit

import BHToast

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        // Overridden options default values
        BHToastOptions.defaultBackgroundColor = UIColor.darkGrayColor()
        BHToastOptions.defaultMaxHeight = 70.0
        
        return true
    }
    
}
