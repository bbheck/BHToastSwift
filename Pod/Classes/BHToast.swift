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
        
        addAlignCenterXConstraintFrom(
            view,
            to: self
        )
        
        addBottomMarginConstraintFrom(
            view,
            to: self,
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
    
    private func setupImageView() {
        addSubview(imageView!)
        
        imageView!.translatesAutoresizingMaskIntoConstraints = false
        
        addAlignCenterYConstraintFrom(
            self,
            to: imageView!
        )
        
        if options.imagePosition == .Left {
            addLeftMarginConstraintFrom(
                self,
                to: imageView!,
                value: options.contentInsets.left
            )
        } else {
            addRightMarginConstraintFrom(
                self,
                to: imageView!,
                value: options.contentInsets.right
            )
        }
        
        addHeightConstraintToElement(
            imageView!,
            rule: "\(options.minHeight - ((options.contentInsets.top + options.contentInsets.bottom) / 2))"
        )
        
        addRatioConstraintToElement(
            imageView!,
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
        
        addTopMarginConstraintFrom(
            self,
            to: messageLabel,
            value: options.contentInsets.top
        )
        
        addBottomMarginConstraintFrom(
            self,
            to: messageLabel,
            value: options.contentInsets.bottom
        )
        
        if imageView == nil {
            addLeftMarginConstraintFrom(
                self,
                to: messageLabel,
                value: options.contentInsets.left
            )
            
            addRightMarginConstraintFrom(
                self,
                to: messageLabel,
                value: options.contentInsets.right
            )
        } else {
            addLeftMarginConstraintFrom(
                options.imagePosition == .Left ? imageView! : self,
                fromAttribute: options.imagePosition == .Left ? .Right : .Left,
                to: messageLabel,
                value: options.contentInsets.left
            )
            
            addRightMarginConstraintFrom(
                options.imagePosition == .Right ? imageView! : self,
                fromAttribute: options.imagePosition == .Right ? .Left : .Right,
                to: messageLabel,
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
     Align center X constraint.
     
     - parameter from:  AnyObject
     - parameter to:    AnyObject
     */
    func addAlignCenterXConstraintFrom(from: AnyObject, to: AnyObject) {
        view.addConstraint(
            NSLayoutConstraint(
                item: from,
                attribute: .CenterX,
                relatedBy: .Equal,
                toItem: to,
                attribute: .CenterX,
                multiplier: 1,
                constant: 0
            )
        )
    }
    
    /**
     Align center Y constraint.
     
     - parameter from:  AnyObject
     - parameter to:    AnyObject
     */
    func addAlignCenterYConstraintFrom(from: AnyObject, to: AnyObject) {
        view.addConstraint(
            NSLayoutConstraint(
                item: from,
                attribute: .CenterY,
                relatedBy: .Equal,
                toItem: to,
                attribute: .CenterY,
                multiplier: 1,
                constant: 0
            )
        )
    }
    
    /**
     Add top margin constraint.
     
     - parameter from:          AnyObject
     - parameter fromAttribute: NSLayoutAttribute
     - parameter to:            AnyObject
     - parameter toAttribute:   NSLayoutAttribute
     - parameter value:         CGFloat
     - parameter priority:      UILayoutPriority
     */
    func addTopMarginConstraintFrom(
        from: AnyObject,
        fromAttribute: NSLayoutAttribute = .Top,
        to: AnyObject,
        toAttribute: NSLayoutAttribute = .Top,
        value: CGFloat,
        priority: UILayoutPriority = 1000)
    {
        let constraint = NSLayoutConstraint(
            item: to,
            attribute: toAttribute,
            relatedBy: .Equal,
            toItem: from,
            attribute: fromAttribute,
            multiplier: 1,
            constant: value
        )
        
        constraint.priority = priority
        view.addConstraint(constraint)
    }
    
    /**
     Add bottom margin constraint (refers to self.view).
     
     - parameter from:          AnyObject
     - parameter fromAttribute: NSLayoutAttribute
     - parameter to:            AnyObject
     - parameter toAttribute:   NSLayoutAttribute
     - parameter value:         CGFloat
     - parameter priority:      UILayoutPriority
     */
    func addBottomMarginConstraintFrom(
        from: AnyObject,
        fromAttribute: NSLayoutAttribute = .Bottom,
        to: AnyObject,
        toAttribute: NSLayoutAttribute = .Bottom,
        value: CGFloat,
        priority: UILayoutPriority = 1000)
    {
        let constraint = NSLayoutConstraint(
            item: from,
            attribute: fromAttribute,
            relatedBy: .Equal,
            toItem: to,
            attribute: toAttribute,
            multiplier: 1,
            constant: value
        )
        
        constraint.priority = priority
        view.addConstraint(constraint)
    }
    
    /**
     Add left margin constraint.
     
     - parameter from:          AnyObject
     - parameter fromAttribute: NSLayoutAttribute
     - parameter to:            AnyObject
     - parameter toAttribute:   NSLayoutAttribute
     - parameter value:         CGFloat
     - parameter priority:      UILayoutPriority
     */
    private func addLeftMarginConstraintFrom(
        from: AnyObject,
        fromAttribute: NSLayoutAttribute = .Left,
        to: AnyObject,
        toAttribute: NSLayoutAttribute = .Left,
        value: CGFloat,
        priority: UILayoutPriority = 1000)
    {
        let constraint = NSLayoutConstraint(
            item: to,
            attribute: toAttribute,
            relatedBy: .Equal,
            toItem: from,
            attribute: fromAttribute,
            multiplier: 1,
            constant: value
        )
        
        constraint.priority = priority
        view.addConstraint(constraint)
    }
    
    /**
     Add right margin constraint.
     
     - parameter from:          AnyObject
     - parameter fromAttribute: NSLayoutAttribute
     - parameter to:            AnyObject
     - parameter toAttribute:   NSLayoutAttribute
     - parameter value:         CGFloat
     */
    private func addRightMarginConstraintFrom(
        from: AnyObject,
        fromAttribute: NSLayoutAttribute = .Right,
        to: AnyObject,
        toAttribute: NSLayoutAttribute = .Right,
        value: CGFloat)
    {
        view.addConstraint(
            NSLayoutConstraint(
                item: from,
                attribute: fromAttribute,
                relatedBy: .Equal,
                toItem: to,
                attribute: toAttribute,
                multiplier: 1,
                constant: value
            )
        )
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
    
    /**
     Add ratio constraint
     
     - parameter element:       AnyObject
     - parameter multiplier:    CGFloat
    */
    private func addRatioConstraintToElement(element: AnyObject, multiplier: CGFloat) {
        view.addConstraint(
            NSLayoutConstraint(
                item: element,
                attribute: .Height,
                relatedBy: .Equal,
                toItem: element,
                attribute: .Width,
                multiplier: multiplier,
                constant: 0
            )
        )
    }
    
}
