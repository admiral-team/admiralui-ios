//
//  AdmiralSwiftUISpinnerTest.swift
//  AdmiralSwiftUITests
//

import XCTest

class AdmiralSwiftUISpinnerTest: XCTestCase {
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    override func tearDownWithError() throws {
    }
    
    func testSpinner() throws {
        let app = XCUIApplication()
        app.launch()
        
        checkFramework(width: app, framework: .switUI)
        
        app.buttons["Spinner"].tap()
        
        app.buttons["SpinnerMedium"].tap()
        app.buttons["SpinnerBig"].tap()
        app.buttons["SpinnerSmall"].tap()
        
        app.buttons["Ellipse"].tap()
        
        app.buttons["Dark"].tap()
        app.buttons["SME Light"].tap()
        app.buttons["Light"].tap()
        app.buttons["Dark"].tap()
        
        app.buttons["Ellipse"].tap()
    }
}
