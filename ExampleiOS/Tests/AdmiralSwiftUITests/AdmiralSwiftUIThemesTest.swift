//
//  AdmiralSwiftUIThemesTest.swift
//  AdmiralSwiftUITests
//

import XCTest

class AdmiralSwiftUIThemesTest: XCTestCase {
    
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
    
    func testThemes() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["Themes"].tap()
        app.cells["Light"].tap()
        app.buttons["Применить"].tap()
        app.cells["Dark"].tap()
        app.buttons["Применить"].tap()
        app.cells["SME Light"].tap()
        app.buttons["Применить"].tap()
        app.cells["SME Dark"].tap()
        app.buttons["Применить"].tap()
    }
}
