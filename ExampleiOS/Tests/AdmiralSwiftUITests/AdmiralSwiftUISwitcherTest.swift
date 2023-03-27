//
//  AdmiralSwiftUISwitcherTest.swift
//  AdmiralSwiftUITests
//

import XCTest

class AdmiralSwiftUISwitcherTest: XCTestCase {
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    override func tearDownWithError() throws {
    }
    
    func testSwitcher() throws {
        let app = XCUIApplication()
        app.launch()
        
        checkFramework(width: app, framework: .switUI)
        
        app.buttons["Switcher"].tap()
        
        app.buttons["SegmentControlDisabled"].tap()
        app.buttons["SegmentControlDefault"].tap()
        
        app.otherElements.matching(identifier: "SwitcherOn").element.tap()
        app.otherElements.matching(identifier: "SwitcherOff").element.tap()
        
        app.buttons["Ellipse"].tap()
        
        app.buttons["ThemeSwitchButton_Dark"].tap()
        app.buttons["ThemeSwitchButton_SME Light"].tap()
        app.buttons["ThemeSwitchButton_SME Dark"].tap()
        app.buttons["ThemeSwitchButton_Light"].tap()
        
        app.buttons["Ellipse"].tap()
    }
}
