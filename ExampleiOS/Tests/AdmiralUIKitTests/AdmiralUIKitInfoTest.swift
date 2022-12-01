//
//  AdmiralUIKitInfoTest.swift
//  AdmiralUIKitTests
//

import XCTest

class AdmiralUIKitInfoTest: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
    }

    func testInfoLight() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["Ellipse"].tap()
        
        app.otherElements.matching(identifier: "ThemeSwitchButton_Light").element.tap()
        
        app.buttons["Ellipse"].tap()
        
        app.buttons["Инфо"].tap()
        app.tables.staticTexts["Инфо"].tap()
    }
    
    func testInfoDark() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["Ellipse"].tap()
        
        app.otherElements.matching(identifier: "ThemeSwitchButton_Dark").element.tap()
        
        app.buttons["Ellipse"].tap()
        
        app.buttons["Инфо"].tap()
        app.tables.staticTexts["Инфо"].tap()
    }
    
    func testInfoSMELight() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["Ellipse"].tap()
        
        app.otherElements.matching(identifier: "ThemeSwitchButton_SME Light").element.tap()
        
        app.buttons["Ellipse"].tap()
        
        app.buttons["Инфо"].tap()
        app.tables.staticTexts["Инфо"].tap()
    }
    
    func testInfoSMEDark() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["Ellipse"].tap()
        
        app.otherElements.matching(identifier: "ThemeSwitchButton_SME Dark").element.tap()
        
        app.buttons["Ellipse"].tap()
        
        app.buttons["Инфо"].tap()
        app.tables.staticTexts["Инфо"].tap()
    }
}
