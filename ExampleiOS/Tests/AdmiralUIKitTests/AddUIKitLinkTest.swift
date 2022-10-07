//
//  AddUIKitLinkTest.swift
//  AdmiralUIKitTests
//

import XCTest

class AddUIKitLinksTest: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
    }

    func testSwitcher() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.tables.staticTexts["Links"].tap()
        app.staticTexts["Disabled"].tap()
        app.staticTexts["Default"].tap()
        
        app.buttons["Ellipse"].tap()
        
        app.staticTexts["Light"].tap()
        app.staticTexts["Dark"].tap()
        app.staticTexts["SME Light"].tap()
        app.staticTexts["SME Dark"].tap()
        
        app.buttons["Ellipse"].tap()
    }
}
