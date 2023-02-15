//
//  AddUIKitLinkTest.swift
//  AdmiralUIKitTests
//

import XCTest

class AddUIKitLinksTest: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
    }

    func testSwitcher() throws {
        let app = XCUIApplication()
        app.launch()
        
        checkFramework(width: app, framework: .UIKit)
        
        app.tables.staticTexts["Links"].tap()
        app.otherElements.matching(identifier: "SegmentControlDisabled").element.tap()
        app.otherElements.matching(identifier: "SegmentControlDefault").element.tap()
        
        app.otherElements.matching(identifier: "BigLink1").element.press(forDuration: 0.1)
        app.otherElements.matching(identifier: "BigLink2").element.press(forDuration: 0.1)
        app.otherElements.matching(identifier: "BigLink3").element.press(forDuration: 0.1)
        
        app.otherElements.matching(identifier: "SmallLink1").element.press(forDuration: 0.1)
        app.otherElements.matching(identifier: "SmallLink2").element.press(forDuration: 0.1)
        app.otherElements.matching(identifier: "SmallLink3").element.press(forDuration: 0.1)
        
        app.buttons["Ellipse"].tap()
        
        app.otherElements.matching(identifier: "ThemeSwitchButton_Light").element.tap()
        app.otherElements.matching(identifier: "ThemeSwitchButton_Dark").element.tap()
        app.otherElements.matching(identifier: "ThemeSwitchButton_SME Light").element.tap()
        app.otherElements.matching(identifier: "ThemeSwitchButton_SME Dark").element.tap()
        
        app.buttons["Ellipse"].tap()
    }
}
