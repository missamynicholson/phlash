//
//  ResizeImage.swift
//  Phlash
//
//  Created by Admin on 17/06/2016.
//  Copyright © 2016 Phlashers. All rights reserved.
//

import UIKit

class ResizeImage {
    
    let screenBounds:CGSize = UIScreen.mainScreen().bounds.size
    
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
        
        let newSize: CGSize = CGSizeMake(newWidth, screenBounds.height)
        let rect = CGRectMake(0, 0, newSize.width, newSize.height)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.drawInRect(rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}