//
//  AuthenticationView.swift
//  Phlash
//
//  Created by Amy Nicholson on 17/06/2016.
//  Copyright © 2016 Phlashers. All rights reserved.
//


import UIKit

extension String {
    func containsOnlyCharactersIn(matchCharacters: String) -> Bool {
        let disallowedCharacterSet = NSCharacterSet(charactersInString: matchCharacters).invertedSet
        return self.rangeOfCharacterFromSet(disallowedCharacterSet) == nil
    }
}

class AuthenticationView: UIView, UITextFieldDelegate {

    let FONT_SIZE = UIScreen.mainScreen().bounds.size.height/40
    let MAX_LENGTH_USERNAME = 15
    let MAX_LENGTH_PASSWORD = 35
    
    let usernameField = UITextField()
    let emailField = UITextField()
    let passwordField = UITextField()
    
    private let screenBounds:CGSize = UIScreen.mainScreen().bounds.size
    private let whiteColor = UIColor.whiteColor()
    private let backgroundGreen: UIColor = UIColor( red: CGFloat(62/255.0), green: CGFloat(200/255.0), blue: CGFloat(172/255.0), alpha: CGFloat(0.75))
    let submitButton = UIButton()
    let loginButton = UIButton()
    let signupButton = UIButton()
    let logoutButton = UIButton()
    let resetPwdButton = UIButton()
    var statusLabel = UILabel()
    let goBackButton = UIButton()
    let defaults = NSUserDefaults.standardUserDefaults()
    let tap: UITapGestureRecognizer = UITapGestureRecognizer()
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        buildAuthenticationView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //view setup
    func buildAuthenticationView() {
        frame = CGRect(x: 0, y: 0, width: screenBounds.width, height: screenBounds.height)
        backgroundColor = backgroundGreen
        
        usernameField.delegate = self
        usernameField.frame = CGRect(x: 0, y: screenBounds.height/8, width: screenBounds.width, height: screenBounds.height/15)
        usernameField.backgroundColor = UIColor.colorWithAlphaComponent(whiteColor)(0.5)
        usernameField.placeholder = "Username"
        usernameField.textAlignment = .Center
        usernameField.accessibilityLabel = "username"
        usernameField.autocorrectionType = .No
        usernameField.delegate = self
        usernameField.userInteractionEnabled = true
        usernameField.autocapitalizationType = UITextAutocapitalizationType.None
        
        emailField.delegate = self
        emailField.frame = CGRect(x: 0, y: screenBounds.height/4, width: screenBounds.width, height: screenBounds.height/15)
        emailField.backgroundColor = UIColor.colorWithAlphaComponent(whiteColor)(0.5)
        emailField.placeholder = "Email"
        emailField.textAlignment = .Center
        emailField.keyboardType = UIKeyboardType.EmailAddress
        emailField.accessibilityLabel = "email"
        emailField.delegate = self
        emailField.autocorrectionType = .No
        emailField.autocapitalizationType = UITextAutocapitalizationType.None
        
        passwordField.delegate = self
        passwordField.frame = CGRect(x: 0, y: screenBounds.height * 3/8, width: screenBounds.width, height: screenBounds.height/15)
        passwordField.backgroundColor = UIColor.whiteColor()
        passwordField.backgroundColor = UIColor.colorWithAlphaComponent(whiteColor)(0.5)
        passwordField.placeholder = "Password"
        passwordField.textAlignment = .Center
        passwordField.secureTextEntry = true
        passwordField.delegate = self
        passwordField.accessibilityLabel = "password"
        
        submitButton.frame = CGRect(x: screenBounds.width/4, y: screenBounds.height/2, width: screenBounds.width/2, height: 30)
        submitButton.setTitleColor(.whiteColor(), forState: .Normal)
        submitButton.setTitle("Submit", forState: .Normal)
        submitButton.accessibilityLabel = "submit"
        
        loginButton.frame = CGRect(x: screenBounds.width*2/5, y: screenBounds.height/2 - 50, width: screenBounds.width/5, height: 30)
        loginButton.setTitleColor(.whiteColor(), forState: .Normal)
        loginButton.setTitle("Login", forState: .Normal)
        loginButton.accessibilityLabel = "login"
        
        
        signupButton.frame = CGRect(x: screenBounds.width*2/5, y: screenBounds.height/2, width: screenBounds.width/5, height: 30)
        signupButton.setTitleColor(.whiteColor(), forState: .Normal)
        signupButton.setTitle("Signup", forState: .Normal)
        signupButton.accessibilityLabel = "signup"
        
        statusLabel.frame = CGRect(x: 0, y: -60, width: screenBounds.width, height: 60)
        statusLabel.textColor = backgroundGreen
        statusLabel.backgroundColor = whiteColor
        statusLabel.textAlignment = .Center
        statusLabel.font = UIFont.systemFontOfSize(FONT_SIZE)
        statusLabel.minimumScaleFactor = 0.5
        statusLabel.adjustsFontSizeToFitWidth = true
        statusLabel.numberOfLines = 1
        statusLabel.userInteractionEnabled = false
        
        statusLabel.font = UIFont.systemFontOfSize(FONT_SIZE)
        statusLabel.minimumScaleFactor = 0.5
        statusLabel.adjustsFontSizeToFitWidth = true
        statusLabel.numberOfLines = 1
        statusLabel.hidden = true
        
        goBackButton.frame = CGRect(x: 0, y: 10, width: screenBounds.width/5, height: 30)
        goBackButton.setTitleColor(.whiteColor(), forState: .Normal)
        goBackButton.setTitle("Go back", forState: .Normal)
        goBackButton.accessibilityLabel = "goBack"
        
        resetPwdButton.frame = CGRect(x: screenBounds.width/4, y: screenBounds.height*0.55, width: screenBounds.width/2, height: 30)
        resetPwdButton.setTitleColor(.whiteColor(), forState: .Normal)
        resetPwdButton.setTitle("Forgot Password", forState: .Normal)
        resetPwdButton.accessibilityLabel = "resetPwd"
        
        addSubview(usernameField)
        addSubview(emailField)
        addSubview(passwordField)
        addSubview(submitButton)
        addSubview(loginButton)
        addSubview(signupButton)
        addSubview(statusLabel)
        addSubview(goBackButton)
        addSubview(resetPwdButton)
        addGestureRecognizer(tap)
        
        showLoginOrSignupScreen()
    }
    

    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let alphaNumeric = "abcdefghijklmnopqrstuvwxyz0123456789"
        var shouldChange = true
        let currentText = textField.text ?? ""
        let text = (currentText as NSString).stringByReplacingCharactersInRange(range, withString: string) as NSString
        let textSize:CGSize = text.sizeWithAttributes([NSFontAttributeName: UIFont.systemFontOfSize(FONT_SIZE)])
        let isUppercase = string.rangeOfCharacterFromSet(NSCharacterSet.uppercaseLetterCharacterSet())
        let disallowedCharacterSet = NSCharacterSet(charactersInString: alphaNumeric).invertedSet
        let isSymbol = string.rangeOfCharacterFromSet(disallowedCharacterSet)
        
