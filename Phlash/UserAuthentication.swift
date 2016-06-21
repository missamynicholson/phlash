//
//  UserAuthentication.swift
//  Phlash
//
//  Created by Amy Nicholson on 17/06/2016.
//  Copyright © 2016 Phlashers. All rights reserved.
//

import Parse

class UserAuthentication {
    
    func signUp(controller: UIViewController, username: String, email: String, password: String, statusLabel: UILabel) {
        
        let user = PFUser()
        user.username = username
        user.password = password
        user.email = email
        
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool, error: NSError?) -> Void in
            if let error = error {
                let errorMessage = error.userInfo["error"] as? NSString
                AlertMessage().show(statusLabel, message: "\(errorMessage)")
            } else {
                controller.performSegueWithIdentifier("toCamera", sender: nil)
                Installations().updateInstallation("p\(username)")
            }
        }
    }
    
    func login(controller: UIViewController, username: String, password: String, statusLabel: UILabel) {
        PFUser.logInWithUsernameInBackground(username, password:password) {
            (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                controller.performSegueWithIdentifier("toCamera", sender: nil)
            } else {
                let errorMessage = error!.userInfo["error"] as? NSString
                AlertMessage().show(statusLabel, message: "\(errorMessage))")
            }
        }
    }
    
    func getResetLink(email: String, statusLabel: UILabel) {
        PFUser.requestPasswordResetForEmailInBackground(email)
        AlertMessage().show(statusLabel, message: "Please check your emails")
    }
    
}

