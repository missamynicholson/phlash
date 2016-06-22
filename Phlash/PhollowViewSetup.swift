//
//  ButtonShowHide.swift
//  Phlash
//
//  Created by Amy Nicholson on 17/06/2016.
//  Copyright © 2016 Phlashers. All rights reserved.
//


import UIKit

class PhollowViewSetup {
    
    func animate(phollowView: UIView,  yValue: CGFloat, appear: Bool, cameraViewId: UILabel) {
        UIView.animateWithDuration(1.0, delay: 0.0, options: .CurveEaseOut, animations: {
            phollowView.frame.origin.y = yValue
            }, completion: { finished in
                if !appear {
                    phollowView.removeFromSuperview()
                    cameraViewId.text = "CameraView"
                }
        })
    }
}
