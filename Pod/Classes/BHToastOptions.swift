//
//  BHToastOptions.swift
//  Pods
//
//  Created by Bruno Hecktheuer on 1/12/16.
//
//

import UIKit

/**
 The BHToastViewTag used to guarantee only one instance in view.

 *If necessary, change it before first BHToast instance*.
*/
public var BHToastViewTag = 3091990

/// The struct of customization options.
public struct BHToastOptions {
    
    // Default properties (change if necessary)
    public static var defaultDuration: NSTimeInterval = 5.0
    public static var defaultBackgroundColor = UIColor.lightGrayColor()
    public static var defaultBorderColor: UIColor = UIColor.darkGrayColor()
    public static var defaultBorderWidth: CGFloat = 1.0
    public static var defaultCornerRadius: CGFloat = 5.0
    public static var defaultMinHeight: CGFloat = 30.0
    public static var defaultMaxHeight: CGFloat = 50.0
    public static var defaultBottomOffset: CGFloat = 8.0
    public static var defaultMessagePadding: CGFloat = 8.0
    public static var defaultMessageFont: UIFont = UIFont.systemFontOfSize(14.0)
    public static var defaultMessageColor: UIColor = UIColor.whiteColor()
    
    // MARK: - Properties
    
    /// The duration that the Toast stays in View (*in seconds*).
    public let duration: NSTimeInterval
    
    /// Toast background color.
    public let backgroundColor: UIColor
    
    // Border options
    public let borderColor: UIColor
    public let borderWidth: CGFloat
    public let cornerRadius: CGFloat
    
    // View size options
    public let minHeight: CGFloat
    public let maxHeight: CGFloat
    public let bottomOffset: CGFloat
    
    // Message options
    public let messagePadding: CGFloat
    
    public let messageFont: UIFont
    public let messageColor: UIColor
    
    // MARK: - Init method
    
    /**
     Create an instance of BHToastOptions with some customizations.
    
     If necessary, change the default values to apply the customization to all new BHToastOptions instance.
    */
    public init(
        duration: NSTimeInterval = defaultDuration,
        backgroundColor: UIColor = defaultBackgroundColor,
        borderColor: UIColor = defaultBorderColor,
        borderWidth: CGFloat = defaultBorderWidth,
        cornerRadius: CGFloat = defaultCornerRadius,
        minHeight: CGFloat = defaultMinHeight,
        maxHeight: CGFloat = defaultMaxHeight,
        bottomOffset: CGFloat = defaultBottomOffset,
        messagePadding: CGFloat = defaultMessagePadding,
        messageFont: UIFont = defaultMessageFont,
        messageColor: UIColor = defaultMessageColor)
    {
        self.duration = duration
        self.backgroundColor = backgroundColor
        self.borderColor = borderColor
        self.borderWidth = borderWidth
        self.cornerRadius = cornerRadius
        self.minHeight = minHeight
        self.maxHeight = maxHeight
        self.bottomOffset = bottomOffset
        self.messagePadding = messagePadding
        self.messageFont = messageFont
        self.messageColor = messageColor
    }
    
}