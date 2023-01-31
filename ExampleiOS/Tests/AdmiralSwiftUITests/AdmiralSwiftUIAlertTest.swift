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
    
    func testCheckSwiftUI() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["SeatingTabBarItem"].tap()
        let swiftUISwitcher = app.switches["SwitchToSwiftUI"]
        
        if swiftUISwitcher.value as? String == "0" {
            swiftUISwitcher.tap()
        }
    }
    
    func testAlert() throws {
        let app = XCUIApplication()
        app.launch()
        
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
