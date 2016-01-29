//
//  BHToast.swift
//  Pods
//
//  Created by Bruno Hecktheuer on 1/11/16.
//
//

import UIKit

/// The BHToast class defines a custom UIView with a message.
@available(iOS 8.0, *)
public class BHToast: UIView {
    
    // MARK: - Properties
    
    /// The parent UIView that shows the BHToast.
    private let view: UIView
    
    /// The display message.
    public var message: String
    
    /// The display imageView (optional)
    public var imageView: UIImageView?
    
    /// The view BHToastOptions
    private let options: BHToastOptions
    
    /// The BHToast width (fixed 300.0).
    private let width: CGFloat = 300.0
    
    /// The message UILabel
    private let messageLabel = UILabel()
    
    /// The timer to hide the BHToast.
    private var timer = NSTimer()
    
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
    public init(
        view: UIView,
        message: String = "",
        imageView: UIImageView? = nil,
        options: BHToastOptions = BHToastOptions())
    {
        self.view = view
        self.message = message
        self.imageView = imageView
        self.options = options
        
        super.init(frame: CGRectZero)
        
        setupViewProperties()
    }

    @available(*, unavailable, message="required init is unavailable")
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup methods
    
    /**
     Configures view constraints and calls the other setup methods.
    */
    private func setupProperties() {
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
    
    /**
     Sets the view properties.
    */
    private func setupViewProperties() {
        tag = BHToastViewTag
        
        alpha = 0.0
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
     Sets the UIImageView properties.
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
    
    // MARK: - Scheduled method
    
    /**
     Starts the timer that hide the BHToast.
     */
    private func scheduledHideEvent() {
        timer = NSTimer.scheduledTimerWithTimeInterval(
            options.duration,
            target: self,
            selector: "hide",
            userInfo: nil,
            repeats: false
        )
    }
    
    // MARK: - Private show method
    
    /**
     Shows the view with animation.
     */
    private func showWithAnimation() {
        view.addSubview(self)
        
        setupProperties()
        
        UIView.animateWithDuration(
            options.animationDuration,
            animations: { () -> Void in
                self.alpha = 1.0
            }, completion: { (finish) -> Void in
                self.scheduledHideEvent()
            }
        )
    }
    
    // MARK: - Private hide method
    
    /**
     Hides the view with animation.

     - parameter showAgain: The flag that checks if is necessary to show again the view.
     */
    private func hideWithAnimation(completionHandler completionHandler: () -> Void = {}) {
        UIView.animateWithDuration(
            options.animationDuration,
            animations: { () -> Void in
                self.alpha = 0.0
            }, completion: { (finish) -> Void in
                self.removeFromSuperview()
                self.timer.invalidate()
                completionHandler()
            }
        )
    }
    
    // MARK: - Public methods
    
    /**
     Hides the BHToast with fade animation.
     */
    public func hide() {
        hideWithAnimation()
    }
    
    /**
     Shows the BHToast with animation.
     
     * If BHToast has already been added to parent view, dismiss the BHToast to show again.
     * If some BHToast with BHToastViewTag already exists in parent view, dismiss it to show the new BHToast.
     * Otherwise, just show the BHToast with fade animation.
     */
    public func show() {
        if isDescendantOfView(view) {
            hideWithAnimation(completionHandler: { () -> Void in
                self.showWithAnimation()
            })
        } else if let _view = view.viewWithTag(BHToastViewTag) as? BHToast {
            _view.hideWithAnimation(completionHandler: { () -> Void in
                self.showWithAnimation()
            })
        } else {
            showWithAnimation()
        }
    }
    
    // MARK: - Constraint methods
    
    /**
     Generic method to add a constraint.

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
