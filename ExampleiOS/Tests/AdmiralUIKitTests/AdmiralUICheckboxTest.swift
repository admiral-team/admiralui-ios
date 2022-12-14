//
//  AdmiralUICheckboxTest.swift
//  AdmiralUIKitTests
//

import XCTest

class AdmiralUICheckboxTest: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
    }

    func testCheckbox() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.tables.staticTexts["Checkbox"].tap()
        
        app.otherElements.matching(identifier: "SegmentControlDisabled").element.tap()
        app.otherElements.matching(identifier: "SegmentControlDefault").element.tap()
        
        app.otherElements.matching(identifier: "FirstCheckBoxesCellViewFirstControl").element.tap()
        app.otherElements.matching(identifier: "FirstCheckBoxesCellViewSecondControl").element.tap()
        
        app.otherElements.matching(identifier: "SecondCheckBoxesCellViewFirstControl").element.tap()
        app.otherElements.matching(identifier: "SecondCheckBoxesCellViewSecondControl").element.tap()
        
        app.otherElements.matching(identifier: "ThirdCheckBoxesCellViewFirstControl").element.tap()
        app.otherElements.matching(identifier: "ThirdCheckBoxesCellViewSecondControl").element.tap()
        
        app.buttons["Ellipse"].tap()
                
        app.otherElements.matching(identifier: "ThemeSwitchButton_Light").element.tap()
        app.otherElements.matching(identifier: "ThemeSwitchButton_Dark").element.tap()
        app.otherElements.matching(identifier: "ThemeSwitchButton_SME Light").element.tap()
        app.otherElements.matching(identifier: "ThemeSwitchButton_SME Dark").element.tap()
        
        app.buttons["Ellipse"].tap()
    }
}
