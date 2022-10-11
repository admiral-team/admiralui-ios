//
//  AddUIKitAlertsTest.swift
//  AdmiralUIKitTests
//

import XCTest

class AddUIKitAlertsTest: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
    }

    func testAlert() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.tables.staticTexts["Alerts"].tap()
        app.tables.staticTexts["Alert"].tap()
        app.staticTexts["Показать Alert"].tap()
        app.staticTexts["Хорошо"].tap()
        app.staticTexts["Показать Alert"].tap()
        app.staticTexts["Отмена"].tap()
        
        app.buttons["Ellipse"].tap()
        
        app.staticTexts["Light"].tap()
        app.staticTexts["Dark"].tap()
        app.staticTexts["SME Light"].tap()
        app.staticTexts["SME Dark"].tap()
        
        app.buttons["Ellipse"].tap()
    }
    
    func testOnboarding() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.tables.staticTexts["Alerts"].tap()
        app.tables.staticTexts["Onboarding"].tap()
        app.buttons["arrowRight"].tap()
        app.buttons["arrowRight"].tap()
        app.buttons["arrowRight"].tap()
    }
    
    func testZeroscreen() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.tables.staticTexts["Alerts"].tap()
        app.tables.staticTexts["Zeroscreen"].tap()
        app.staticTexts["Хорошо"].tap()
    }
    
    func testErrorView() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.tables.staticTexts["Alerts"].tap()
        app.tables.staticTexts["Error View"].tap()
        app.staticTexts["Хорошо"].tap()
        
        app.buttons["Ellipse"].tap()
        
        app.staticTexts["Light"].tap()
        app.staticTexts["Dark"].tap()
        app.staticTexts["SME Light"].tap()
        app.staticTexts["SME Dark"].tap()
        
        app.buttons["Ellipse"].tap()
    }
}
