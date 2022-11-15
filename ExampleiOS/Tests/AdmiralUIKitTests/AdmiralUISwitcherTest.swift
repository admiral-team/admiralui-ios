//
//  AdmiralUISwitcherTest.swift
//  AdmiralUIKitTests
//

import XCTest

class AdmiralUISwitcherTest: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
    }

    func testSwitcher() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.tables.staticTexts["Switcher"].tap()
        app.staticTexts["Disabled"].tap()
        app.staticTexts["Default"].tap()
        
        app.switches["SwitcherOne"].tap()
        app.switches["SwitcherTwo"].tap()
        
        app.buttons["Ellipse"].tap()
        
        app.staticTexts["Light"].tap()
        app.staticTexts["Dark"].tap()
        app.staticTexts["SME Light"].tap()
        app.staticTexts["SME Dark"].tap()
        
        app.buttons["Ellipse"].tap()
    }
}
