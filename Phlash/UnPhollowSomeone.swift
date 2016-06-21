//
//  PhollowSomeone.swift
//  Phlash
//
//  Created by serge on 20/06/2016.
//  Copyright © 2016 Phlashers. All rights reserved.
//

import Parse

class UnPhollowSomeone {
    
    let screenBounds:CGSize = UIScreen.mainScreen().bounds.size
    
    func unPhollow(toUsernameField: UITextField, phollowView: UIView, logoutButton: UIButton, phollowButton: UIButton, statusLabel: UILabel, cameraViewIdentificationLabel: UILabel) {
        
        let toUsername = toUsernameField.text!
        
        PFCloud.callFunctionInBackground("unphollow", withParameters: ["toUsername": toUsername]) {
            (response: AnyObject?, error: NSError?) -> Void in
            if error === nil {
                AlertMessage().show(statusLabel, message: "Successfully unphollowed \(toUsername)")
                PhollowViewSetup().animate(phollowView, phollowButton: phollowButton, logoutButton: logoutButton, yValue: self.screenBounds.height, appear: false, cameraViewId: cameraViewIdentificationLabel)
                Installations().removeInstallation(toUsername)
            } else {
                let message = error!.userInfo["error"] as! NSString
                AlertMessage().show(statusLabel, message: "Unsuccessfully unphollowed: \(message)")
            }
        }
    }
}