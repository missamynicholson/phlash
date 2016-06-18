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
    
    func sendPhoto(image: UIImage, statusLabel: UILabel, captionField: UITextField) {
        let currentUser = PFUser.currentUser()
        let currentUsername = currentUser!.username!
        
        let imageData = UIImagePNGRepresentation(image)
        guard let checkedImage = imageData else {
            print ("Checked Image  is nil")
            return
        }
        
        let imageFile = PFFile(name:"image.png", data:checkedImage)
        let phlash = PFObject(className: "Phlash")
        phlash["file"] = imageFile
        phlash["username"] = currentUsername
        phlash["caption"] = captionField.text
        phlash.saveInBackgroundWithBlock { (succeeded, error) -> Void in
            if succeeded {
                captionField.text = ""
                AlertMessage().show(statusLabel, message: "Nice phlash!")
                //push takes place here
            } else {
                print("Error: \(error)")
            }
        }
    }
}