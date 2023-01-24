//
//  AdmiralSwiftUISwitcherTest.swift
//  AdmiralSwiftUITests
//

import XCTest

class AdmiralSwiftUISwitcherTest: XCTestCase {
    
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
    
    func testSwitcher() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["Switcher, Переключатель"].tap()
        
        app.buttons["SegmentControlDisabled"].tap()
        app.buttons["SegmentControlDefault"].tap()
        
        app.otherElements.matching(identifier: "SwitcherOn").element.tap()
        app.otherElements.matching(identifier: "SwitcherOff").element.tap()
        
        app.buttons["Ellipse"].tap()
        
        app.buttons["Dark"].tap()
        app.buttons["SME Light"].tap()
        app.buttons["Light"].tap()
        app.buttons["SME Dark"].tap()
        
        app.buttons["Ellipse"].tap()
    }
}
