//
//  CameraView.swift
//  Phlash
//
//  Created by Ollie Haydon-Mulligan on 17/06/2016.
//  Copyright © 2016 Phlashers. All rights reserved.
//

import UIKit

class CameraView: UIView, UITextFieldDelegate {
    
    private let mainScreen = UIScreen.mainScreen()
    
    private let screenBounds:CGSize = UIScreen.mainScreen().bounds.size
    var settingsButton = UIButton()
    var phollowButton = UIButton()
    var helpButton = UIButton()
    var logoutButton = UIButton()
    let flipCamera = UIButton()
    let swipeRight = UISwipeGestureRecognizer()
    let swipeLeft = UISwipeGestureRecognizer()
    let panGesture = UIPanGestureRecognizer()
    var identificationLabel = UILabel()
    var pendingPhlashesButton = UIButton()
    var captionField = UITextField()
    private let whiteColor = UIColor.whiteColor()
    var statusLabel = UILabel()
    let tap: UITapGestureRecognizer = UITapGestureRecognizer()
    let FONT_SIZE = UIScreen.mainScreen().bounds.size.height/40
    private let backgroundGreen: UIColor = UIColor( red: CGFloat(62/255.0), green: CGFloat(200/255.0), blue: CGFloat(172/255.0), alpha: CGFloat(0.75))
    let containerView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        backgroundColor = UIColor.clearColor()
        addSettingsButton()
        addFlipCamera()
        addRightSwipe()
        addLeftSwipe()
        addIdLabel()
        addCaptionField()
        addPendingPhlashesButton()
        addPhollowButton()
        addHelpButton()
        addLogoutButton()
        addGestureRecognizer(tap)
        addContainerView()
        addStatusLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func addFlipCamera() {
        flipCamera.frame = CGRect(x: screenBounds.width*4/5, y: 0, width: screenBounds.width/5, height: screenBounds.width/5)
        flipCamera.setImage(UIImage(named: "camera.png"), forState: UIControlState.Normal)
        flipCamera.accessibilityLabel = "camera"
    }
    
    func addSettingsButton() {
        settingsButton.frame = CGRect(x: 0, y: 0, width: screenBounds.width/5, height: screenBounds.width/5)
        settingsButton.setImage(UIImage(named: "cog.png"), forState: UIControlState.Normal)
        settingsButton.accessibilityLabel = "settings"
    }
    
    func addPendingPhlashesButton() {
        pendingPhlashesButton.frame = CGRect(x: screenBounds.width*2/5, y: 0, width: screenBounds.width/5, height: screenBounds.width/5)
        pendingPhlashesButton.setImage(UIImage(named: "envelope.png"), forState: UIControlState.Normal)
        pendingPhlashesButton.accessibilityLabel = "bolt"
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
        phollowButton.frame = CGRect(x: 0, y: -screenBounds.width/5, width: screenBounds.width/2, height: screenBounds.width/10)
        phollowButton.setTitleColor(.whiteColor(), forState: .Normal)
        phollowButton.setTitle(" Phollow", forState: .Normal)
        phollowButton.accessibilityLabel = "phollow"
         phollowButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
    }
    
    func addHelpButton() {
        helpButton.frame = CGRect(x: 0, y: -screenBounds.width*3/10, width: screenBounds.width/2, height: screenBounds.width/10)
        helpButton.setTitleColor(.whiteColor(), forState: .Normal)
        helpButton.setTitle(" Help", forState: .Normal)
        helpButton.accessibilityLabel = "help"
        helpButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
    }
    
    
    func addLogoutButton() {
        logoutButton.frame = CGRect(x: 0, y: -screenBounds.width*2/5, width: screenBounds.width/2, height: screenBounds.width/10)
        logoutButton.setTitleColor(.whiteColor(), forState: .Normal)
        logoutButton.setTitle(" Logout", forState: .Normal)
        logoutButton.accessibilityLabel = "logout"
        logoutButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
    }
    
    func addContainerView() {
        containerView.frame = CGRect(x: 0, y: 0, width:screenBounds.width, height:screenBounds.height)
        containerView.userInteractionEnabled = true
        containerView.addSubview(phollowButton)
        containerView.addSubview(helpButton)
        containerView.addSubview(logoutButton)
        containerView.addSubview(flipCamera)
        containerView.addSubview(pendingPhlashesButton)
        containerView.addSubview(settingsButton)
        containerView.addSubview(captionField)
        addSubview(containerView)
    }
    
    func addIdLabel() {
        identificationLabel.frame = CGRect(x: 0, y: 0, width: 50, height: 20)
        identificationLabel.text = "CameraView"
        identificationLabel.textColor = UIColor.clearColor()
        identificationLabel.userInteractionEnabled = false
        addSubview(identificationLabel)
    }
    
    func addStatusLabel() {
        statusLabel.frame = CGRect(x: 0, y: -60, width: screenBounds.width, height: 60)
        statusLabel.textColor = backgroundGreen
        statusLabel.backgroundColor = whiteColor
        statusLabel.textAlignment = .Center
        statusLabel.userInteractionEnabled = false
        statusLabel.hidden = true
        
        statusLabel.font = UIFont.systemFontOfSize(FONT_SIZE)
        statusLabel.minimumScaleFactor = 0.5
        statusLabel.adjustsFontSizeToFitWidth = true
        statusLabel.numberOfLines = 1
        addSubview(statusLabel)
    }
    
    func addCaptionField(){
        captionField.frame = CGRect(x: 0, y: screenBounds.height/3, width: screenBounds.width, height: screenBounds.height/15)
        captionField.backgroundColor = UIColor.colorWithAlphaComponent(whiteColor)(0.5)
        captionField.font = UIFont.systemFontOfSize(FONT_SIZE)
        captionField.placeholder = "Caption..."
        captionField.textAlignment = .Center
        captionField.autocorrectionType = .No
        captionField.delegate = self
        captionField.addGestureRecognizer(panGesture)
        captionField.userInteractionEnabled = true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.endEditing(true)
        return false
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let text = (textField.text! as NSString).stringByReplacingCharactersInRange(range, withString: string) as NSString
        let textSize:CGSize = text.sizeWithAttributes([NSFontAttributeName: UIFont.systemFontOfSize(FONT_SIZE)])

        return textSize.width < textField.bounds.size.width
    }
}

