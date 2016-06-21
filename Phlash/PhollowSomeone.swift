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
    
    func phollow(toUsernameField: UITextField, phollowView: UIView, logoutButton: UIButton, phollowButton: UIButton, errorStatusLabel: UILabel, successStatusLabel: UILabel, cameraViewIdentificationLabel: UILabel, createPhollowButton: UIButton) {
        
        createPhollowButton.userInteractionEnabled = false
        
        let userValidation = PFQuery(className: "_User")
        let currentUser = PFUser.currentUser()
        let toUsername = toUsernameField.text!
        userValidation.whereKey("username", equalTo: toUsername)
        userValidation.findObjectsInBackgroundWithBlock {
            (results: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                if results!.count < 1 {
                    createPhollowButton.userInteractionEnabled = true
                    AlertMessage().show(errorStatusLabel, message: "\(toUsername) does not exist")
                    toUsernameField.text = ""
                } else {
                    self.alreadyPhollowing(currentUser!, toUsername: toUsername, phollowView: phollowView, logoutButton: logoutButton, phollowButton: phollowButton, errorStatusLabel: errorStatusLabel, successStatusLabel: successStatusLabel, cameraViewIdentificationLabel: cameraViewIdentificationLabel, createPhollowButton: createPhollowButton)
                }
            }
        }
        
        Delay().run(5.0) {
            createPhollowButton.userInteractionEnabled = true
        }
        
    }
    
    func alreadyPhollowing(currentUser: PFUser, toUsername: String, phollowView: UIView, logoutButton: UIButton, phollowButton: UIButton, errorStatusLabel: UILabel, successStatusLabel: UILabel, cameraViewIdentificationLabel: UILabel, createPhollowButton: UIButton) {
        
        let phollowValidation = PFQuery(className: "Phollow")
        phollowValidation.whereKey("fromUsername", equalTo: currentUser.username!)
        phollowValidation.whereKey("toUsername", equalTo: toUsername)
        phollowValidation.findObjectsInBackgroundWithBlock {
            (results: [PFObject]?, error: NSError?) -> Void in
            if error == nil  {
                if results!.count < 1 {
                    self.addPhollowToDatabase(toUsername, phollowView: phollowView, logoutButton: logoutButton, phollowButton: phollowButton, errorStatusLabel: errorStatusLabel, successStatusLabel: successStatusLabel, cameraViewIdentificationLabel: cameraViewIdentificationLabel, createPhollowButton: createPhollowButton)
                }
                else {
                    createPhollowButton.userInteractionEnabled = true
                    AlertMessage().show(errorStatusLabel, message: "already phollowing!")
                }
            }
            
        }
        
    }
    
    func addPhollowToDatabase(toUsername: String, phollowView: UIView, logoutButton: UIButton, phollowButton: UIButton, errorStatusLabel: UILabel, successStatusLabel: UILabel, cameraViewIdentificationLabel: UILabel, createPhollowButton: UIButton){
        let currentUser = PFUser.currentUser()
        guard let checkedUser = currentUser else {
            //print ("Checked User  is nil")
            return
        }
        let phollow = PFObject(className:"Phollow")
        phollow["fromUsername"] = checkedUser.username
        phollow["toUsername"] = toUsername
        phollow.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                createPhollowButton.userInteractionEnabled = true
                AlertMessage().show(successStatusLabel, message: "Successfully phollowed \(toUsername)")
                PhollowViewSetup().animate(phollowView, phollowButton: phollowButton, logoutButton: logoutButton, yValue: self.screenBounds.height, appear: false, cameraViewId: cameraViewIdentificationLabel)
                Installations().updateInstallation(toUsername)
                
                //This will be moved into Cloud Code
                //let push = PFPush()
                //push.setChannel("p\(toUsername)")
                //push.setMessage("\(checkedUser.username) is now following you!")
                //push.sendPushInBackground()
                //This will be moved into Cloud Code
                
            } else  {
                createPhollowButton.userInteractionEnabled = true
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
    }
    
}