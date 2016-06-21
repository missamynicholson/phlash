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
    let phollowButton = UIButton()
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
    let settingsView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        backgroundColor = UIColor.clearColor()
        addSettingsButton()
        //addPhollowButton()
        addFlipCamera()
        addRightSwipe()
        addLeftSwipe()
        addIdLabel()
        addCaptionField()
        addPendingPhlashesButton()
        addSettingsView()
        addGestureRecognizer(tap)
         addStatusLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func addFlipCamera() {
        flipCamera.frame = CGRect(x: screenBounds.width*4/5, y: 0, width: screenBounds.width/5, height: screenBounds.width/5)
        //flipCamera.setImage(UIImage(named: "play.png"), forState: UIControlState.Normal)
        flipCamera.setTitle("Flip", forState: .Normal)
        addSubview(flipCamera)
    }
    
    func addSettingsButton() {
        settingsButton.frame = CGRect(x: 0, y: 0, width: screenBounds.width/5, height: screenBounds.width/5)
        //settingsCamera.setImage(UIImage(named: "play.png"), forState: UIControlState.Normal)
        settingsButton.setTitle("Settings", forState: .Normal)
        settingsButton.accessibilityLabel = "logout"
        addSubview(settingsButton)
    }
    
    func addPendingPhlashesButton() {
        pendingPhlashesButton.frame = CGRect(x: screenBounds.width*2/5, y: 0, width: screenBounds.width/5, height: screenBounds.width/5)
        //pendingPhlashesButton.setImage(UIImage(named: "play.png"), forState: UIControlState.Normal)
        pendingPhlashesButton.setTitle("Phlashes", forState: .Normal)
        pendingPhlashesButton.userInteractionEnabled = false
        addSubview(pendingPhlashesButton)
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
    
    func addSettingsView() {
        settingsView.frame = CGRect(x: 0, y: -screenBounds.width, width:screenBounds.width/5, height:screenBounds.width/2)
        let logoutButton = UIButton()
        logoutButton.setTitle("Phollow", forState: .Normal)
        logoutButton.frame = CGRect(x: 0, y: 0, width:screenBounds.width/5, height: screenBounds.width/5)
        let phollowButton = UIButton()
        phollowButton.setTitle("Logout", forState: .Normal)
        phollowButton.frame = CGRect(x: 0, y: screenBounds.width/5, width:screenBounds.width/5, height: screenBounds.width/5)
        settingsView.addSubview(logoutButton)
        settingsView.addSubview(phollowButton)
        addSubview(settingsView)
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
       
        addSubview(captionField)
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

