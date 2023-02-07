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
    
    func testCheckSwiftUI() throws {
        let app = XCUIApplication()
        app.launch()
        
    }
    
    func testToolbar() throws {
        let app = XCUIApplication()
        app.launch()
        
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
        
        app.buttons["Dark"].tap()
        app.buttons["SME Light"].tap()
        app.buttons["Light"].tap()
        app.buttons["SME Dark"].tap()
        
        app.buttons["Ellipse"].tap()
    }
}
