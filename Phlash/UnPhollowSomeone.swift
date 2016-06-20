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
        let userValidation = PFQuery(className: "_User")
        let currentUser = PFUser.currentUser()
        let toUsername = toUsernameField.text!
        userValidation.whereKey("username", equalTo: toUsername)
        userValidation.findObjectsInBackgroundWithBlock {
            (results: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                if results!.count < 1 {
                    AlertMessage().show(statusLabel, message: "\(toUsername) does not exist")
                    toUsernameField.text = ""
                } else {
                    self.alreadyPhollowing(currentUser!, toUsername: toUsername, phollowView: phollowView, logoutButton: logoutButton, phollowButton: phollowButton, statusLabel: statusLabel, cameraViewIdentificationLabel: cameraViewIdentificationLabel)
                    
                }
            }
        }
        
    }
    
    func alreadyPhollowing(currentUser: PFUser, toUsername: String, phollowView: UIView, logoutButton: UIButton, phollowButton: UIButton, statusLabel: UILabel, cameraViewIdentificationLabel: UILabel) {
        
        let phollowValidation = PFQuery(className: "Phollow")
        phollowValidation.whereKey("fromUsername", equalTo: currentUser.username!)
        phollowValidation.whereKey("toUsername", equalTo: toUsername)
        phollowValidation.findObjectsInBackgroundWithBlock {
            (results: [PFObject]?, error: NSError?) -> Void in
            if error == nil  {
                if results!.count < 1 {
                    AlertMessage().show(statusLabel, message: "You are not following this user")
                }
                else {
                    self.removePhollowFromDatabase(toUsername, phollowView: phollowView, logoutButton: logoutButton, phollowButton: phollowButton, statusLabel: statusLabel, cameraViewIdentificationLabel: cameraViewIdentificationLabel)
                }
            }
            
        }
    }
    
    
    func removePhollowFromDatabase(toUsername: String, phollowView: UIView, logoutButton: UIButton, phollowButton: UIButton, statusLabel: UILabel, cameraViewIdentificationLabel: UILabel){
        let currentUser = PFUser.currentUser()
        guard let checkedUser = currentUser else {
            return
        }
//        let unPhollow = PFObject(className:"Phollow")
//        unPhollow["fromUsername"] = checkedUser.username
//        unPhollow["toUsername"] = toUsername
        let unPhollow = PFQuery(className:"Phollow")
        unPhollow.whereKey("fromUsername", equalTo: currentUser!.username!)
        unPhollow.whereKey("toUsername", equalTo: toUsername)
        unPhollow.findObjectsInBackgroundWithBlock {
            (results: [PFObject]?, error: NSError?) -> Void in
//            if (success) {
//                AlertMessage().show(statusLabel, message: "Successfully unphollowed \(toUsername)")
//                PhollowViewSetup().animate(phollowView, phollowButton: phollowButton, logoutButton: logoutButton, yValue: self.screenBounds.height, appear: false, cameraViewId: cameraViewIdentificationLabel)
//                Installations().updateInstallation(toUsername)
            
            if error == nil  {
                if results!.count < 1 {
                    AlertMessage().show(statusLabel, message: "You are not following this user")
                } else  {
                    results.deleteInBackgroundWithBlock {
                        (success: Bool, error: NSError?) -> Void in
                        if (success) {
                            AlertMessage().show(statusLabel, message: "Successfully unphollowed \(toUsername)")
                            PhollowViewSetup().animate(phollowView, phollowButton: phollowButton, logoutButton: logoutButton, yValue: self.screenBounds.height, appear: false, cameraViewId: cameraViewIdentificationLabel)
                            Installations().updateInstallation(toUsername)

                }
            
            
                //This will be moved into Cloud Code
                //let push = PFPush()
                //push.setChannel("p\(toUsername)")
                //push.setMessage("\(checkedUser.username) is now following you!")
                //push.sendPushInBackground()
                //This will be moved into Cloud Code
                
            } else  {
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
    }
    
}