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
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testPhollowViewIsShown() {
        sleep(1)
        app.buttons["login"].tap()
        app.textFields["username"].tap()
        app.textFields["username"].typeText("testuser1")
        app.secureTextFields["password"].tap()
        app.secureTextFields["password"].typeText("password")
        app.buttons["submit"].tap()
        sleep(1)
        app.buttons["phollow"].tap()
        sleep(1)
        XCTAssert(app.staticTexts["PhollowView"].exists)
        app.buttons["cancel"].tap()
        sleep(1)
        app.buttons["logout"].tap()
    }
    
    func testPhollowAUser() {
        sleep(1)
        app.buttons["login"].tap()
        app.textFields["username"].tap()
        app.textFields["username"].typeText("testuser1")
        app.secureTextFields["password"].tap()
        app.secureTextFields["password"].typeText("password")
        app.buttons["submit"].tap()
        sleep(1)
        app.buttons["phollow"].tap()
        sleep(1)
        app.textFields["phollowee"].tap()
        app.textFields["phollowee"].typeText("testuser2")
        app.buttons["pholloweesubmit"].tap()
        XCTAssert(app.staticTexts["Successfully phollowed testuser2"].exists)
        app.buttons["logout"].tap()
    }
    
    // Type in name that exists to follow
    // hit follow
    // expect confirmation of person we are following
    // finish on main camera view
    
    // Type in a name that does not exist
    // hit follow
    // expect error message saying XXXX does not exist
    // Remain on follow screen


}
