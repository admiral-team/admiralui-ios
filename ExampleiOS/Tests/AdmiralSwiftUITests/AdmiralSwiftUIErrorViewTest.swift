//
//  AdmiralSwiftUIErrorViewTest.swift
//  AdmiralSwiftUITests
//

import XCTest

class AdmiralSwiftUIErrorViewTest: XCTestCase {
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    override func tearDownWithError() throws {
    }
    
    func testErrorView() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["Alerts"].tap()
        app.buttons["Error View"].tap()
        app.buttons["ErrorViewButton"].tap()
        
        app.buttons["Ellipse"].tap()
        
        app.buttons["Dark"].tap()
        app.buttons["Light"].tap()
        app.buttons["SME Light"].tap()
        app.buttons["SME Dark"].tap()
        
        app.buttons["Ellipse"].tap()
    }
}
