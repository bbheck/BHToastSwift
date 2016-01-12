//
//  BHToast.swift
//  Pods
//
//  Created by Bruno Hecktheuer on 1/11/16.
//
//

import UIKit

public class BHToast: UIView {
    
    private let view: UIView!
    
    /// The time duration animation
    private var animationDuration: NSTimeInterval!
    
    /// The duration that the Toast stays in View.
    private var duration: NSTimeInterval = 5.0
    
    private var timer = NSTimer()
    
    private let width: CGFloat = 300.0
    private let height: CGFloat = 80.0
    private let bottomOffset: CGFloat = 30.0
    
    private(set) var message: String
    
    public init(view: UIView, message: String, animationDuration: NSTimeInterval = 1.0) {
        self.view = view
        self.message = message
        self.animationDuration = animationDuration
        
        super.init(
            frame: CGRect(
                x: 0,
                y: view.frame.size.height - (height + bottomOffset),
                width: width,
                height: height
            )
        )
        
        translatesAutoresizingMaskIntoConstraints = false
        
        backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5)
        
        layer.cornerRadius = 5.0
        layer.masksToBounds = true
        
        layer.borderWidth = 1.0
        layer.borderColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.6).CGColor
        
        setupMessageLabel()
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        addWidthConstraintWithRule("\(width)")
        addHeightConstraintWithRule("\(height)")
        
        addAlignCenterXConstraintToElement()
        addBottomMarginConstraintToElement(bottomOffset)
    }
    
    private func setupMessageLabel() {
        let label = UILabel(
            frame: CGRect(
                x: 10,
                y: 10,
                width: width - 20,
                height: height - 20
            )
        )
        
        label.textColor = UIColor.whiteColor()
        
        label.numberOfLines = 2
        label.textAlignment = .Center
        
        label.font = UIFont.systemFontOfSize(19.0)
        label.text = message
        
        addSubview(label)
    }
    
    private func startTimer() {
        timer = NSTimer.scheduledTimerWithTimeInterval(
            duration,
            target: self,
            selector: "close",
            userInfo: nil,
            repeats: false
        )
    }
    
    func close() {
        UIView.animateWithDuration(
            1.0,
            animations: { () -> Void in
                self.alpha = 0.0
            }, completion: { (finish) -> Void in
                self.timer.invalidate()
                self.removeFromSuperview()
            }
        )
    }
    
    /**
     The show method.
    */
    public func show() {
        alpha = 0.0
        view.addSubview(self)
        
        UIView.animateWithDuration(
            animationDuration,
            animations: { () -> Void in
                self.alpha = 1.0
            }, completion: { (finish) -> Void in
                self.startTimer()
            }
        )
    }
    
    /**
     Align center X constraint
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
     Add bottom margin constraint (refers to self.view)
     
     - parameter value: CGFloat
     
     - returns: The constraint instance
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
     
     - returns: The constraint instance
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
     
     - returns: The constraint instance
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
