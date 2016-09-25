//
//  BHToast_Tests.swift
//  BHToast_Tests
//
//  Created by Bruno Hecktheuer on 9/23/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import XCTest

@testable import BHToast

class BHToast_Tests: XCTestCase {
    private var toast: BHToast!
    
    private let message = "This is an example message"
    private let margin: CGFloat = 40.0
    private let width: CGFloat = 300.0
    private let minHeight: CGFloat = 40.0
    private let maxHeight: CGFloat = 60.0
    private let contentInsets = UIEdgeInsets(top: 8.0, left: 8.0, bottom: 8.0, right: 8.0)
    
    private var window: UIWindow {
        return UIApplication.sharedApplication().windows.first!
    }
    
    private var view: UIView {
        return window.rootViewController!.view
    }
    
    override func setUp() {
        super.setUp()
        
        BHToastOptions.defaultAnimationDuration = 0.1
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testView_show() {
        toast = BHToast(view: view, message: message)
        toast.show()
        
        sleep()
        
        XCTAssertTrue(view.subviews.contains(toast))
    }
    
    func testView_hide() {
        toast = BHToast(view: view, message: message)
        toast.show()
        
        sleep()
        
        XCTAssertTrue(view.subviews.contains(toast))
    }
    
    func testView_width() {
        toast = BHToast(view: view, message: message)
        toast.show()
        
        sleep()
        
        toast.hide()
        
        sleep()
        
        XCTAssertFalse(view.subviews.contains(toast))
    }
    
    func testView_height() {
        toast = BHToast(
            view: view,
            message: message,
            options: BHToastOptions(
                minHeight: minHeight,
                maxHeight: maxHeight
            )
        )
        toast.show()
        
        sleep()
        
        XCTAssertGreaterThanOrEqual(toast.frame.height, minHeight)
        XCTAssertLessThanOrEqual(toast.frame.height, maxHeight)
    }
    
    func testView_topPosition() {
        toast = BHToast(
            view: view,
            message: message,
            options: BHToastOptions(
                margin: margin,
                position: .Top
            )
        )
        toast.show()
        
        sleep()
        
        XCTAssertEqual(
            toast.frame.origin.y,
            margin
        )
    }
    
    func testView_middlePosition() {
        toast = BHToast(
            view: view,
            message: message,
            options: BHToastOptions(
                margin: margin,
                position: .Middle
            )
        )
        toast.show()
        
        sleep()
        
        XCTAssertEqual(
            toast.center,
            view.center
        )
    }
    
    func testView_bottomPosition() {
        toast = BHToast(
            view: view,
            message: message,
            options: BHToastOptions(
                margin: margin,
                position: .Bottom
            )
        )
        toast.show()
        
        sleep()
        
        XCTAssertEqual(
            view.frame.height - (toast.frame.origin.y + toast.frame.height),
            margin
        )
    }
    
    func testMessageLabel_text() {
        toast = BHToast(view: view, message: message)
        toast.show()
        
        sleep()
        
        XCTAssertEqual(toast.messageLabel.text, message)
    }
    
    func testMessageLabel_edges() {
        toast = BHToast(
            view: view,
            message: message,
            options: BHToastOptions(
                contentInsets: contentInsets
            )
        )
        toast.show()
        
        sleep()
        
        XCTAssertEqual(
            toast.messageLabel.frame.origin.y,
            contentInsets.top
        )
        
        XCTAssertEqual(
            toast.frame.height -
                (toast.messageLabel.frame.origin.y +
                    toast.messageLabel.frame.height),
            contentInsets.bottom
        )
        
        XCTAssertEqual(
            toast.messageLabel.frame.origin.y,
            contentInsets.left
        )
        
        XCTAssertEqual(
            toast.frame.width -
                (toast.messageLabel.frame.origin.x +
                    toast.messageLabel.frame.width),
            contentInsets.right
        )
    }
    
    func testImageView_height() {
        toast = BHToast(
            view: view,
            message: message,
            imageView: UIImageView(
                image: UIImage(
                    named: "SuccessIcon"
                )
            ),
            options: BHToastOptions(
                minHeight: minHeight,
                maxHeight: maxHeight,
                imagePosition: .Left
            )
        )
        toast.show()
        
        sleep()
        
        XCTAssertEqual(
            (toast.imageView!.frame.origin.y * 2) + toast.imageView!.frame.height,
            minHeight
        )
    }
    
    private func sleep(duration duration: NSTimeInterval = 0.2) {
        NSRunLoop.currentRunLoop().runUntilDate(
            NSDate().dateByAddingTimeInterval(duration)
        )
    }
    
}
