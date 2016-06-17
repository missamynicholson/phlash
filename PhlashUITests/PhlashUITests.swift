//
//  PhlashUITests.swift
//  PhlashUITests
//
//  Created by Amy Nicholson on 15/06/2016.
//  Copyright © 2016 Phlashers. All rights reserved.
//


import XCTest
@testable import Phlash
class PhlashUITests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        
    }
    
    
    //AUTHENTICATION TESTS
    func testSignUpButtonExists(){
        let app = XCUIApplication()
        let signup = app.buttons["signUp"]
        XCTAssertEqual(signup.hittable, true)
    }
    func testLoginButtonExists(){
        let app = XCUIApplication()
        let login = app.buttons["logIn"]
        XCTAssertEqual(login.hittable, true)
    }

    func testSuccessfulSignup(){
        let app = XCUIApplication()
        sleep(3)
        app.buttons["signUp"].tap()
        app.textFields["username"].tap()
        app.textFields["username"].typeText("Testuser1")
        app.textFields["email"].tap()
        app.textFields["email"].typeText("testemail@email.com")
        app.secureTextFields["password"].tap()
        app.secureTextFields["password"].typeText("abcdef")
        app.buttons["submit"].tap()
        sleep(3)
        let logout = app.buttons["logOut"]
        XCTAssertEqual(logout.hittable, true)
        //name of current controller is camera controller
    }
    func testIncorrectSignupInvalidEmail(){
        let app = XCUIApplication()
        sleep(3)
        app.buttons["signUp"].tap()
        app.textFields["username"].tap()
        app.textFields["username"].typeText("Testuser2")
        app.textFields["email"].tap()
        app.textFields["email"].typeText("invalidemail")
        app.secureTextFields["password"].tap()
        app.secureTextFields["password"].typeText("abcdef")
        app.buttons["submit"].tap()
        sleep(3)
        let logout = app.buttons["logOut"]
        XCTAssertEqual(logout.hittable, false)
        XCTAssert(app.staticTexts["Error: Invalid email address"].exists)
        //assert logout button does not appear
        //assert error message - what are the different possibilities?
    }
    func testIncorrectSignupDuplicateUsername(){
        let app = XCUIApplication()
        sleep(3)
        app.buttons["signUp"].tap()
        app.textFields["username"].tap()
        app.textFields["username"].typeText("Testuser1")
        app.textFields["email"].tap()
        app.textFields["email"].typeText("email@test.com")
        app.secureTextFields["password"].tap()
        app.secureTextFields["password"].typeText("abcdef")
        app.buttons["submit"].tap()
        sleep(3)
        let logout = app.buttons["logOut"]
        XCTAssertEqual(logout.hittable, false)
        XCTAssert(app.staticTexts["Error: Username already exists"].exists)
        //could also test for no password
    }
    func testSuccessfullogIn(){
        let app = XCUIApplication()
        sleep(3)
        app.buttons["signIn"].tap()
        app.textFields["username"].tap()
        app.textFields["username"].typeText("Testuser1")
        app.secureTextFields["password"].tap()
        app.secureTextFields["password"].typeText("abcdef")
        app.buttons["submit"].tap()
        sleep(3)
        let logout = app.buttons["logOut"]
        XCTAssertEqual(logout.hittable, true)
        //name of current controller is camera controller - can we assert camera interface is present?
    }
    func testIncorrectLogin(){
        let app = XCUIApplication()
        sleep(3)
        app.buttons["signIn"].tap()
        app.textFields["username"].tap()
        app.textFields["username"].typeText("Testuser1")
        app.secureTextFields["password"].tap()
        app.secureTextFields["password"].typeText("incorrectpassword")
        app.buttons["submit"].tap()
        sleep(3)
        let logout = app.buttons["logOut"]
        XCTAssertEqual(logout.hittable, false)
        XCTAssert(app.staticTexts["Error: Incorrect details"].exists)
    }
    func successfulSignOut(){
        let app = XCUIApplication()
        sleep(3)
        app.buttons["signIn"].tap()
        app.textFields["username"].tap()
        app.textFields["username"].typeText("Testuser1")
        app.secureTextFields["password"].tap()
        app.secureTextFields["password"].typeText("incorrectpassword")
        app.buttons["submit"].tap()
        sleep(3)
        app.buttons["logOut"].tap()
        let logout = app.buttons["logOut"]
        XCTAssertEqual(logout.hittable, false)
        let signup = app.buttons["signUp"]
        XCTAssertEqual(signup.hittable, true)
        let login = app.buttons["logIn"]
        XCTAssertEqual(login.hittable, true)
    }
    
    //SWIPE RIGHT TESTS
    func testSuccessfulSwipeRight(){
        //login
        //swipe right
        //current controller becomes captured image controller
        //assert an image is on the screen - or imageView has an image - or captured image controller has an image
        //after delay controller switches back to camera controller
    }
    func testSuccessfulSaveImage(){
        //login
        //swipe right
        //delay until text appears saying image sent
        //assert text appears
    }
    
    //FOLLOWING
    func testPhollowViewIsShown() {
        let app = XCUIApplication()
        sleep(1)
        app.buttons["login"].tap()
        app.textFields["username"].tap()
        app.textFields["username"].typeText("test")
        app.secureTextFields["password"].tap()
        app.secureTextFields["password"].typeText("password")
        app.buttons["submit"].tap()
        sleep(1)
        app.buttons["phollow"].tap()
        sleep(2)
        XCTAssert(app.staticTexts["PhollowView"].exists)
    }
    
    func testSuccessfulFollowUser(){
        //login
        //tap follow
        //type a user's name
        //tap submit
        //assert success message
    }
    func testIncorrectFollowUser(){
        //login
        //tap follow
        //type a user's name
        //tap submit
        //assert user does not exist message
    }
    
    //SWIPE LEFT TESTS
    func testSuccessfulSwipeLeftNoImages(){
        //login
        //swipe left
        //current controller will be retrieve image controller
        //assert message saying no images to view - are you following anyone?
    }
    func testSuccessfulSwipeLeftSomeImages(){
        //login
        //swipe left
        //current controller will be retrieve image controller
        //assert no message saying no images to view - are you following anyone?
        //assert the image view has an image or that the screen has an image
    }
    
}
