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
    private let view: UIView!
    
    /// The animation time.
    private let animationDuration: NSTimeInterval!
    
    /// The view options
    private let options: BHToastOptions!
    
    /// The BHToast width.
    private let width: CGFloat = 300.0
    
    /// The display message.
    public var message: String
    
    // MARK: - Init methods
    
    /**
     Custom init method.
     
     Create an instance of BHToast to attach in an UIView. You should set a message to display and can change the animation duration.
     
     - parameter view:              The UIView that shows the BHToast.
     - parameter message:           The display message.
     - parameter animationDuration: The animation time.
     - parameter options:           The BHToastOptions instance.
     */
    public init(view: UIView, message: String, animationDuration: NSTimeInterval = 0.4, options: BHToastOptions = BHToastOptions()) {
        self.view = view
        self.message = message
        self.animationDuration = animationDuration
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
    
    override public func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        addWidthConstraintToElement(self, rule: "\(width)")
        addHeightConstraintToElement(self, rule: ">=\(options.minHeight)")
        addHeightConstraintToElement(self, rule: "<=\(options.maxHeight)")
        
        addAlignCenterXConstraintFrom(view, to: self)
        addBottomMarginConstraintFrom(view, to: self, value: options.bottomOffset)
        
        setupLayerProperties()
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
     Sets the message label properties.
     */
    private func setupMessageLabel() {
        let label = UILabel()
        
        label.font = options.messageFont
        
        label.numberOfLines = 0
        
        label.text = message
        label.textAlignment = .Center
        label.textColor = options.messageColor
        
        addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        addTopMarginConstraintFrom(self, to: label, value: options.messagePadding)
        addBottomMarginConstraintFrom(self, to: label, value: options.messagePadding)
        addLeftMarginConstraintFrom(self, to: label, value: options.messagePadding)
        addRightMarginConstraintFrom(self, to: label, value: options.messagePadding)
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
            animationDuration,
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
        
        /// Remove from screen if the BHToast already exists.
        if let _view = view.viewWithTag(BHToastViewTag) as? BHToast {
            _view.hide()
        }
        
        alpha = 0.0
        view.addSubview(self)
        
        UIView.animateWithDuration(
            animationDuration,
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
     Add top margin constraint.
     
     - parameter from:  AnyObject
     - parameter to:    AnyObject
     - parameter value: CGFloat
     */
    func addTopMarginConstraintFrom(from: AnyObject, to: AnyObject, value: CGFloat) {
        from.addConstraint(
            NSLayoutConstraint(
                item: to,
                attribute: .Top,
                relatedBy: .Equal,
                toItem: from,
                attribute: .Top,
                multiplier: 1,
                constant: value
            )
        )
    }
    
    /**
     Add bottom margin constraint (refers to self.view).
     
     - parameter from: AnyObject
     - parameter to: AnyObject
     - parameter value: CGFloat
     */
    func addBottomMarginConstraintFrom(from: AnyObject, to: AnyObject, value: CGFloat) {
        view.addConstraint(
            NSLayoutConstraint(
                item: from,
                attribute: .Bottom,
                relatedBy: .Equal,
                toItem: to,
                attribute: .Bottom,
                multiplier: 1,
                constant: value
            )
        )
    }
    
    /**
     Add left margin constraint.
     
     - parameter from: AnyObject
     - parameter to: AnyObject
     - parameter value: CGFloat
     */
    func addLeftMarginConstraintFrom(from: AnyObject, to: AnyObject, value: CGFloat) {
        from.addConstraint(
            NSLayoutConstraint(
                item: to,
                attribute: .Left,
                relatedBy: .Equal,
                toItem: from,
                attribute: .Left,
                multiplier: 1,
                constant: value
            )
        )
    }
    
    /**
     Add right margin constraint.
     
     - parameter from: AnyObject
     - parameter to: AnyObject
     - parameter value: CGFloat
     */
    func addRightMarginConstraintFrom(from: AnyObject, to: AnyObject, value: CGFloat) {
        from.addConstraint(
            NSLayoutConstraint(
                item: from,
                attribute: .Right,
                relatedBy: .Equal,
                toItem: to,
                attribute: .Right,
                multiplier: 1,
                constant: value
            )
        )
    }
    
    /**
     Add height constraint.
     
     - parameter element: AnyObject
     - parameter rule: String (examples: "<=200", ">300", "200")
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
     
     - parameter element: AnyObject
     - parameter rule: String (examples: "<=200", ">300", "200")
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
