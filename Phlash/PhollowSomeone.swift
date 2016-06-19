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
        let userValidation = PFQuery(className: "_User")
        let toUsername = toUsernameField.text!
        print(toUsername)
        userValidation.whereKey("username", equalTo: toUsername)
        userValidation.findObjectsInBackgroundWithBlock {
            (results: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                if results!.count < 1 {
                    AlertMessage().show(statusLabel, message: "\(toUsername) does not exist")
                    toUsernameField.text = ""
                } else {
                    self.addPhollowToDatabase(toUsername, phollowView: phollowView, logoutButton: logoutButton, phollowButton: phollowButton, statusLabel: statusLabel, cameraViewIdentificationLabel: cameraViewIdentificationLabel)
                }
            }
        }
    }

    func addPhollowToDatabase(toUsername: String, phollowView: UIView, logoutButton: UIButton, phollowButton: UIButton, statusLabel: UILabel, cameraViewIdentificationLabel: UILabel){
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
                Installations().updateInstallation(toUsername)
                
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