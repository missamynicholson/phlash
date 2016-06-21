//
//  ButtonShowHide.swift
//  Phlash
//
//  Created by Amy Nicholson on 17/06/2016.
//  Copyright © 2016 Phlashers. All rights reserved.
//


import UIKit

class PhollowViewSetup {
    
    func hide(cameraView: UIView) {
        cameraView.hidden = true
    }
    
    func show(cameraView: UIView) {
        cameraView.hidden = false
    }
    
    func animate(phollowView: UIView,  yValue: CGFloat, appear: Bool, cameraViewId: UILabel) {
        UIView.animateWithDuration(1.0, delay: 0.0, options: .CurveEaseOut, animations: {
            phollowView.frame.origin.y = yValue
            }, completion: { finished in
                if appear {
                    //self.hide(cameraView)
                } else {
                    phollowView.removeFromSuperview()
                    cameraViewId.text = "CameraView"
                    //self.show(cameraView)
                }
        })
    }
}
