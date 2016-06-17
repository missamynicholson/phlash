//
//  ButtonShowHide.swift
//  Phlash
//
//  Created by Amy Nicholson on 17/06/2016.
//  Copyright © 2016 Phlashers. All rights reserved.
//


import UIKit

class ButtonShowHide {
    func hide(logoutButton: UIButton, phollowButton: UIButton) {
        logoutButton.hidden = true
        phollowButton.hidden = true
    }
    
    func show(logoutButton: UIButton, phollowButton: UIButton) {
        logoutButton.hidden = false
        phollowButton.hidden = false
    }
}
