//
//  ImageViewFrame.swift
//  Phlash
//
//  Created by Admin on 17/06/2016.
//  Copyright © 2016 Phlashers. All rights reserved.
//

import UIKit

class ImageViewFrame {
    
    let screenBounds:CGSize = UIScreen.mainScreen().bounds.size
    
    func getXValue(image: UIImage) -> CGFloat {
        let newWidth = getNewWidth(image)
        
        return -(newWidth-screenBounds.width)/2
    }
    
    func getNewWidth(image: UIImage) -> CGFloat {
        let newWidth:CGFloat = image.size.width/(image.size.height/screenBounds.height)
        return newWidth
    }
}