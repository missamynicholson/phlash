import XCTest

class SwipeUITests: XCTestCase {
    
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
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
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
    
    func login(username: String, password: String){
        waitForAppearanceOfButton("login", app: app)
        app.buttons["login"].tap()
        app.textFields["username"].tap()
        app.textFields["username"].typeText(username)
        app.secureTextFields["password"].tap()
        app.secureTextFields["password"].typeText(password)
        app.buttons["submit"].tap()
    }
    
    func phollow(user:String){
        waitForAppearanceOfButton("settings", app: app)
        app.buttons["settings"].tap()
        waitForAppearanceOfButton("phollow", app: app)
        app.buttons["phollow"].tap()
        app.textFields["phollowee"].tap()
        app.textFields["phollowee"].typeText(user)
        app.buttons["pholloweesubmit"].tap()
    }
    
    func unphollow(user:String){
        waitForAppearanceOfButton("settings", app: app)
        app.buttons["settings"].tap()
        waitForAppearanceOfButton("phollow", app: app)
        app.buttons["phollow"].tap()
        app.textFields["phollowee"].tap()
        app.textFields["phollowee"].typeText(user)
        app.buttons["unpholloweesubmit"].tap()
    }
    
    func logoutFromCameraView(){
        waitForAppearanceOfButton("settings", app: app)
        app.buttons["settings"].tap()
        waitForAppearanceOfButton("logout", app: app)
        app.buttons["logout"].tap()
    }
    
    //SWIPE RIGHT TESTS
    func testSuccessfulSwipeRight(){
        loginAsTestUser()
        let phlashView = app.staticTexts["PhlashView"]
        XCTAssertFalse(phlashView.exists)
        waitForAppearanceOfButton("settings", app: app)
        app.swipeRight()
        waitForAppearanceOfText("PhlashView", app: app)
        XCTAssertTrue(phlashView.exists)
        logoutFromCameraView()
    }
    
    //SWIPE LEFT TESTS
    func testSuccessfulSwipeLeftNoImages(){
        loginAsTestUser()
        waitForAppearanceOfButton("settings", app: app)
        app.swipeLeft()
        let phlashView = app.staticTexts["PhlashView"]
        XCTAssertFalse(phlashView.exists)
        let error = app.staticTexts["No phlashes! Try again later."]
        waitForAppearanceOfText("No phlashes! Try again later.", app: app)
        XCTAssertTrue(error.exists)
        logoutFromCameraView()
    }
    
    func testSuccessfulSwipeLeftImageToView(){
        loginAsTestUser()
       
        phollow("testwithpicture")
        
        waitForAppearanceOfButton("cancel", app: app)
        let cancel = app.buttons["cancel"]
        cancel.tap()
        
        logoutFromCameraView()
        
        login("testwithpicture", password: "password")
        waitForAppearanceOfButton("settings", app: app)
        app.swipeRight()
        sleep(20)
        logoutFromCameraView()
        
        loginAsTestUser()
        
        waitForAppearanceOfText("New phlashes in! Swipe left to flick through them.", app: app)
        let alert = app.staticTexts["New phlashes in! Swipe left to flick through them."]
        XCTAssertTrue(alert.exists)
        
        app.swipeLeft()
        let phlashView = app.staticTexts["PhlashView"]
        let sendername = app.staticTexts["testwithpicture"]
        waitForAppearanceOfText("PhlashView", app: app)
        XCTAssertTrue(phlashView.exists)
        XCTAssertTrue(sendername.exists)
        
        unphollow("testwithpicture")
        waitForAppearanceOfButton("cancel", app: app)
        app.buttons["cancel"].tap()
        logoutFromCameraView()
    }
    
}