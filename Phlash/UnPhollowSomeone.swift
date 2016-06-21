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
    
    func unPhollow(toUsernameField: UITextField, phollowView: UIView, logoutButton: UIButton, phollowButton: UIButton, errorStatusLabel: UILabel, successStatusLabel: UILabel, cameraViewIdentificationLabel: UILabel, destroyPhollowButton: UIButton) {
        
        destroyPhollowButton.userInteractionEnabled = false
        
        let userValidation = PFQuery(className: "_User")
        let currentUser = PFUser.currentUser()
        let toUsername = toUsernameField.text!
        userValidation.whereKey("username", equalTo: toUsername)
        userValidation.findObjectsInBackgroundWithBlock {
            (results: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                if results!.count < 1 {
                    destroyPhollowButton.userInteractionEnabled = true
                    AlertMessage().show(errorStatusLabel, message: "\(toUsername) does not exist")
                    toUsernameField.text = ""
                } else {
                    self.alreadyPhollowing(currentUser!, toUsername: toUsername, phollowView: phollowView, logoutButton: logoutButton, phollowButton: phollowButton, errorStatusLabel: errorStatusLabel, successStatusLabel: successStatusLabel, cameraViewIdentificationLabel: cameraViewIdentificationLabel, destroyPhollowButton: destroyPhollowButton)
                    
                }
            }
        }
        
        Delay().run(5.0) {
            destroyPhollowButton.userInteractionEnabled = true
        }
        
    }
    
    func alreadyPhollowing(currentUser: PFUser, toUsername: String, phollowView: UIView, logoutButton: UIButton, phollowButton: UIButton, errorStatusLabel: UILabel, successStatusLabel: UILabel, cameraViewIdentificationLabel: UILabel, destroyPhollowButton: UIButton) {
        
        let phollowValidation = PFQuery(className: "Phollow")
        phollowValidation.whereKey("fromUsername", equalTo: currentUser.username!)
        phollowValidation.whereKey("toUsername", equalTo: toUsername)
        phollowValidation.findObjectsInBackgroundWithBlock {
            (results: [PFObject]?, error: NSError?) -> Void in
            if error == nil  {
                if results!.count < 1 {
                    destroyPhollowButton.userInteractionEnabled = true
                    AlertMessage().show(errorStatusLabel, message: "You are not following \(toUsername)")
                }
                else {
                    self.removePhollowFromDatabase(toUsername, phollowView: phollowView, logoutButton: logoutButton, phollowButton: phollowButton, errorStatusLabel: errorStatusLabel, successStatusLabel: successStatusLabel, cameraViewIdentificationLabel: cameraViewIdentificationLabel, destroyPhollowButton: destroyPhollowButton)
                }
            }
            
        }
    }
    
    func removePhollowFromDatabase(toUsername: String, phollowView: UIView, logoutButton: UIButton, phollowButton: UIButton, errorStatusLabel: UILabel, successStatusLabel: UILabel, cameraViewIdentificationLabel: UILabel, destroyPhollowButton: UIButton){
        let currentUser = PFUser.currentUser()
        let unPhollow = PFQuery(className:"Phollow")
        unPhollow.whereKey("fromUsername", equalTo: currentUser!.username!)
        unPhollow.whereKey("toUsername", equalTo: toUsername)
        unPhollow.getFirstObjectInBackgroundWithBlock {
            (object: PFObject?, error: NSError?) -> Void in
            if error != nil || object == nil  {
                destroyPhollowButton.userInteractionEnabled = true
                AlertMessage().show(errorStatusLabel, message: "You are not following \(toUsername)")
            } else  {
                object!.deleteInBackgroundWithBlock {
                    (success: Bool, error: NSError?) -> Void in
                    if (success) {
                        destroyPhollowButton.userInteractionEnabled = true
                        AlertMessage().show(successStatusLabel, message: "You are now unfollowing \(toUsername)")
                        PhollowViewSetup().animate(phollowView, phollowButton: phollowButton, logoutButton: logoutButton, yValue: self.screenBounds.height, appear: false, cameraViewId: cameraViewIdentificationLabel)
                    } else {
                        destroyPhollowButton.userInteractionEnabled = true
                        print("Error: \(error!) \(error!.userInfo)")
                    }
                }
            }
        }
    }
    
}