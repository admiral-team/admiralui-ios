//
//  AdmiralSwiftUITagsAndChips.swift
//  AdmiralSwiftUITests
//

import XCTest

class AdmiralSwiftUITagsAndChips: XCTestCase {
    
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
    
    func testTagsAndChips() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["Tags & Chips"].tap()
        
        app.buttons["SegmentControlDisabled"].tap()
        app.buttons["SegmentControlDefault"].tap()
        
        app.buttons["DefaultRightButtonFirst"].tap()
        app.buttons["DefaultRightButtonSecond"].tap()
        
        app.buttons["Ellipse"].tap()
        
        app.buttons["Dark"].tap()
        app.buttons["SME Light"].tap()
        app.buttons["Light"].tap()
        app.buttons["SME Dark"].tap()
        
        app.buttons["Ellipse"].tap()
    }
}
