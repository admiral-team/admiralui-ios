//
//  AdmiralUIRadiobuttonTest.swift
//  AdmiralUIKitTests
//

import XCTest

class AdmiralUIRadiobuttonTest: XCTestCase {
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    override func tearDownWithError() throws {
    }
    
    func testRadiobutton() throws {
        let app = XCUIApplication()
        app.launch()
        
        checkFramework(width: app, framework: .UIKit)
        
        app.tables.staticTexts["Radiobutton"].tap()
        app.otherElements.matching(identifier: "SegmentControlDisabled").element.tap()
        app.otherElements.matching(identifier: "SegmentControlDefault").element.tap()
        
        
        app.otherElements.matching(identifier: "RadioControlsFirstDefault").element.tap()
        app.otherElements.matching(identifier: "RadioControlsSecondDefault").element.tap()
        
        app.otherElements.matching(identifier: "RadioControlsFirstSelected").element.tap()
        app.otherElements.matching(identifier: "RadioControlsSecondSelected").element.tap()
        
        app.otherElements.matching(identifier: "RadioControlsFirstError").element.tap()
        app.otherElements.matching(identifier: "RadioControlsSecondError").element.tap()
        
        app.buttons["Ellipse"].tap()
        
        app.otherElements.matching(identifier: "ThemeSwitchButton_Light").element.tap()
        app.otherElements.matching(identifier: "ThemeSwitchButton_Dark").element.tap()
        app.otherElements.matching(identifier: "ThemeSwitchButton_SME Light").element.tap()
        app.otherElements.matching(identifier: "ThemeSwitchButton_SME Dark").element.tap()
        
        app.buttons["Ellipse"].tap()
    }
}
