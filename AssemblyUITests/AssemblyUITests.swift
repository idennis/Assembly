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
    
    func test1() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        
        let app = XCUIApplication()
        app.textFields["username"].tap()
        app.textFields["username"]
        app.secureTextFields["password"].tap()
        app.secureTextFields["password"]
        app.buttons["Login"].tap()
        
    }
    
    func test2(){
        
        
        let app = XCUIApplication()
        app.textFields["username"].tap()
        app.textFields["username"]
        app.secureTextFields["password"].tap()
        app.secureTextFields["password"]
        app.typeText("\r")
        
        let plusButton = app.navigationBars["WHAT'S ON"].buttons["Plus"]
        plusButton.tap()
        
        let postAnEventNavigationBar = app.navigationBars["POST AN EVENT"]
        postAnEventNavigationBar.buttons["Cancel"].tap()
        plusButton.tap()
        
        let element = app.childrenMatchingType(.Window).elementBoundByIndex(0).childrenMatchingType(.Other).elementBoundByIndex(1).childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.childrenMatchingType(.Other).elementBoundByIndex(1)
        let element2 = element.childrenMatchingType(.Other).elementBoundByIndex(0)
        let textField = element2.childrenMatchingType(.TextField).element
        textField.tap()
        textField.tap()
        element2.childrenMatchingType(.TextField).element
        element.childrenMatchingType(.Other).elementBoundByIndex(1).childrenMatchingType(.TextField).element.tap()
        postAnEventNavigationBar.buttons["Post"].tap()
        
        
        
        
    }
    
    func test3(){
        
        
        let app = XCUIApplication()
        let usernameTextField = app.textFields["username"]
        usernameTextField.tap()
        usernameTextField.tap()
        app.textFields["username"]
        app.secureTextFields["password"].tap()
        app.secureTextFields["password"]
        app.buttons["Login"].tap()
        
        let tabBarsQuery = app.tabBars
        tabBarsQuery.buttons["Profile"].tap()
        tabBarsQuery.buttons["What's On"].tap()
        
        
    }
}
