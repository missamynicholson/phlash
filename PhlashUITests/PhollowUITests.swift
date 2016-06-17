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


}
