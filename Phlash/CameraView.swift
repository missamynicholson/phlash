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
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        backgroundColor = UIColor.clearColor()
        addLogoutButton()
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
    
}

