//
//  AdmiralUIKitUITests.swift
//  AdmiralUIKitUITests
//

import XCTest

class AdmiralUIKitButtonsTests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
    }

    func testPrimaryButtons() throws {
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
    }
    
    func testSecondaryButtons() throws {
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
    }
    
    func testGhostButtons() throws {
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
    }
    
    func testRules() throws {
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
    }
    
    func testOtherButtons() throws {
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
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
