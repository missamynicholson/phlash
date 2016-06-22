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

    func phollow(toUsernameField: UITextField, statusLabel: UILabel, phollowButton: UIButton, type: String) {
        
        let toUsername = toUsernameField.text!
        
        PFCloud.callFunctionInBackground(type, withParameters: ["toUsername": toUsername]) {
            (response: AnyObject?, error: NSError?) -> Void in
            if error === nil {
                AlertMessage().show(statusLabel, message: "Successfully \(type)ed \(toUsername)")
                Installations().addInstallation(toUsername)
                toUsernameField.text = ""
                phollowButton.userInteractionEnabled = true
            } else {
                let message = error!.userInfo["error"] as! NSString
                AlertMessage().show(statusLabel, message: "Unsuccessfully \(type)ed: \(message)")
                Installations().removeInstallation(toUsername)
                phollowButton.userInteractionEnabled = true
            }
        }
        Delay().run(5.0) {
            phollowButton.userInteractionEnabled = true
        }
    }
}