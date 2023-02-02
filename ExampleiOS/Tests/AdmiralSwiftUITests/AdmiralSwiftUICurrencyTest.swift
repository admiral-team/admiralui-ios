//
//  AdmiralSwiftUICurrencyTest.swift
//  AdmiralSwiftUITests
//

import XCTest

class AdmiralSwiftUICurrencyTest: XCTestCase {
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    override func tearDownWithError() throws {
    }
    
    func testCheckSwiftUI() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["SeatingTabBarItem"].tap()
        let swiftUISwitcher = app.switches["SwitchToSwiftUI"]
        
        if swiftUISwitcher.value as? String == "0" {
            swiftUISwitcher.tap()
        }
    }
    
    func testCurrencyDefault() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["Currency"].tap()
        app.buttons["Default"].tap()
        
        changeThemes(app: app)
    }
    
    func testCurrencyIcons() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["Currency"].tap()
        app.buttons["Icons"].tap()
        
        changeThemes(app: app)
    }
    
    func testCurrencyFlags() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["Currency"].tap()
        app.buttons["Flags"].tap()
        
        changeThemes(app: app)
    }
    
    func testCurrencyIconsFlags() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["Currency"].tap()
        app.buttons["Icons & Flags"].tap()
        
        changeThemes(app: app)
    }
    
    func changeThemes(app: XCUIApplication) {
        app.buttons["Ellipse"].tap()
        
        app.buttons["Dark"].tap()
        app.buttons["SME Light"].tap()
        app.buttons["SME Dark"].tap()
        app.buttons["Light"].tap()
        
        app.buttons["Ellipse"].tap()
    }
}
