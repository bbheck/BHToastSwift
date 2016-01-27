//
//  BHToast.swift
//  Pods
//
//  Created by Bruno Hecktheuer on 1/11/16.
//
//

import UIKit

/// The BHToast class defines a custom UIView with a message.
public class BHToast: UIView {
    
    // MARK: - Properties
    
    /// The parent UIView that shows the BHToast.
    private let view: UIView
    
    /// The display message.
    private var message: String
    
    /// The display imageView (optional)
    private var imageView: UIImageView?
    
    /// The view options
    private let options: BHToastOptions
    
    /// The BHToast width.
    private let width: CGFloat = 300.0
    
    private let messageLabel = UILabel()
    
    // MARK: - Init methods
    
    /**
     Custom init method.
     
     Create an instance of BHToast to attach in an UIView.
     You should set a message and can add an image view to display.
     
     - parameter view:              The UIView that shows the BHToast.
     - parameter message:           The display message.
     - parameter imageView:         The display image view.
     - parameter options:           The BHToastOptions instance.
     */
    public init(view: UIView, message: String, imageView: UIImageView? = nil, options: BHToastOptions = BHToastOptions()) {
        self.view = view
        self.message = message
        self.imageView = imageView
        self.options = options
        
        super.init(
            frame: CGRect(
                x: 0.0,
                y: 0.0,
                width: width,
                height: options.minHeight
            )
        )
        
        setupViewProperties()
    }

    @available(*, unavailable, message="required init is unavailable")
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override method
    
    public override func drawRect(rect: CGRect) {
        
        addWidthConstraintToElement(
            self,
            rule: "\(width)"
        )
        
        addHeightConstraintToElement(
            self,
            rule: ">=\(options.minHeight)"
        )
        
        addHeightConstraintToElement(
            self,
            rule: "<=\(options.maxHeight)"
        )
        
        addConstraintFrom( // Align Center X
            view,
            fromAttribute: .CenterX,
            to: self,
            toAttribute: .CenterX
        )
        
        addConstraintFrom( // Bottom Margin
            view,
            fromAttribute: .Bottom,
            to: self,
            toAttribute: .Bottom,
            value: options.bottomOffset
        )
        
        setupLayerProperties()
        if imageView != nil { setupImageView() }
        setupMessageLabel()
    }
    
    // MARK: - Setup methods
    
    /**
     Sets the view properties.
     */
    private func setupViewProperties() {
        tag = BHToastViewTag
        
        backgroundColor = options.backgroundColor
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    /**
     Sets the layer properties.
     */
    private func setupLayerProperties() {
        layer.borderWidth = options.borderWidth
        layer.borderColor = options.borderColor.CGColor
        
        layer.cornerRadius = options.cornerRadius
        
        layer.masksToBounds = true
    }
    
    /**
     Sets the UIImageView properties
    */
    private func setupImageView() {
        addSubview(imageView!)
        
        imageView!.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraintFrom( // Align Center Y
            self,
            fromAttribute: .CenterY,
            to: imageView!,
            toAttribute: .CenterY
        )
        
        if options.imagePosition == .Left {
            addConstraintFrom( // Left Margin
                imageView!,
                fromAttribute: .Left,
                to: self,
                toAttribute: .Left,
                value: options.contentInsets.left
            )
        } else {
            addConstraintFrom( // Right Margin
                self,
                fromAttribute: .Right,
                to: imageView!,
                toAttribute: .Right,
                value: options.contentInsets.right
            )
        }
        
        addHeightConstraintToElement(
            imageView!,
            rule: "\(options.minHeight - ((options.contentInsets.top + options.contentInsets.bottom) / 2))"
        )
        
        addConstraintFrom( // Ratio Constraint
            imageView!,
            fromAttribute: .Height,
            to: imageView!,
            toAttribute: .Width,
            multiplier: imageView!.frame.height / imageView!.frame.width
        )
    
    }
    
    /**
     Sets the message label properties.
     */
    private func setupMessageLabel() {
        messageLabel.font = options.messageFont
        
        messageLabel.numberOfLines = 0
        
        messageLabel.text = message
        messageLabel.textAlignment = options.messageAlignment
        messageLabel.textColor = options.messageColor
        
        addSubview(messageLabel)
        
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraintFrom( // Top Margin
            messageLabel,
            fromAttribute: .Top,
            to: self,
            toAttribute: .Top,
            value: options.contentInsets.top
        )
        
        addConstraintFrom( // Bottom Margin
            self,
            fromAttribute: .Bottom,
            to: messageLabel,
            toAttribute: .Bottom,
            value: options.contentInsets.bottom
        )
        
        if imageView == nil {
            addConstraintFrom( // Left Margin
                messageLabel,
                fromAttribute: .Left,
                to: self,
                toAttribute: .Left,
                value: options.contentInsets.left
            )
            
            addConstraintFrom( // Right Margin
                self,
                fromAttribute: .Right,
                to: messageLabel,
                toAttribute: .Right,
                value: options.contentInsets.right
            )
        } else {
            addConstraintFrom( // Left Margin
                messageLabel,
                fromAttribute: .Left,
                to: options.imagePosition == .Left ? imageView! : self,
                toAttribute: options.imagePosition == .Left ? .Right : .Left,
                value: options.contentInsets.left
            )
            
            addConstraintFrom( // Right Margin
                options.imagePosition == .Right ? imageView! : self,
                fromAttribute: options.imagePosition == .Right ? .Left : .Right,
                to: messageLabel,
                toAttribute: .Right,
                value: options.contentInsets.right
            )
        }
        
    }
    
    // MARK: - Event method
    
    private func dispatchHideEvent() {
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(options.duration * Double(NSEC_PER_SEC)))
        dispatch_after(time, dispatch_get_main_queue(), { () -> Void in
            self.hide()
        })
    }
    
