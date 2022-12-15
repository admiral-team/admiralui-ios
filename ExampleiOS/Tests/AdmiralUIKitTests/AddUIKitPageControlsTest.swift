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
    
    func testLinerNext() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.tables.staticTexts["Page Controls"].tap()
        app.tables.staticTexts["Liner"].tap()
        app.buttons["NextLiner"].tap(withNumberOfTaps: 8, numberOfTouches: 1)
        
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
