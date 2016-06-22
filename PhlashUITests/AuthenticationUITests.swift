//
//  AuthenticationUITests.swift
//  Phlash
//
//  Created by Ollie Haydon-Mulligan on 22/06/2016.
//  Copyright © 2016 Phlashers. All rights reserved.
//

import XCTest
import Parse

class AuthenticationUITests: XCTestCase {
    
    override func setUp() {
        super.setUp()
       
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = true
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    let app = XCUIApplication()
    
    func testSignUpButtonExists(){
        let signup = app.buttons["signup"]
        XCTAssertEqual(signup.hittable, true)
    }
    func testLoginButtonExists(){
        let login = app.buttons["login"]
        XCTAssertEqual(login.hittable, true)
    }
    
    func waitForAppearanceOfButton(buttonLabel: String, app: XCUIApplication){
        let label = app.buttons[buttonLabel]
        let hittable = NSPredicate(format: "hittable == true")
        expectationForPredicate(hittable, evaluatedWithObject: label, handler: nil)
        waitForExpectationsWithTimeout(5, handler: nil)
    }
    
    func waitForAppearanceOfText(textLabel: String, app: XCUIApplication){
        let label = app.staticTexts[textLabel]
        let exists = NSPredicate(format: "exists == true")
        expectationForPredicate(exists, evaluatedWithObject: label, handler: nil)
        waitForExpectationsWithTimeout(5, handler: nil)
    }
    
    func login(username: String, password: String){
        waitForAppearanceOfButton("login", app: app)
        app.buttons["login"].tap()
        app.textFields["username"].tap()
        app.textFields["username"].typeText(username)
        app.secureTextFields["password"].tap()
        app.secureTextFields["password"].typeText(password)
        app.buttons["submit"].tap()
    }

    func logoutFromCameraView(){
        waitForAppearanceOfButton("settings", app: app)
        app.buttons["settings"].tap()
        waitForAppearanceOfButton("logout", app: app)
        app.buttons["logout"].tap()
    }
    
    func signUp(username: String, email: String, password: String){
        waitForAppearanceOfButton("signup", app: app)
        app.buttons["signup"].tap()
        app.textFields["username"].tap()
        app.textFields["username"].typeText(username)
        app.textFields["email"].tap()
        app.textFields["email"].typeText(email)
        app.secureTextFields["password"].tap()
        app.secureTextFields["password"].typeText(password)
        app.buttons["submit"].tap()

    }
    
    func testSuccessfulSignup(){
        signUp("testcat1", email: "testemail@email.com", password: "abcdef")
        waitForAppearanceOfButton("settings", app: app)
        let settings = app.buttons["settings"]
        XCTAssertEqual(settings.hittable, true)
        app.buttons["settings"].tap()
        waitForAppearanceOfButton("logout", app: app)
        app.buttons["logout"].tap()
    }
    

    func testIncorrectSignupInvalidEmail(){
        signUp("testcat2", email: "invalidemail", password: "abcdef")
        waitForAppearanceOfText("error: please review your input", app: app)
        let error = app.staticTexts["error: please review your input"]
        XCTAssertEqual(error.exists, true)
        waitForAppearanceOfButton("goBack", app: app)
        let goBack = app.buttons["goBack"]
        XCTAssertEqual(goBack.hittable, true)
        goBack.tap()
    }
    
    func testIncorrectSignupDuplicateUsername(){
        signUp("testuser1", email: "testemail@email.com", password: "abcdef")
        waitForAppearanceOfText("username testuser1 already taken", app: app)
        let error = app.staticTexts["username testuser1 already taken"]
        XCTAssertEqual(error.exists, true)
        waitForAppearanceOfButton("goBack", app: app)
        let goBack = app.buttons["goBack"]
        XCTAssertEqual(goBack.hittable, true)
        goBack.tap()
    }
    
    func testSuccessfullogIn(){
        login("testuser1", password: "password")
        waitForAppearanceOfButton("settings", app: app)
        let settings = app.buttons["settings"]
        XCTAssertEqual(settings.hittable, true)
        app.buttons["settings"].tap()
        waitForAppearanceOfButton("logout", app: app)
        app.buttons["logout"].tap()
    }
    
    func testIncorrectPassword(){
        login("testuser1", password: "incorrectpassword")
        waitForAppearanceOfText("invalid login parameters", app: app)
        let error = app.staticTexts["invalid login parameters"]
        XCTAssertEqual(error.exists, true)
        waitForAppearanceOfButton("goBack", app: app)
        let goBack = app.buttons["goBack"]
        XCTAssertEqual(goBack.hittable, true)
        goBack.tap()
    }
    
    func testUsernameNotExists(){
        login("testnouser", password: "anypassword")
        waitForAppearanceOfText("invalid login parameters", app: app)
        let error = app.staticTexts["invalid login parameters"]
        XCTAssertEqual(error.exists, true)
        waitForAppearanceOfButton("goBack", app: app)
        let goBack = app.buttons["goBack"]
        XCTAssertEqual(goBack.hittable, true)
        goBack.tap()
    }
    
    func testSuccessfulSignOut(){
        login("testuser1", password: "password")
        logoutFromCameraView()
        waitForAppearanceOfButton("login", app: app)
        let loginbutton = app.buttons["login"]
        XCTAssertEqual(loginbutton.hittable, true)
    }

}
