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
    
    func phollow(toUsernameField: UITextField, statusLabel: UILabel, createPhollowButton: UIButton) {
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
                    AlertMessage().show(statusLabel, message: "\(toUsername) does not exist")
                    toUsernameField.text = ""
                } else {
                    self.alreadyPhollowing(currentUser!, toUsernameField: toUsernameField, statusLabel: statusLabel, createPhollowButton: createPhollowButton)
                }
            }
        }
        
        Delay().run(5.0) {
            createPhollowButton.userInteractionEnabled = true
        }
        
    }
    
    func alreadyPhollowing(currentUser: PFUser, toUsernameField: UITextField, statusLabel: UILabel, createPhollowButton: UIButton) {
        let phollowValidation = PFQuery(className: "Phollow")
        let toUsername = toUsernameField.text!
        phollowValidation.whereKey("fromUsername", equalTo: currentUser.username!)
        phollowValidation.whereKey("toUsername", equalTo: toUsernameField.text!)
        phollowValidation.findObjectsInBackgroundWithBlock {
            (results: [PFObject]?, error: NSError?) -> Void in
            if error == nil  {
                if results!.count < 1 {
                    self.addPhollowToDatabase(toUsernameField, statusLabel: statusLabel, createPhollowButton: createPhollowButton)
                }
                else {
                    createPhollowButton.userInteractionEnabled = true
                    AlertMessage().show(statusLabel, message: "Already phollowing \(toUsername)!")
                }
            }
        }
        
    }
    
    func addPhollowToDatabase(toUsernameField: UITextField, statusLabel: UILabel, createPhollowButton: UIButton) {
        let toUsername = toUsernameField.text!
        let currentUser = PFUser.currentUser()
        guard let checkedUser = currentUser else {
            //print ("Checked User  is nil")
            return
        }
        let phollow = PFObject(className:"Phollow")
        phollow["fromUsername"] = checkedUser.username
        phollow["toUsername"] = toUsernameField.text
        phollow.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                AlertMessage().show(statusLabel, message: "Successfully phollowed \(toUsername)")
                Installations().updateInstallation(toUsernameField.text!)
                toUsernameField.text = ""
                createPhollowButton.userInteractionEnabled = true

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