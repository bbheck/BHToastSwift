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


    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // Overridden options default values
        BHToastOptions.defaultBackgroundColor = UIColor.darkGray
        BHToastOptions.defaultMaxHeight = 70.0
        
        return true
    }
    
}
