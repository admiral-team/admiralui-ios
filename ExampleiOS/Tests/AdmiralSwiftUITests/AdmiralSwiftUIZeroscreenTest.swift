//
//  AdmiralSwiftUIZeroscreenTest.swift
//  AdmiralSwiftUITests
//

import XCTest

class AdmiralSwiftUIZeroscreenTest: XCTestCase {
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    override func tearDownWithError() throws {
    }
    
    func testZeroscreen() throws {
        let app = XCUIApplication()
        app.launch()
        
        checkFramework(width: app, framework: .switUI)
        
        app.buttons["Alerts"].tap()
        app.buttons["Zeroscreen"].tap()
        app.buttons["ZeroScreenButton"].tap()
        
        app.buttons["Ellipse"].tap()
        
        app.buttons["ThemeSwitchButton_Dark"].tap()
        app.buttons["ThemeSwitchButton_SME Light"].tap()
        app.buttons["ThemeSwitchButton_SME Dark"].tap()
        app.buttons["ThemeSwitchButton_Light"].tap()
        
        app.buttons["Ellipse"].tap()
    }
}
