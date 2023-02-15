//
//  AdmiralSwiftUIToolbarTest.swift
//  AdmiralSwiftUITests
//

import XCTest

class AdmiralSwiftUIToolbarTest: XCTestCase {
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    override func tearDownWithError() throws {
    }
    
    func testToolbar() throws {
        let app = XCUIApplication()
        app.launch()
        
        checkFramework(width: app, framework: .switUI)
        
        app.buttons["Tool bar"].tap()
        app.buttons["ToolbarAdd"].tap()
        app.buttons["ToolbarDetail"].tap()
        app.buttons["ToolbarSetting"].tap()
        app.buttons["ToolbarPay"].tap()
        
        for _ in 0..<3 {
            app.buttons["InputNumberToolbar.minus"].tap()
        }
        for _ in 0..<3 {
            app.buttons["InputNumberToolbar.plus"].tap()
        }
        
        app.buttons["Ellipse"].tap()
        
        app.buttons["ThemeSwitchButton_Dark"].tap()
        app.buttons["ThemeSwitchButton_SME Light"].tap()
        app.buttons["ThemeSwitchButton_SME Dark"].tap()
        app.buttons["ThemeSwitchButton_Light"].tap()
        
        app.buttons["Ellipse"].tap()
    }
}
