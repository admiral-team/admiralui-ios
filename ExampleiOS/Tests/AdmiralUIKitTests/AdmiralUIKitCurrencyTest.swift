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
        
        checkFramework(width: app, framework: .UIKit)
        
        app.tables.staticTexts["Currency"].tap()
        app.tables.staticTexts["Default"].tap()
        changeThemes(app: app)
    }
    
    func testCurrencyIcons() throws {
        let app = XCUIApplication()
        app.launch()
        
        checkFramework(width: app, framework: .UIKit)
        
        app.tables.staticTexts["Currency"].tap()
        app.tables.staticTexts["Icons"].tap()
        changeThemes(app: app)
    }
    
    func testCurrencyFlags() throws {
        let app = XCUIApplication()
        app.launch()
        
        checkFramework(width: app, framework: .UIKit)
        
        app.tables.staticTexts["Currency"].tap()
        app.tables.staticTexts["Flags"].tap()
        changeThemes(app: app)
    }
    
    func testCurrencyIconsFlags() throws {
        let app = XCUIApplication()
        app.launch()
        
        checkFramework(width: app, framework: .UIKit)
        
        app.tables.staticTexts["Currency"].tap()
        app.tables.staticTexts["Icons & Flags"].tap()
        changeThemes(app: app)
    }
    
    func changeThemes(app: XCUIApplication) {
        app.buttons["Ellipse"].tap()
        
        app.otherElements.matching(identifier: "ThemeSwitchButton_Light").element.tap()
        app.otherElements.matching(identifier: "ThemeSwitchButton_Dark").element.tap()
        app.otherElements.matching(identifier: "ThemeSwitchButton_SME Light").element.tap()
        app.otherElements.matching(identifier: "ThemeSwitchButton_SME Dark").element.tap()
        
        app.buttons["Ellipse"].tap()
    }
}