        // username and emails must be lower case
        if ((textField == usernameField || textField == emailField) && isUppercase != nil)  ||
            (textField == usernameField && text.length > MAX_LENGTH_USERNAME && string.characters.count > 0) ||
            (textField == passwordField && text.length > MAX_LENGTH_PASSWORD && string.characters.count > 0) ||
            (textSize.width > textField.bounds.size.width) ||
            (textField == usernameField && isSymbol != nil)
            {
                shouldChange = false
            }
        return shouldChange
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.endEditing(true)
        return false
    }

    func showLoginOrSignupScreen() {
        usernameField.hidden = true
        passwordField.hidden = true
        submitButton.hidden = true
        emailField.hidden = true
        loginButton.hidden = false
        signupButton.hidden = false
        resetPwdButton.hidden = true
        goBackButton.hidden = true
    }
    
    func showLoginView() {
        usernameField.hidden = false
        passwordField.hidden = false
        submitButton.hidden = false
        submitButton.setTitle("Log me in", forState: .Normal)
        emailField.hidden = true
        loginButton.hidden = true
        signupButton.hidden = true
        resetPwdButton.hidden = false
        goBackButton.hidden = false
        usernameField.becomeFirstResponder()
    }
    
    func showSignupView() {
        usernameField.hidden = false
        passwordField.hidden = false
        submitButton.hidden = false
        submitButton.setTitle("Sign me up", forState: .Normal)
        
        emailField.hidden = false
        loginButton.hidden = true
        signupButton.hidden = true
        resetPwdButton.hidden = true
        goBackButton.hidden = false
        usernameField.becomeFirstResponder()
    }
    
    func showResetPwdView() {
        usernameField.hidden = true
        passwordField.hidden = true
        submitButton.hidden = false
        submitButton.setTitle("Reset Password", forState: .Normal)
        
        emailField.hidden = false
        loginButton.hidden = true
        signupButton.hidden = true
        resetPwdButton.hidden = true
        goBackButton.hidden = false
        emailField.becomeFirstResponder()
    }
    
}
