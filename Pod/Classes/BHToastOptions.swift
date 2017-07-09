//
//  BHToastOptions.swift
//  Pods
//
//  Created by Bruno Hecktheuer on 1/12/16.
//
//

import UIKit

/**
 The BHToastViewTag is used to guarantee only one instance.

 *If necessary, change it before create the first BHToast instance*.
*/
public var BHToastViewTag = 3091990

/// Represents the view position (Bottom, Middle, Top)
public enum BHToastPosition {
    case bottom, middle, top
}

/// Represents the image position (Left or Right)
public enum BHToastImagePosition {
    case left, right
}

/// The struct of customization options.
public struct BHToastOptions {
    
    // Default properties (change if necessary)
    public static var defaultDuration: TimeInterval = 5.0
    public static var defaultAnimationDuration: TimeInterval = 0.4
    public static var defaultBackgroundColor: UIColor = .lightGray
    public static var defaultBorderColor: UIColor = .darkGray
    public static var defaultBorderWidth: CGFloat = 1.0
    public static var defaultCornerRadius: CGFloat = 5.0
    /// Only applies when the position is top or bottom.
    public static var defaultMargin: CGFloat = 8.0
    public static var defaultContentInsets = UIEdgeInsets(
        top: 8.0, left: 8.0, bottom: 8.0, right: 8.0
    )
    public static var defaultMinHeight: CGFloat = 30.0
    public static var defaultMaxHeight: CGFloat = 50.0
    public static var defaultMessageAlignment: NSTextAlignment = .center
    public static var defaultMessageColor: UIColor = .white
    public static var defaultMessageFont = UIFont.systemFont(ofSize: 14.0)
    public static var defaultPosition: BHToastPosition = .bottom
    public static var defaultImagePosition: BHToastImagePosition = .left
    
    // MARK: - Properties
    
    /// The duration that the Toast stays in View (*in seconds*).
    public let duration: TimeInterval
    
    /// The animation time (*in seconds*).
    public let animationDuration: TimeInterval
    
    /// Toast background color.
    public let backgroundColor: UIColor
    
    // Border options
    public let borderColor: UIColor
    public let cornerRadius: CGFloat
    public let borderWidth: CGFloat
    
    // View size options
    public let margin: CGFloat
    public let contentInsets: UIEdgeInsets
    public let minHeight: CGFloat
    public let maxHeight: CGFloat
    
    // Message options
    public let messageAlignment: NSTextAlignment
    public let messageColor: UIColor
    public let messageFont: UIFont
    
    // View position
    public let position: BHToastPosition
    
    // Image options
    public let imagePosition: BHToastImagePosition
    
    // MARK: - Init method
    
    /**
     Create an instance of BHToastOptions with some customizations.
    
     If necessary, change the default values to apply the customization for all new BHToastOptions instance.
     */
    public init(duration: TimeInterval = defaultDuration,
                animationDuration: TimeInterval = defaultAnimationDuration,
                backgroundColor: UIColor = defaultBackgroundColor,
                borderColor: UIColor = defaultBorderColor,
                borderWidth: CGFloat = defaultBorderWidth,
                cornerRadius: CGFloat = defaultCornerRadius,
                margin: CGFloat = defaultMargin,
                contentInsets: UIEdgeInsets = defaultContentInsets,
                minHeight: CGFloat = defaultMinHeight,
                maxHeight: CGFloat = defaultMaxHeight,
                messageAlignment: NSTextAlignment = defaultMessageAlignment,
                messageColor: UIColor = defaultMessageColor,
                messageFont: UIFont = defaultMessageFont,
                position: BHToastPosition = defaultPosition,
                imagePosition: BHToastImagePosition = defaultImagePosition) {
        
        self.duration = duration
        self.animationDuration = animationDuration
        self.backgroundColor = backgroundColor
        self.borderColor = borderColor
        self.borderWidth = borderWidth
        self.cornerRadius = cornerRadius
        self.margin = margin
        self.contentInsets = contentInsets
        self.minHeight = minHeight
        self.maxHeight = maxHeight
        self.messageAlignment = messageAlignment
        self.messageColor = messageColor
        self.messageFont = messageFont
        self.position = position
        self.imagePosition = imagePosition
    }
    
}
