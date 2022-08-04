//
//  AdmiralUIKitUITests.swift
//  AdmiralUIKitUITests
//
//  Created by Мигунов Евгений Анатольевич on 01.08.2022.
//

import XCTest

class AdmiralUIKitButtonsTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPrimaryButtons() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        app.tables.staticTexts["Buttons"].tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Primary buttons"]/*[[".cells.staticTexts[\"Primary buttons\"]",".staticTexts[\"Primary buttons\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app.staticTexts["Disabled"].tap()
        app.staticTexts["Default"].tap()
        
        app.buttons["Ellipse"].tap()
    
        
        app.staticTexts["Light"].tap()
        app.staticTexts["Dark"].tap()
        app.staticTexts["SME Light"].tap()
        app.staticTexts["SME Dark"].tap()
        app.buttons["Ellipse"].tap()
                
        
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    }
    
    func testSecondaryButtons() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        app.tables.staticTexts["Buttons"].tap()
        app.tables.staticTexts["Secondary buttons"].tap()
        
        app.staticTexts["Disabled"].tap()
        app.staticTexts["Default"].tap()
        
        app.buttons["Ellipse"].tap()
    
        
        app.staticTexts["Light"].tap()
        app.staticTexts["Dark"].tap()
        app.staticTexts["SME Light"].tap()
        app.staticTexts["SME Dark"].tap()
        app.buttons["Ellipse"].tap()
        
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
    }
    
    func testGhostButtons() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        app.tables.staticTexts["Buttons"].tap()
        app.tables.staticTexts["Ghost buttons"].tap()
        
        app.staticTexts["Disabled"].tap()
        app.staticTexts["Default"].tap()
        
        app.buttons["Ellipse"].tap()
    
        app.staticTexts["Light"].tap()
        app.staticTexts["Dark"].tap()
        app.staticTexts["SME Light"].tap()
        app.staticTexts["SME Dark"].tap()
        app.buttons["Ellipse"].tap()
        
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testRules() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        app.tables.staticTexts["Buttons"].tap()
        app.tables.staticTexts["Rules"].tap()
        
        app.staticTexts["Disabled"].tap()
        app.staticTexts["Default"].tap()
        
    
        app.staticTexts["Я согласен с условиями договора и подтверждаю свое согласие на обработку персональных данных"].tap()
        app.staticTexts["Я согласен с условиями договора и подтверждаю свое согласие на обработку персональных данных"].tap()
        
        app.buttons["Ellipse"].tap()
        app.staticTexts["Light"].tap()
        app.staticTexts["Dark"].tap()
        app.staticTexts["SME Light"].tap()
        app.staticTexts["SME Dark"].tap()
        app.buttons["Ellipse"].tap()
        
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testOtherButtons() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        app.tables.staticTexts["Buttons"].tap()
        app.tables.staticTexts["Other buttons"].tap()
        app.staticTexts["Disabled"].tap()
        app.staticTexts["Default"].tap()
        
        app.buttons["Ellipse"].tap()
        app.staticTexts["Light"].tap()
        app.staticTexts["Dark"].tap()
        app.staticTexts["SME Light"].tap()
        app.staticTexts["SME Dark"].tap()
        app.buttons["Ellipse"].tap()
        
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}




