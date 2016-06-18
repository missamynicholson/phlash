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
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        backgroundColor = UIColor.clearColor()
        addIdLabel()
        addusernameLabel()
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
    
    func addusernameLabel() {
        // we need some clever maths here to work out the positioning of the usernameLabel below.
        usernameLabel.frame = CGRect(x: 53, y: screenBounds.height/8, width: screenBounds.width, height: screenBounds.height/15)
        usernameLabel.backgroundColor = UIColor.colorWithAlphaComponent(whiteColor)(0.5)
        usernameLabel.textColor = UIColor.blackColor()
        usernameLabel.textAlignment = .Center
        usernameLabel.userInteractionEnabled = false
        addSubview(usernameLabel)
    }
}