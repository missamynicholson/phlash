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
    
    func phollow(toUsernameField: UITextField, phollowView: UIView, logoutButton: UIButton, phollowButton: UIButton, statusLabel: UILabel, cameraViewIdentificationLabel: UILabel) {
        
        let toUsername = toUsernameField.text!
        
        PFCloud.callFunctionInBackground("phollow", withParameters: ["toUsername": toUsername]) {
            (response: AnyObject?, error: NSError?) -> Void in
            if error === nil {
                AlertMessage().show(statusLabel, message: "Successfully phollowed \(toUsername)")
                PhollowViewSetup().animate(phollowView, phollowButton: phollowButton, logoutButton: logoutButton, yValue: self.screenBounds.height, appear: false, cameraViewId: cameraViewIdentificationLabel)
                Installations().addInstallation(toUsername)
            } else {
                let message = error!.userInfo["error"] as! NSString
                AlertMessage().show(statusLabel, message: "Unsuccessfully phollowed: \(message)")
            }
        }
    }
}