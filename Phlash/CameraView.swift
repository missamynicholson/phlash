//
//  CameraView.swift
//  Phlash
//
//  Created by Ollie Haydon-Mulligan on 17/06/2016.
//  Copyright © 2016 Phlashers. All rights reserved.
//

import UIKit

class CameraView: UIView {
    
    private let screenBounds:CGSize = UIScreen.mainScreen().bounds.size
    var logoutButton = UIButton()
    let phollowButton = UIButton()
    let swipeRight = UISwipeGestureRecognizer()
    let swipeLeft = UISwipeGestureRecognizer()
    var identificationLabel = UILabel()
    
    var statusLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame:frame)
        backgroundColor = UIColor.clearColor()
        addLogoutButton()
        addPhollowButton()
        addRightSwipe()
        addLeftSwipe()
        addIdLabel()
        addStatusLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func addLogoutButton() {
        logoutButton.frame = CGRect(x: screenBounds.width*4/5, y: 20, width: screenBounds.width/5, height: 30)
        logoutButton.setTitleColor(.whiteColor(), forState: .Normal)
        logoutButton.setTitle("Logout", forState: .Normal)
        logoutButton.accessibilityLabel = "logout"
        addSubview(logoutButton)
    }
    
    func addRightSwipe() {
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        addGestureRecognizer(swipeRight)
    }
    
    func addLeftSwipe() {
        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
        addGestureRecognizer(swipeLeft)
    }
    
    func addPhollowButton() {
        phollowButton.frame = CGRect(x: 0, y: 20, width: screenBounds.width/5, height: 30)
        phollowButton.setTitleColor(.whiteColor(), forState: .Normal)
        phollowButton.setTitle("Phollow", forState: .Normal)
        phollowButton.accessibilityLabel = "phollow"
        addSubview(phollowButton)
    }
    
    func addIdLabel() {
        identificationLabel.frame = CGRect(x: 0, y: 0, width: 50, height: 20)
        identificationLabel.text = "PhollowView"
        identificationLabel.textColor = UIColor.clearColor()
        identificationLabel.userInteractionEnabled = false
        addSubview(identificationLabel)
    }
    
    func addStatusLabel() {
        statusLabel.frame = CGRect(x: 0, y: screenBounds.height/2, width: screenBounds.width, height: 40)
        statusLabel.textColor = UIColor.whiteColor()
        statusLabel.textAlignment = .Center
        statusLabel.userInteractionEnabled = false
        addSubview(statusLabel)
    }
}

