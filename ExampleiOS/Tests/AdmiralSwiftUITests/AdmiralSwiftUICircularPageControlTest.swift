//
//  AdmiralSwiftUICircularPageControlTest.swift
//  AdmiralSwiftUITests
//

import XCTest

class AdmiralSwiftUICircularPageControlTest: XCTestCase {

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
    
    func testCircularPageControl() {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["Page Controls"].tap()
        app.buttons["Circular"].tap()
        
        app.buttons["NextCircularPageControll"].tap(withNumberOfTaps: 10, numberOfTouches: 1)
    }
}
