//
//  AuthenticationViewController.swift
//  Phlash
//
//  Created by Amy Nicholson on 17/06/2016.
//  Copyright © 2016 Phlashers. All rights reserved.
//

import Foundation
import UIKit
import Parse

class AuthenticationViewController: UIViewController {
    
    private let authenticationView = AuthenticationView()
    
    private var usernameField = UITextField()
    private var emailField = UITextField()
    private var passwordField = UITextField()
    private var submitButton = UIButton()
    private var loginButton = UIButton()
    private var signupButton = UIButton()
    
    private let defaults = NSUserDefaults.standardUserDefaults()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if PFUser.currentUser() != nil {
            print("user signed in already")
            //segue to camera
        }
        self.view = authenticationView
        submitButton = authenticationView.submitButton
        loginButton = authenticationView.loginButton
        signupButton = authenticationView.signupButton
        usernameField = authenticationView.usernameField
        emailField = authenticationView.emailField
        passwordField = authenticationView.passwordField
        submitButton.addTarget(self, action: #selector(buttonAction), forControlEvents: .TouchUpInside)
        loginButton.addTarget(self, action: #selector(buttonAction), forControlEvents: .TouchUpInside)
        signupButton.addTarget(self, action: #selector(buttonAction), forControlEvents: .TouchUpInside)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        authenticationView.showLoginOrSignupScreen()
    }
    
    
    func buttonAction(sender: UIButton!) {
        if sender == submitButton && emailField.hidden {
            login()
        } else if sender == submitButton {
            signUp()
        } else if sender == loginButton {
            authenticationView.showLoginView()
        } else if sender == signupButton {
            authenticationView.showSignupView()
        }
    }
    
    func login() {
        let username = usernameField.text
        let password = passwordField.text
        UserAuthentication().login(self, username: username!, password: password!)
    }
    
    func signUp() {
        let username = usernameField.text
        let email = emailField.text
        let password = passwordField.text
        UserAuthentication().signUp(self, username: username!, email: email!, password: password!)
    }
    
    func reset() {
        let email = emailField.text
        UserAuthentication().getResetLink(email!)
    }

}


