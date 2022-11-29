//
//  AdmiralUIKitAllertTest.swift
//  AdmiralUIKitTests
//

import XCTest

class AdmiralUIKitAllertTest: XCTestCase {

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
        
        app.otherElements.matching(identifier: "ThemeSwitchButton_Light").element.tap()
        app.otherElements.matching(identifier: "ThemeSwitchButton_Dark").element.tap()
        app.otherElements.matching(identifier: "ThemeSwitchButton_SME Light").element.tap()
        app.otherElements.matching(identifier: "ThemeSwitchButton_SME Dark").element.tap()
        
        app.buttons["Ellipse"].tap()
    }
}
