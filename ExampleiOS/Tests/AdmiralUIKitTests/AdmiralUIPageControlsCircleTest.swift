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
        app.staticTexts["One"].tap()
        app.staticTexts["Two"].tap()
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
    
    func testCircleNext() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.tables.staticTexts["Page Controls"].tap()
        app.tables.staticTexts["Circle"].tap()
        app.buttons["arrowRight"].tap()
        app.buttons["arrowRight"].tap()
        app.buttons["arrowRight"].tap()
        app.buttons["arrowRight"].tap()
        app.buttons["arrowRight"].tap()
        app.buttons["arrowRight"].tap()
        app.buttons["arrowRight"].tap()
        app.buttons["arrowRight"].tap()
        app.buttons["arrowRight"].tap()
        app.buttons["arrowRight"].tap()
        app.buttons["arrowRight"].tap()
        app.buttons["arrowRight"].tap()
        app.buttons["arrowRight"].tap()
        
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
