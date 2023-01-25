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
    
    func testCheckSwiftUI() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["SeatingTabBarItem"].tap()
        let swiftUISwitcher = app.switches["SwitchToSwiftUI"]
        
        if swiftUISwitcher.value as? String == "0" {
            swiftUISwitcher.tap()
        }
    }
    
    func testLinerPageControl() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["Page Controls"].tap()
        app.buttons["Liner"].tap()
        app.buttons["NextLinerPageControll"].tap(withNumberOfTaps: 10, numberOfTouches: 1)
        
        app.buttons["Ellipse"].tap()
        
        app.buttons["Dark"].tap()
        app.buttons["SME Light"].tap()
        app.buttons["SME Dark"].tap()
        app.buttons["Light"].tap()
        
        app.buttons["Ellipse"].tap()
    }
}
