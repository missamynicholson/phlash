//
//  UserAuthentication.swift
//  Phlash
//
//  Created by Amy Nicholson on 17/06/2016.
//  Copyright © 2016 Phlashers. All rights reserved.
//

import Parse

class UserAuthentication {
    
    func signUp(controller: UIViewController, username: String, email: String, password: String, statusLabel: UILabel, submitButton: UIButton) {
        
        submitButton.userInteractionEnabled = false
        let user = PFUser()
        user.username = username
        user.password = password
        user.email = email
        
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool, error: NSError?) -> Void in
            if let error = error {
                submitButton.userInteractionEnabled = true
                let errorMessage = error.userInfo["error"] as? NSString
                AlertMessage().show(statusLabel, message: "\(errorMessage)")
            } else {
                submitButton.userInteractionEnabled = true
                controller.performSegueWithIdentifier("toCamera", sender: nil)
                Installations().addInstallation("p\(username)")
            }
        }
        
        Delay().run(5.0) {
            submitButton.userInteractionEnabled = true
        }
        
    }
    
    func login(controller: UIViewController, username: String, password: String, statusLabel: UILabel, submitButton: UIButton) {
        
        submitButton.userInteractionEnabled = false
        
        PFUser.logInWithUsernameInBackground(username, password:password) {
            (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                submitButton.userInteractionEnabled = true
                controller.performSegueWithIdentifier("toCamera", sender: nil)
            } else {
                submitButton.userInteractionEnabled = true
                let errorMessage = error!.userInfo["error"] as? NSString
                AlertMessage().show(statusLabel, message: "\(errorMessage))")
            }
        }
        
        Delay().run(5.0) {
            submitButton.userInteractionEnabled = true
        }
        
    }
    
    func getResetLink(email: String, statusLabel: UILabel) {
        PFUser.requestPasswordResetForEmailInBackground(email)
        AlertMessage().show(statusLabel, message: "Please check your emails")
    }
    
}

