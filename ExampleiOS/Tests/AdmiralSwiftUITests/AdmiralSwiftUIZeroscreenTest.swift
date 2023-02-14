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
        
        app.buttons["Alerts"].tap()
        app.buttons["Zeroscreen"].tap()
        app.buttons["ZeroScreenButton"].tap()
        
        app.buttons["Ellipse"].tap()
        
        app.buttons["Dark"].tap()
        app.buttons["Light"].tap()
        app.buttons["SME Light"].tap()
        app.buttons["SME Dark"].tap()
        
        app.buttons["Ellipse"].tap()
    }
}
