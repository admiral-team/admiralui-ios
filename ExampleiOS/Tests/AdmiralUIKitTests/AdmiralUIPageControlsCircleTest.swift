//
//  AdmiralUIPageControlsCircleTest.swift
//  AdmiralUIKitTests
//

import XCTest

class AdmiralUIPageControlsCircleTest: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
    }

    func testCircle() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.tables.staticTexts["Page Controls"].tap()
        app.tables.staticTexts["Circle"].tap()
        for _ in 0..<53 {
            app.otherElements.matching(identifier: "CircularPageControl").element.tap()
        }
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
