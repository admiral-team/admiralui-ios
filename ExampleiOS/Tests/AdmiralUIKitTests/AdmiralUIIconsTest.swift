//
//  AdmiralUIKitUITests.swift
//  AdmiralUIKitUITests
//

import XCTest
import ExampleiOS

class AdmiralUIKitIconsTest: XCTestCase {
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    override func tearDownWithError() throws {
    }
    
    func testIcons() throws {
        let app = XCUIApplication()
        app.launch()
        
        checkFramework(width: app, framework: .UIKit)
        
        app.tables.staticTexts["Icons"].tap()
        app.otherElements.matching(identifier: "SegmentControlSolid").element.tap()
        app.otherElements.matching(identifier: "SegmentControlOutline").element.tap()
        
        changeThemes(app: app)
        
        _ = app.textFields["Поиск"]
        app.textFields["Поиск"].tap()
        app.textFields["Поиск"].typeText("Bank")
        app.buttons["closeSolid"].tap()
    }
    
    func changeThemes(app: XCUIApplication) {
        app.buttons["Ellipse"].tap()
        
        checkFramework(width: app, framework: .UIKit)
        
        app.otherElements.matching(identifier: "ThemeSwitchButton_Light").element.tap()
        app.otherElements.matching(identifier: "ThemeSwitchButton_Dark").element.tap()
        app.otherElements.matching(identifier: "ThemeSwitchButton_SME Light").element.tap()
        app.otherElements.matching(identifier: "ThemeSwitchButton_SME Dark").element.tap()
        
        app.buttons["Ellipse"].tap()
    }
}
