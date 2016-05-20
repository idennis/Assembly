//
//  AssemblyUITests.swift
//  AssemblyUITests
//
//  Created by Dennis Hou on 15/03/2016.
//  Copyright © 2016 RMIT. All rights reserved.
//

import XCTest

class AssemblyUITests: XCTestCase {
        
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
    
    
    func testLogin(){
        
        
        let app = XCUIApplication()
        let usernameTextField = app.textFields["username"]
        usernameTextField.tap()
        usernameTextField.typeText("kindler")
        
        
        let passwordTextField = app.secureTextFields["password"]
        
        passwordTextField.tap()
        passwordTextField.typeText("saraspassword")
        
        
        app.buttons["Login"].tap()
        
   //     let tabBarsQuery = app.tabBars
        
//        
//        tabBarsQuery.buttons["Profile"].tap()
//        tabBarsQuery.buttons["What's On"].tap()
    }
    
    
    

    
    func testEventDetail() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let app = XCUIApplication()
        let usernameTextField = app.textFields["username"]
        usernameTextField.tap()
        usernameTextField.typeText("kindler")
        
        
        let passwordTextField = app.secureTextFields["password"]
        
        passwordTextField.tap()
        passwordTextField.typeText("saraspassword")
        
        
        app.buttons["Login"].tap()
        
        
        
    }
    
    
    
    func testPostCancelAndNavigation(){
        
        let app = XCUIApplication()
        let usernameTextField = app.textFields["username"]
        usernameTextField.tap()
        usernameTextField.typeText("kindler")
        
        
        let passwordTextField = app.secureTextFields["password"]
        
        passwordTextField.tap()
        passwordTextField.typeText("saraspassword")
        
        
        app.buttons["Login"].tap()
//        
//        app.navigationBars["What's On"].buttons["Plus"].tap()
//        app.navigationBars["POST AN EVENT"].buttons["Cancel"].tap()
//        app.tabBars.buttons["Profile"].tap()
        
    }
    

}
