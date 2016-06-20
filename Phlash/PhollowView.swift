//
//  PhollowView.swift
//  Phlash
//
//  Created by serge on 17/06/2016.
//  Copyright © 2016 Phlashers. All rights reserved.
//

import UIKit

class PhollowView: UIView, UITextFieldDelegate {
    
    var usernameField = UITextField()
    var submitButton = UIButton()
    var cancelButton = UIButton()
    var identificationLabel = UILabel()
    var statusLabel = UILabel()
    private let whiteColor = UIColor.whiteColor()
    private let backgroundGreen: UIColor = UIColor( red: CGFloat(62/255.0), green: CGFloat(200/255.0), blue: CGFloat(172/255.0), alpha: CGFloat(0.75))
     let FONT_SIZE = UIScreen.mainScreen().bounds.size.height/40

    
    let screenBounds: CGSize = UIScreen.mainScreen().bounds.size
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        buildPhollowView()
        addUsernameField()
        addSubmitButton()
        addCancelButton()
        addIdLabel()
        addStatusLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func buildPhollowView() {
        backgroundColor = backgroundGreen
    }
    
    func addUsernameField() {
        usernameField.frame = CGRect(x: 0, y: screenBounds.height/8, width: screenBounds.width, height: screenBounds.height/15)
        usernameField.backgroundColor = UIColor.colorWithAlphaComponent(.whiteColor())(0.5)
        usernameField.placeholder = "Username"
        usernameField.textAlignment = .Center
        usernameField.accessibilityLabel = "phollowee"
        usernameField.delegate = self
        addSubview(usernameField)
    }
    
    func addSubmitButton() {
        submitButton.frame = CGRect(x: screenBounds.width/4, y: screenBounds.height/2, width: screenBounds.width/2, height: 30)
        submitButton.setTitleColor(.whiteColor(), forState: .Normal)
        submitButton.setTitle("Submit", forState: .Normal)
        submitButton.accessibilityLabel = "pholloweesubmit"
        addSubview(submitButton)
    }
    
    func addCancelButton() {
        cancelButton.frame = CGRect(x: screenBounds.width*4/5, y: 20, width: screenBounds.width/5, height: 30)
        cancelButton.setTitleColor(.whiteColor(), forState: .Normal)
        cancelButton.setTitle("Cancel", forState: .Normal)
        cancelButton.accessibilityLabel = "cancel"
        addSubview(cancelButton)
    }
    
    func addIdLabel() {
        identificationLabel.frame = CGRect(x: 0, y: 0, width: 50, height: 20)
        identificationLabel.text = "PhollowView"
        identificationLabel.textColor = UIColor.clearColor()
        identificationLabel.userInteractionEnabled = false
        addSubview(identificationLabel)
    }
    
    func addStatusLabel() {
        statusLabel.frame = CGRect(x: 0, y: -40, width: screenBounds.width, height: 40)
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
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.endEditing(true)
        return false
    }
}