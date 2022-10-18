//
//  AddUIKitCurrencyTest.swift
//  AdmiralUIKitTests
//

import XCTest

class AddUIKitCurrencyTest: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
    }

    func testCurrencyDefault() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.tables.staticTexts["Currency"].tap()
        app.tables.staticTexts["Default"].tap()
        changeThemes(app: app)
    }
    
    func testCurrencyIcons() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.tables.staticTexts["Currency"].tap()
        app.tables.staticTexts["Icons"].tap()
        changeThemes(app: app)
    }
    
    func testCurrencyFlags() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.tables.staticTexts["Currency"].tap()
        app.tables.staticTexts["Flags"].tap()
        changeThemes(app: app)
    }
    
    func testCurrencyIconsFlags() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.tables.staticTexts["Currency"].tap()
        app.tables.staticTexts["Icons & Flags"].tap()
        changeThemes(app: app)
    }
    
    func changeThemes(app: XCUIApplication) {
        app.buttons["Ellipse"].tap()
        
        app.staticTexts["Light"].tap()
        app.staticTexts["Dark"].tap()
        app.staticTexts["SME Light"].tap()
        app.staticTexts["SME Dark"].tap()
        
        app.buttons["Ellipse"].tap()
    }
}
