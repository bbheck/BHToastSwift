//
//  BHToastOptions.swift
//  Pods
//
//  Created by Bruno Hecktheuer on 1/12/16.
//
//

import UIKit

/// The struct of customization options.
public struct BHToastOptions {
    
    public static var viewTag = 3091990
    
    /// The duration that the Toast stays in View (*in seconds*).
    public static var duration: NSTimeInterval = 5.0
    
    /// Toast background color.
    public static var backgroundColor: UIColor = UIColor.lightGrayColor()
    
    // Border options
    public static var borderColor = UIColor.darkGrayColor()
    public static var borderWidth: CGFloat = 1.0
    public static var cornerRadius: CGFloat = 5.0
    
    // View size options
    public static var minHeight: CGFloat = 30.0
    public static var maxHeight: CGFloat = 50.0
    public static var bottomOffset: CGFloat = 8.0
    
    // Message options
    public static var messagePadding: CGFloat = 8.0
    
    public static var messageFont = UIFont.systemFontOfSize(14.0)
    public static var messageColor = UIColor.whiteColor()
    
}