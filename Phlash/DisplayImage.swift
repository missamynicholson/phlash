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
    
    func setup(chosenImage: UIImage, cameraView: UIView, animate: Bool) {
        let startXValue = ImageViewFrame().getXValue(chosenImage)
        var endXValue = CGFloat()
        let imageView = UIImageView()
        imageView.frame = CGRect(x: screenBounds.width * 2, y: 0, width: ImageViewFrame().getNewWidth(chosenImage), height: screenBounds.height)
        cameraView.addSubview(imageView)
        imageView.image = ResizeImage().resizeImage(chosenImage, newWidth: ImageViewFrame().getNewWidth(chosenImage))
        
        if animate {
            animateIn(imageView, xValue: startXValue)
            endXValue = -self.screenBounds.width * 2
        } else {
            imageView.frame.origin.x = startXValue
            endXValue = self.screenBounds.width * 2
        }
        
        Delay().run(2.0) {
            self.animateOut(imageView, xValue: endXValue)
        }
    }
    
    func animateIn(imageView: UIImageView, xValue: CGFloat) {
        UIView.animateWithDuration(1.0, delay: 1.0, options: .CurveEaseOut, animations: {
            imageView.frame.origin.x = xValue
            }, completion: nil)
    }
    
    func animateOut(imageView: UIImageView, xValue: CGFloat) {
        UIView.animateWithDuration(1.0, delay: 1.0, options: .CurveEaseOut, animations: {
            imageView.frame.origin.x = xValue
            }, completion: { finished in
                imageView.removeFromSuperview()
        })
    }
    
}