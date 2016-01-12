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

    /// The reference of BHToastOptions.
    private let options = BHToastOptions.self
    
    /// The animation time.
    private let animationDuration: NSTimeInterval!
    
    /// The BHToast width.
    private let width: CGFloat = 300.0
    
    /// The display message.
    private(set) var message: String
    
    // MARK: - Init methods
    
    /**
     Custom init method.
     
     Create an instance of BHToast to attach in an UIView. You should set a message to display and can change the animation duration.
     
     - parameter view:              The UIView that shows the BHToast.
     - parameter message:           The display message.
     - parameter animationDuration: The animation time.
     */
    public init(view: UIView, message: String, animationDuration: NSTimeInterval = 1.0) {
        self.view = view
        self.message = message
        self.animationDuration = animationDuration
        
        super.init(
            frame: CGRect(
                x: 0,
                y: 0,
                width: width,
                height: BHToastOptions.height
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
        
        addWidthConstraintWithRule("\(width)")
        addHeightConstraintWithRule("\(BHToastOptions.height)")
        
        addAlignCenterXConstraintToElement()
        addBottomMarginConstraintToElement(options.bottomOffset)
        
        setupMessageLabel()
    }
    
    // MARK: - Setup methods
    
    /**
     Sets the view properties.
     */
    private func setupViewProperties() {
        
        tag = BHToastOptions.viewTag
        
        translatesAutoresizingMaskIntoConstraints = false
        
        backgroundColor = options.backgroundColor
        
        layer.borderWidth = options.borderWidth
        layer.borderColor = options.borderColor.CGColor
        
        layer.cornerRadius = options.cornerRadius
        
        layer.masksToBounds = true
    }
    
    /**
     Sets the message label properties.
     */
    private func setupMessageLabel() {
        // TODO: Use autolayout to setup the label frame.
        let label = UILabel(
            frame: CGRect(
                x: BHToastOptions.messagePadding,
                y: BHToastOptions.messagePadding,
                width: frame.width - (BHToastOptions.messagePadding * 2),
                height: frame.height - (BHToastOptions.messagePadding * 2)
            )
        )
        
        label.font = options.messageFont
        
        label.numberOfLines = 0
        
        label.text = message
        label.textAlignment = .Center
        label.textColor = options.messageColor
        
        addSubview(label)
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
     
     Just "fade out" the BHToast view.
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
     
     It's a "fade in" animation with the duration setted in init method.
    */
    public func show() {
        
        /// Remove from screen if the BHToast already exists.
        if let _view = view.viewWithTag(BHToastOptions.viewTag) as? BHToast {
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
    
     */
    func addAlignCenterXConstraintToElement() {
        view.addConstraint(
            NSLayoutConstraint(
                item: self,
                attribute: .CenterX,
                relatedBy: .Equal,
                toItem: view,
                attribute: .CenterX,
                multiplier: 1,
                constant: 0
            )
        )
    }
    
    /**
     Add bottom margin constraint (refers to self.view).
     
     - parameter value: CGFloat
     */
    func addBottomMarginConstraintToElement(value: CGFloat) {
        view.addConstraint(
            NSLayoutConstraint(
                item: view,
                attribute: .BottomMargin,
                relatedBy: .Equal,
                toItem: self,
                attribute: .Bottom,
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
    private func addHeightConstraintWithRule(rule: String) {
        addConstraints(
            NSLayoutConstraint.constraintsWithVisualFormat(
                "V:[element(\(rule))]",
                options: NSLayoutFormatOptions(rawValue: 0),
                metrics: nil,
                views: [
                    "element": self
                ]
            )
        )
    }
    
    /**
     Add width constraint
     
     - parameter rule: String (examples: "<=200", ">300", "200")
     */
    private func addWidthConstraintWithRule(rule: String) {
        addConstraints(
            NSLayoutConstraint.constraintsWithVisualFormat(
                "H:[element(\(rule))]",
                options: NSLayoutFormatOptions(rawValue: 0),
                metrics: nil,
                views: [
                    "element": self
                ]
            )
        )
    }
    
}
