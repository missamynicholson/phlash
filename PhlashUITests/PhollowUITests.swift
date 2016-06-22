//
//  PhollowUITests.swift
//  Phlash
//
//  Created by Amy Nicholson on 17/06/2016.
//  Copyright © 2016 Phlashers. All rights reserved.
//

import XCTest
@testable import Phlash

class PhollowUITests: XCTestCase {
    
    let app = XCUIApplication()
    
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
    
    func waitForAppearanceOfButton(buttonLabel: String, app: XCUIApplication){
        let label = app.buttons[buttonLabel]
        let hittable = NSPredicate(format: "hittable == true")
        expectationForPredicate(hittable, evaluatedWithObject: label, handler: nil)
        waitForExpectationsWithTimeout(5, handler: nil)
    }
    
    func waitForAppearanceOfText(text: String, app: XCUIApplication){
        let label = app.staticTexts[text]
        let exists = NSPredicate(format: "exists == true")
        expectationForPredicate(exists, evaluatedWithObject: label, handler: nil)
        waitForExpectationsWithTimeout(5, handler: nil)
    }
    
    func loginAsTestUser(){
        waitForAppearanceOfButton("login", app: app)
        app.buttons["login"].tap()
        app.textFields["username"].tap()
        app.textFields["username"].typeText("testuser1")
        app.secureTextFields["password"].tap()
        app.secureTextFields["password"].typeText("password")
        app.buttons["submit"].tap()
    }
    
    func logoutFromCameraView(){
        waitForAppearanceOfButton("settings", app: app)
        app.buttons["settings"].tap()
        waitForAppearanceOfButton("logout", app: app)
        app.buttons["logout"].tap()
    }
    
    func phollow(user:String){
        waitForAppearanceOfButton("settings", app: app)
        app.buttons["settings"].tap()
        waitForAppearanceOfButton("phollow", app: app)
        app.buttons["phollow"].tap()
        waitForAppearanceOfButton("cancel", app: app)
        app.textFields["phollowee"].tap()
        app.textFields["phollowee"].typeText(user)
        app.buttons["pholloweesubmit"].tap()
    }
    
    func unphollow(user:String){
        waitForAppearanceOfButton("settings", app: app)
        app.buttons["settings"].tap()
        waitForAppearanceOfButton("phollow", app: app)
        app.buttons["phollow"].tap()
        waitForAppearanceOfButton("cancel", app: app)
        app.textFields["phollowee"].tap()
        app.textFields["phollowee"].typeText(user)
        app.buttons["unpholloweesubmit"].tap()
    }

    func testPhollowViewIsShown() {
        logoutFromCameraView()
        loginAsTestUser()
        waitForAppearanceOfButton("settings", app: app)
        app.buttons["settings"].tap()
        waitForAppearanceOfButton("phollow", app: app)
        app.buttons["phollow"].tap()
        waitForAppearanceOfButton("cancel", app: app)
        XCTAssertFalse(app.staticTexts["CameraView"].exists)
        XCTAssert(app.staticTexts["PhollowView"].exists)
        app.buttons["cancel"].tap()
        logoutFromCameraView()
    }
    
    func testPhollowAUser() {
        loginAsTestUser()
        phollow("testuser2")
        waitForAppearanceOfText("Successfully phollowed testuser2", app:app)
        XCTAssert(app.staticTexts["Successfully phollowed testuser2"].exists)
        app.textFields["phollowee"].tap()
        app.textFields["phollowee"].typeText("testuser2")
        app.buttons["unpholloweesubmit"].tap()
        waitForAppearanceOfButton("cancel", app:app)
        app.buttons["cancel"].tap()
        sleep(1)
        XCTAssert(app.staticTexts["CameraView"].exists)
        logoutFromCameraView()
    }
    
    func testPhollowANonUser() {
        logoutFromCameraView()
        loginAsTestUser()
        phollow("testuser3")
        waitForAppearanceOfText("Unsuccessfully phollowed: User doesn't exist", app:app)
        XCTAssert(app.staticTexts["Unsuccessfully phollowed: User doesn't exist"].exists)
        waitForAppearanceOfButton("cancel", app:app)
        app.buttons["cancel"].tap()
        logoutFromCameraView()
    }
    
    func testPhollowExistingPhollowee(){
        loginAsTestUser()
        phollow("testuser2")
        app.textFields["phollowee"].tap()
        app.textFields["phollowee"].typeText("testuser2")
        app.buttons["pholloweesubmit"].tap()
        waitForAppearanceOfText("Unsuccessfully phollowed: Already phollowing!", app:app)
        XCTAssert(app.staticTexts["Unsuccessfully phollowed: Already phollowing!"].exists)
        app.textFields["phollowee"].tap()
        app.textFields["phollowee"].typeText("testuser2")
        app.buttons["unpholloweesubmit"].tap()
        waitForAppearanceOfButton("cancel", app:app)
        app.buttons["cancel"].tap()
        logoutFromCameraView()
    }
    
    func testUnphollowAUser(){
        loginAsTestUser()
        phollow("testuser2")
        app.textFields["phollowee"].tap()
        app.textFields["phollowee"].typeText("testuser2")
        app.buttons["unpholloweesubmit"].tap()
        waitForAppearanceOfText("Successfully unphollowed testuser2", app:app)
        XCTAssert(app.staticTexts["Successfully unphollowed testuser2"].exists)
        waitForAppearanceOfButton("cancel", app:app)
        app.buttons["cancel"].tap()
        logoutFromCameraView()
    }
    
    func testUnphollowANonPhollowee(){
        loginAsTestUser()
        unphollow("testuser2")
        waitForAppearanceOfText("Unsuccessfully unphollowed: Not phollowing that user", app:app)
        XCTAssert(app.staticTexts["Unsuccessfully unphollowed: Not phollowing that user"].exists)
        waitForAppearanceOfButton("cancel", app:app)
        app.buttons["cancel"].tap()
        logoutFromCameraView()
    }
    
    func testUnphollowANonUser(){
        loginAsTestUser()
        unphollow("testuser3")
        waitForAppearanceOfText("Unsuccessfully unphollowed: Not phollowing that user", app:app)
        XCTAssert(app.staticTexts["Unsuccessfully unphollowed: Not phollowing that user"].exists)
        waitForAppearanceOfButton("cancel", app:app)
        app.buttons["cancel"].tap()
        logoutFromCameraView()
    }


}
