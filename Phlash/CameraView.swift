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
    let logoutButton = UIButton()
    let phollowButton = UIButton()
    let swipeRight = UISwipeGestureRecognizer()

    
    override init(frame: CGRect) {
        super.init(frame:frame)
        backgroundColor = UIColor.clearColor()
        addLogoutButton()
        addPhollowButton()
        addRightSwipe()
        //add phollow, left swipe and right swipe
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func addLogoutButton() {
        logoutButton.frame = CGRect(x: screenBounds.width*4/5, y: 20, width: screenBounds.width/5, height: 30)
        logoutButton.setTitleColor(.whiteColor(), forState: .Normal)
        logoutButton.setTitle("Logout", forState: .Normal)
        addSubview(logoutButton)
    }
    
    func addRightSwipe() {
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        addGestureRecognizer(swipeRight)
    }
    
    func addPhollowButton() {
        phollowButton.frame = CGRect(x: 0, y: 20, width: screenBounds.width/5, height: 30)
        phollowButton.setTitleColor(.whiteColor(), forState: .Normal)
        phollowButton.setTitle("Phollow", forState: .Normal)
        addSubview(phollowButton)
    }
    
    
}

