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

extension String {
    
    var isNotAlphanumeric: Bool {
        return rangeOfString("^[a-z0-9]+$", options: .RegularExpressionSearch) != nil
    }
    
    func containsUpperCaseLetter() -> Bool {
        let beginCodePoint = Character("A").unicodeScalarCodePoint()
        let endCodePoint = Character("Z").unicodeScalarCodePoint()
        
        for scalar in self.unicodeScalars {
            if case beginCodePoint...endCodePoint = scalar.value  {
                return true
            }
        }
        return false
    }
}

extension Character {
    func unicodeScalarCodePoint() -> UInt32 {
        let characterString = String(self)
        let scalars = characterString.unicodeScalars
        
        return scalars[scalars.startIndex].value
    }
}

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
            clearTextFields()  // if goback button does not remove previous data, then remove this line
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
        if isInvalidInput(username!, password: password!) {
            AlertMessage().show(statusLabel, message: "error: please review your input")
            return
        }
        UserAuthentication().login(self, username: username!, password: password!, statusLabel: statusLabel)
        clearTextFields()
    }
    
    func signUp() {
        let username = usernameField.text
        let email = emailField.text
        let password = passwordField.text
        if isInvalidInput(username!, email: email!, password: password!) {
            AlertMessage().show(statusLabel, message: "error: please review your input")
            return
        }
        UserAuthentication().signUp(self, username: username!, email: email!, password: password!, statusLabel: statusLabel)
        clearTextFields()
    }
    
    func resetPwd() {
        let email = emailField.text
        clearTextFields()
        UserAuthentication().getResetLink(email!, statusLabel: statusLabel)
        authenticationView.showLoginOrSignupScreen()
    }
    
    func isInvalidInput(username: String, email:String="", password: String) -> Bool {
        let MAX_LENGTH_USERNAME = 15
        let MAX_LENGTH_PASSWORD = 35
        var isInvalid = false
        if username.characters.count > MAX_LENGTH_USERNAME ||
           password.characters.count > MAX_LENGTH_PASSWORD ||
           username.containsUpperCaseLetter() || !username.isNotAlphanumeric {
            isInvalid = true
        } else if email == "" {    // login (no email address)
            isInvalid = false
            
        } else {   // signup - email validation
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
            let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            isInvalid = !emailTest.evaluateWithObject(email)
        }
        return isInvalid
    }
    
    func clearTextFields() {
        authenticationView.usernameField.text = ""
        authenticationView.emailField.text = ""
        authenticationView.passwordField.text = ""
    }
    
    @IBAction func unwindToAuth(segue: UIStoryboardSegue) {
    }

}


