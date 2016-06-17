//
//  ButtonShowHide.swift
//  Phlash
//
//  Created by Amy Nicholson on 17/06/2016.
//  Copyright © 2016 Phlashers. All rights reserved.
//


import UIKit

class PhollowViewSetup {
    
    func hide(logoutButton: UIButton, phollowButton: UIButton) {
        logoutButton.hidden = true
        phollowButton.hidden = true
    }
    
    func show(logoutButton: UIButton, phollowButton: UIButton) {
        logoutButton.hidden = false
        phollowButton.hidden = false
    }
    
    func animate(phollowView: UIView, phollowButton: UIButton, logoutButton: UIButton, yValue: CGFloat, appear: Bool) {
        UIView.animateWithDuration(1.0, delay: 0.0, options: .CurveEaseOut, animations: {
            phollowView.frame.origin.y = yValue
            }, completion: { finished in
                if appear {
                    self.hide(logoutButton, phollowButton: phollowButton)
                } else {
                    phollowView.removeFromSuperview()
                    self.show(logoutButton, phollowButton: phollowButton)
                }
        })
    }
}
