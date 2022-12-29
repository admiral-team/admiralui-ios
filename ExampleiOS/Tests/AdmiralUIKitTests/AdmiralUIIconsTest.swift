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
        
        app.tables.staticTexts["Icons"].tap()
        app.otherElements.matching(identifier: "SegmentControlSolid").element.tap()
        app.otherElements.matching(identifier: "SegmentControlOutline").element.tap()
        
        app.windows.children(matching: .other).element.swipeUp()
        app.windows.children(matching: .other).element.swipeDown()
        
        changeThemes(app: app)
        
        _ = app.textFields["Поиск"]
        app.textFields["Поиск"].tap()
        app.textFields["Поиск"].typeText("Bank")
        app.buttons["closeSolid"].tap()
    }
    
    func changeThemes(app: XCUIApplication) {
        app.buttons["Ellipse"].tap()
        
        app.otherElements.matching(identifier: "ThemeSwitchButton_Light").element.tap()
        app.otherElements.matching(identifier: "ThemeSwitchButton_Dark").element.tap()
        app.otherElements.matching(identifier: "ThemeSwitchButton_SME Light").element.tap()
        app.otherElements.matching(identifier: "ThemeSwitchButton_SME Dark").element.tap()
        
        app.buttons["Ellipse"].tap()
    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