    // MARK: - Public methods
    
    /**
     Hide action.
    */
    public func hide() {
        UIView.animateWithDuration(
            options.animationDuration,
            animations: { () -> Void in
                self.alpha = 0.0
            }, completion: { (finish) -> Void in
                self.removeFromSuperview()
            }
        )
    }
    
    /**
     The show method.
    */
    public func show() {
        // Remove from screen if the BHToast already exists.
        if let _view = view.viewWithTag(BHToastViewTag) as? BHToast {
            _view.hide()
        }
        
        alpha = 0.0
        view.addSubview(self)
        
        UIView.animateWithDuration(
            options.animationDuration,
            animations: { () -> Void in
                self.alpha = 1.0
            }, completion: { (finish) -> Void in
                self.dispatchHideEvent()
            }
        )
    }
    
    // MARK: - Constraint methods
    
    /**
     Generic method to add constraint to item.
    
     - parameter: from:             The "from" AnyObject.
     - parameter: fromAttribute:    The "from" NSLayoutAttribute.
     - parameter: relatedBy:        The NSLayoutRelation (default: .Equal)
     - parameter: to:               The "to" AnyObject.
     - parameter: toAttribute:      The "to" NSLayoutAttribute.
     - parameter: multiplier:       The multiplier to change the value (default: 1.0)
     - parameter: value:            The value set in the constraint (default: 0.0).
     - parameter: priority:         The constraint priority (default: 1000).
    */
    private func addConstraintFrom(
        from: AnyObject,
        fromAttribute: NSLayoutAttribute,
        relatedBy: NSLayoutRelation = .Equal,
        to: AnyObject,
        toAttribute: NSLayoutAttribute,
        multiplier: CGFloat = 1.0,
        value: CGFloat = 0.0,
        priority: UILayoutPriority = 1000)
    {
        let constraint = NSLayoutConstraint(
            item: from,
            attribute: fromAttribute,
            relatedBy: relatedBy,
            toItem: to,
            attribute: toAttribute,
            multiplier: multiplier,
            constant: value
        )
        
        constraint.priority = priority
        view.addConstraint(constraint)
    }
    
    /**
     Add height constraint.
     
     - parameter element:   AnyObject
     - parameter rule:      String (examples: "<=200", ">300", "200")
     */
    private func addHeightConstraintToElement(element: AnyObject, rule: String) {
        element.addConstraints(
            NSLayoutConstraint.constraintsWithVisualFormat(
                "V:[element(\(rule))]",
                options: NSLayoutFormatOptions(rawValue: 0),
                metrics: nil,
                views: [
                    "element": element
                ]
            )
        )
    }
    
    /**
     Add width constraint
     
     - parameter element:   AnyObject
     - parameter rule:      String (examples: "<=200", ">300", "200")
     */
    private func addWidthConstraintToElement(element: AnyObject, rule: String) {
        element.addConstraints(
            NSLayoutConstraint.constraintsWithVisualFormat(
                "H:[element(\(rule))]",
                options: NSLayoutFormatOptions(rawValue: 0),
                metrics: nil,
                views: [
                    "element": element
                ]
            )
        )
    }
    
}
