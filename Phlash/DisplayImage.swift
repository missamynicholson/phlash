//
//  DisplayImage.swift
//  Phlash
//
//  Created by Admin on 17/06/2016.
//  Copyright © 2016 Phlashers. All rights reserved.
//

import UIKit

class DisplayImage {
    
    let screenBounds:CGSize = UIScreen.mainScreen().bounds.size
    
    func setup(chosenImage: UIImage, cameraView: UIView, animate: Bool, username: String) {
        let startXValue = ImageViewFrame().getXValue(chosenImage)
        var endXValue = CGFloat()
        let phlashView = PhlashView(frame: CGRect(x: screenBounds.width * 2, y: 0, width: ImageViewFrame().getNewWidth(chosenImage), height: screenBounds.height))
        phlashView.image = ResizeImage().resizeImage(chosenImage, newWidth: ImageViewFrame().getNewWidth(chosenImage))
        cameraView.addSubview(phlashView)
        
        if animate {
            phlashView.usernameLabel.text = username
            animateIn(phlashView, xValue: startXValue)
            endXValue = -self.screenBounds.width * 2
        } else {
            phlashView.usernameLabel.hidden = true
            phlashView.frame.origin.x = startXValue
            endXValue = self.screenBounds.width * 2
        }
        
        Delay().run(2.0) {
            self.animateOut(phlashView, xValue: endXValue)
        }
    }
    
    func animateIn(phlashView: UIImageView, xValue: CGFloat) {
        UIView.animateWithDuration(1.0, delay: 1.0, options: .CurveEaseOut, animations: {
            phlashView.frame.origin.x = xValue
            }, completion: nil)
    }
    
    func animateOut(phlashView: UIImageView, xValue: CGFloat) {
        UIView.animateWithDuration(1.0, delay: 1.0, options: .CurveEaseOut, animations: {
            phlashView.frame.origin.x = xValue
            }, completion: { finished in
                phlashView.removeFromSuperview()
        })
    }
    
}