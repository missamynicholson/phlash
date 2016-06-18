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
    private var goBackButton = UIButton()
    private var resetPwdButton = UIButton()
    var statusLabel = UILabel()
    
    private let defaults = NSUserDefaults.standardUserDefaults()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if PFUser.currentUser() != nil {
            performSegueWithIdentifier("toCamera", sender: nil)
        }
    
        self.view = authenticationView
        submitButton = authenticationView.submitButton
        loginButton = authenticationView.loginButton
        signupButton = authenticationView.signupButton
        usernameField = authenticationView.usernameField
        emailField = authenticationView.emailField
        passwordField = authenticationView.passwordField
        statusLabel = authenticationView.statusLabel
        goBackButton = authenticationView.goBackButton
        resetPwdButton = authenticationView.resetPwdButton
        submitButton.addTarget(self, action: #selector(buttonAction), forControlEvents: .TouchUpInside)
        loginButton.addTarget(self, action: #selector(buttonAction), forControlEvents: .TouchUpInside)
        signupButton.addTarget(self, action: #selector(buttonAction), forControlEvents: .TouchUpInside)
        goBackButton.addTarget(self, action: #selector(buttonAction), forControlEvents: .TouchUpInside)
        resetPwdButton.addTarget(self, action: #selector(buttonAction), forControlEvents: .TouchUpInside)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        authenticationView.showLoginOrSignupScreen()
    }
    
    
 /*   func buttonAction(sender: UIButton!) {
        if sender == submitButton && emailField.hidden {
            login()
        } else if sender == submitButton {
            signUp()
        } else if sender == loginButton {
            authenticationView.showLoginView()
        } else if sender == signupButton {
            authenticationView.showSignupView()
        } else if sender == goBackButton {
            authenticationView.showLoginOrSignupScreen()
        }
    }  */
    
    func buttonAction(sender: UIButton!) {
        switch (sender, emailField.hidden, passwordField.hidden) {
        case(submitButton, true, false):
            login()
        case(submitButton, false, false):
            signUp()
        case(submitButton, false, true):
            resetPwd()
        case(loginButton, _, _):
            authenticationView.showLoginView()
        case(signupButton, _, _):
            authenticationView.showSignupView()
        case(goBackButton, _, _):
            authenticationView.showLoginOrSignupScreen()
        case(resetPwdButton, _, _):
            authenticationView.showResetPwdView()
        default:
            break
        }
    }
        
    func login() {
        let username = usernameField.text
        let password = passwordField.text
        UserAuthentication().login(self, username: username!, password: password!, statusLabel: statusLabel)
    }
    
    func signUp() {
        let username = usernameField.text
        let email = emailField.text
        let password = passwordField.text
        UserAuthentication().signUp(self, username: username!, email: email!, password: password!, statusLabel: statusLabel)
    }
    
    func resetPwd() {
        let email = emailField.text
        UserAuthentication().getResetLink(email!, statusLabel: statusLabel)
        authenticationView.showLoginOrSignupScreen()
    }
    
    @IBAction func unwindToAuth(segue: UIStoryboardSegue) {
    }

}


