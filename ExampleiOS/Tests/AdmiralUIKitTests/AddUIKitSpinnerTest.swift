//
//  AddUIKitSpinnerTest.swift
//  AdmiralUIKitTests
//

import XCTest

class AddUIKitSpinnerTest: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
    }

    func testSpinner() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.tables.staticTexts["Spinner"].tap()
        app.staticTexts["Medium"].tap()
        app.staticTexts["Big"].tap()
        app.staticTexts["Small"].tap()
        
        app.buttons["Ellipse"].tap()
        
        app.otherElements.matching(identifier: "ThemeSwitchButton_Light").element.tap()
        app.otherElements.matching(identifier: "ThemeSwitchButton_Dark").element.tap()
        app.otherElements.matching(identifier: "ThemeSwitchButton_SME Light").element.tap()
        app.otherElements.matching(identifier: "ThemeSwitchButton_SME Dark").element.tap()
        
        app.buttons["Ellipse"].tap()
    }
}
