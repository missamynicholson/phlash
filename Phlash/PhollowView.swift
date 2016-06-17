//
//  PhollowView.swift
//  Phlash
//
//  Created by serge on 17/06/2016.
//  Copyright © 2016 Phlashers. All rights reserved.
//

import UIKit

class PhollowView: UIView {
    
    var usernameField = UITextField()
    var submitButton = UIButton()
    var cancelButton = UIButton()
    
    let screenBounds: CGSize = UIScreen.mainScreen().bounds.size
    let backgroundGreen: UIColor = UIColor( red: CGFloat(62/255.0), green: CGFloat(200/255.0), blue: CGFloat(172/255.0), alpha: CGFloat(0.75))
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        buildPhollowView()
        addUsernameField()
        addSubmitButton()
        addCancelButton()
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
        addSubview(usernameField)
    }
    
    func addSubmitButton() {
        submitButton.frame = CGRect(x: screenBounds.width/4, y: screenBounds.height/2, width: screenBounds.width/2, height: 30)
        submitButton.setTitleColor(.whiteColor(), forState: .Normal)
        submitButton.setTitle("Submit", forState: .Normal)
        addSubview(submitButton)
    }
    
    func addCancelButton() {
        cancelButton.frame = CGRect(x: screenBounds.width*4/5, y: 20, width: screenBounds.width/5, height: 30)
        cancelButton.setTitleColor(.whiteColor(), forState: .Normal)
        cancelButton.setTitle("Cancel", forState: .Normal)
        addSubview(cancelButton)
    }
}