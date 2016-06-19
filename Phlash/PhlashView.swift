//
//  PhlashView.swift
//  Phlash
//
//  Created by Admin on 18/06/2016.
//  Copyright © 2016 Phlashers. All rights reserved.
//

import UIKit

class PhlashView: UIImageView {
    
    private let screenBounds:CGSize = UIScreen.mainScreen().bounds.size
    private let whiteColor = UIColor.whiteColor()
    var identificationLabel = UILabel()
    let usernameLabel = UILabel()
    let captionLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        backgroundColor = UIColor.clearColor()
        addIdLabel()
        addUsernameLabel()
        addCaptionLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func addIdLabel() {
        identificationLabel.frame = CGRect(x: 0, y: 0, width: 50, height: 20)
        identificationLabel.text = "PhlashView"
        identificationLabel.textColor = UIColor.clearColor()
        identificationLabel.userInteractionEnabled = false
        addSubview(identificationLabel)
    }
    
    func addUsernameLabel() {
        usernameLabel.frame = CGRect(x: 0, y: screenBounds.height/8, width: self.frame.width, height: screenBounds.height/15)
        usernameLabel.backgroundColor = UIColor.colorWithAlphaComponent(whiteColor)(0.5)
        usernameLabel.textColor = UIColor.blackColor()
        usernameLabel.textAlignment = .Center
        usernameLabel.userInteractionEnabled = false
        addSubview(usernameLabel)
    }
    
    func addCaptionLabel() {
        captionLabel.frame = CGRect(x: 0, y: screenBounds.height/5, width: self.frame.width, height: screenBounds.height/15)
        captionLabel.backgroundColor = UIColor.colorWithAlphaComponent(whiteColor)(0.5)
        captionLabel.textColor = UIColor.blackColor()
        captionLabel.textAlignment = .Center
        captionLabel.userInteractionEnabled = false
        
        captionLabel.font = UIFont.systemFontOfSize(screenBounds.height/35)
        captionLabel.minimumScaleFactor = 0.75
        captionLabel.adjustsFontSizeToFitWidth = true
        captionLabel.numberOfLines = 1
        
        addSubview(captionLabel)
    }
}