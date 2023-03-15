//
//  AdmiralSwiftUICheckboxTest.swift
//  AdmiralSwiftUITests
//

import XCTest

class AdmiralSwiftUICheckboxTest: XCTestCase {
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    override func tearDownWithError() throws {
    }
    
    func testCheckbox() throws {
        let app = XCUIApplication()
        app.launch()
        
        checkFramework(width: app, framework: .switUI)
        
        app.buttons["Сheckbox"].tap()
        
        app.buttons["SegmentControlDisabled"].tap()
        app.buttons["SegmentControlDefault"].tap()
        
        app.otherElements.matching(identifier: "DefaultCheckBoxFirst").element.tap()
        app.otherElements.matching(identifier: "DefaultCheckBoxSecond").element.tap()
        
        app.otherElements.matching(identifier: "SelectedCheckBoxFirst").element.tap()
        app.otherElements.matching(identifier: "SelectedCheckBoxSecond").element.tap()
        
        app.otherElements.matching(identifier: "ErrorCheckBoxFirst").element.tap()
        app.otherElements.matching(identifier: "ErrorCheckBoxSecond").element.tap()
        
        app.buttons["Ellipse"].tap()
        
        app.buttons["ThemeSwitchButton_Dark"].tap()
        app.buttons["ThemeSwitchButton_SME Light"].tap()
        app.buttons["ThemeSwitchButton_SME Dark"].tap()
        app.buttons["ThemeSwitchButton_Light"].tap()
        
        app.buttons["Ellipse"].tap()
    }
}