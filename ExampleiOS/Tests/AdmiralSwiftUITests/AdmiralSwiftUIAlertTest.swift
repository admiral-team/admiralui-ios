//
//  AdmiralSwiftUIAlertTest.swift
//  AdmiralSwiftUITests
//

import XCTest

class AdmiralSwiftUIAlertTest: XCTestCase {
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    override func tearDownWithError() throws {
    }
    
    func testAlert() throws {
        let app = XCUIApplication()
        app.launch()
        
        checkFramework(width: app, framework: .switUI)
        
        app.buttons["Alerts"].tap()
        app.buttons["Alert"].tap()
        app.buttons["Show Alert"].tap()
        sleep(2)
        app.buttons["AlertView.mainButton"].tap()
        app.buttons["Show Alert"].tap()
        sleep(2)
        app.buttons["AlertView.additionalButton"].tap()
        
        app.buttons["Ellipse"].tap()
        
        app.buttons["Dark"].tap()
        app.buttons["SME Light"].tap()
        app.buttons["SME Dark"].tap()
        app.buttons["Light"].tap()
        
        app.buttons["Ellipse"].tap()
    }
}
