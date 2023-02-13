//
//  AdmiralSwiftUILinksTest.swift
//  AdmiralSwiftUITests
//

import XCTest

class AdmiralSwiftUILinksTest: XCTestCase {
    
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
    
    func testLinks() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["Links"].tap()
        
        app.buttons["SegmentControlDisabled"].tap()
        app.buttons["SegmentControlDefault"].tap()
        
        app.buttons["24LinkFirst"].press(forDuration: 2)
        app.buttons["24LinkSecond"].press(forDuration: 2)
        app.buttons["24LinkThird"].press(forDuration: 2)
        
        app.buttons["18LinkFirst"].press(forDuration: 2)
        app.buttons["18LinkSecond"].press(forDuration: 2)
        app.buttons["18LinkThird"].press(forDuration: 2)
        
        app.buttons["Ellipse"].tap()
        
        app.buttons["Dark"].tap()
        app.buttons["SME Light"].tap()
        app.buttons["Light"].tap()
        app.buttons["SME Dark"].tap()
        
        app.buttons["Ellipse"].tap()
    }
}
