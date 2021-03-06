//
//  SendPhoto.swift
//  Phlash
//
//  Created by Admin on 17/06/2016.
//  Copyright © 2016 Phlashers. All rights reserved.
//

import UIKit
import Parse


class SendPhoto {
    
    let screenBounds:CGSize = UIScreen.mainScreen().bounds.size

    
    func sendPhoto(image: UIImage, statusLabel: UILabel, captionField: UITextField){
 
        let imageData = UIImagePNGRepresentation(image)
        guard let checkedImage = imageData else {
            print ("Checked Image  is nil")
            return
        }
        let caption:String = captionField.text!
        let yValue = captionField.frame.origin.y / screenBounds.height
        captionField.text = ""
        
        PFCloud.callFunctionInBackground("phlash", withParameters: ["fileData": checkedImage, "caption": caption, "yValue": yValue]) {
            (response: AnyObject?, error: NSError?) -> Void in
            if error === nil {
                
            } else {
                AlertMessage().show(statusLabel, message: "Uh oh, phlash unsuccessful")
            }
        }
    }
}