//
//  AddUIKitToolbarTest.swift
//  AdmiralUIKitTests
//

import XCTest

class AddUIKitToolbarTest: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
    }

    func testToolbar() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.tables.staticTexts["Tool bar"].tap()
        app.buttons["ToolBarInputNumberMinusButton"].tap()
        app.buttons["ToolBarInputNumberMinusButton"].tap()
        app.buttons["ToolBarInputNumberMinusButton"].tap()
        app.buttons["ToolBarInputNumberPlusButton"].tap()
        app.buttons["ToolBarInputNumberPlusButton"].tap()
        app.buttons["ToolBarInputNumberPlusButton"].tap()
        app.otherElements.matching(identifier: "ToolBarItemOne").element.tap()
        app.otherElements.matching(identifier: "ToolBarItemTwo").element.tap()
        app.otherElements.matching(identifier: "ToolBarItemThree").element.tap()
        app.otherElements.matching(identifier: "ToolBarItemFour").element.tap()
        
        app.buttons["Ellipse"].tap()
        
        app.otherElements.matching(identifier: "ThemeSwitchButton_Light").element.tap()
        app.otherElements.matching(identifier: "ThemeSwitchButton_Dark").element.tap()
        app.otherElements.matching(identifier: "ThemeSwitchButton_SME Light").element.tap()
        app.otherElements.matching(identifier: "ThemeSwitchButton_SME Dark").element.tap()
        
        app.buttons["Ellipse"].tap()
    }
}
