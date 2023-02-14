//
//  AdmiralSwiftUILinerPageControl.swift
//  AdmiralSwiftUITests
//

import XCTest

class AdmiralSwiftUILinerPageControl: XCTestCase {
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    override func tearDownWithError() throws {
    }
    
    func testLinerPageControl() throws {
        let app = XCUIApplication()
        app.launch()
        
        checkFramework(width: app, framework: .switUI)
        
        app.buttons["Page Controls"].tap()
        app.buttons["Liner"].tap()
        
        for _ in 0..<10 {
            app.buttons["NextLinerPageControll"].tap()
        }
        app.buttons["Ellipse"].tap()
        
        app.buttons["Dark"].tap()
        app.buttons["SME Light"].tap()
        app.buttons["SME Dark"].tap()
        app.buttons["Light"].tap()
        
        app.buttons["Ellipse"].tap()
    }
}
