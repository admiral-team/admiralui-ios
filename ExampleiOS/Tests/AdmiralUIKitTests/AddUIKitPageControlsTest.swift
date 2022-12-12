//
//  AddUIKitPageControlsTest.swift
//  AdmiralUIKitTests
//

import XCTest

class AddUIKitPageControlsTest: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
    }

    func testLiner() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.tables.staticTexts["Page Controls"].tap()
        app.tables.staticTexts["Liner"].tap()
        app.staticTexts["Two"].tap()
        app.staticTexts["One"].tap()
        app.staticTexts["Three"].tap()
        app.staticTexts["Four"].tap()
        app.staticTexts["Five"].tap()
        app.staticTexts["Six"].tap()
        app.staticTexts["Seven"].tap()
        app.staticTexts["Seven"].swipeLeft()
        app.staticTexts["Eight"].tap()
        app.staticTexts["Nine"].tap()
        
        changeThemes(app: app)
    }
    
    func testLinerNext() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.tables.staticTexts["Page Controls"].tap()
        app.tables.staticTexts["Liner"].tap()
        app.staticTexts["Next"].tap()
        app.staticTexts["Next"].tap()
        app.staticTexts["Next"].tap()
        app.staticTexts["Next"].tap()
        app.staticTexts["Next"].tap()
        app.staticTexts["Next"].tap()
        app.staticTexts["Next"].tap()
        app.staticTexts["Next"].tap()
        
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
