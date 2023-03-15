//
//  AdmiralSwiftUIRadiobuttonTest.swift
//  AdmiralSwiftUITests
//

import XCTest

class AdmiralSwiftUIRadiobuttonTest: XCTestCase {
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    override func tearDownWithError() throws {
    }
    
    func testRadiobutton() throws {
        let app = XCUIApplication()
        app.launch()
        
        checkFramework(width: app, framework: .switUI)
        
        app.buttons["Radiobutton"].tap()
        
        app.buttons["SegmentControlDisabled"].tap()
        app.buttons["SegmentControlDefault"].tap()
        
        app.otherElements.matching(identifier: "DefaultRadioButtonFirst").element.tap()
        app.otherElements.matching(identifier: "DefaultRadioButtonSecond").element.tap()
        
        app.otherElements.matching(identifier: "SelectedRadioButtonFirst").element.tap()
        app.otherElements.matching(identifier: "SelectedRadioButtonSecond").element.tap()
        
        app.otherElements.matching(identifier: "ErrorRadioButtonFirst").element.tap()
        app.otherElements.matching(identifier: "ErrorRadioButtonSecond").element.tap()
        
        app.buttons["Ellipse"].tap()
        
        app.buttons["ThemeSwitchButton_Dark"].tap()
        app.buttons["ThemeSwitchButton_SME Light"].tap()
        app.buttons["ThemeSwitchButton_SME Dark"].tap()
        app.buttons["ThemeSwitchButton_Light"].tap()
        
        app.buttons["Ellipse"].tap()
    }
}