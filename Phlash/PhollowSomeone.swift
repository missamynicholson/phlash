//
//  PhollowSomeone.swift
//  Phlash
//
//  Created by serge on 17/06/2016.
//  Copyright © 2016 Phlashers. All rights reserved.
//

import Parse

class PhollowSomeone {
    
    let screenBounds:CGSize = UIScreen.mainScreen().bounds.size
    
    func phollow(toUsername: String, phollowView: UIView, logoutButton: UIButton, phollowButton: UIButton, statusLabel: UILabel, cameraViewIdentificationLabel: UILabel) {
        let currentUser = PFUser.currentUser()
        guard let checkedUser = currentUser else {
            print ("Checked User  is nil")
            return
        }
        
        let phollow = PFObject(className:"Phollow")
        phollow["fromUsername"] = checkedUser.username
        phollow["toUsername"] = toUsername
        phollow.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                AlertMessage().show(statusLabel, message: "Successfully phollowed \(toUsername)")
                PhollowViewSetup().animate(phollowView, phollowButton: phollowButton, logoutButton: logoutButton, yValue: self.screenBounds.height, appear: false, cameraViewId: cameraViewIdentificationLabel)
            } else  {
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
    }
}