//
//  AddUIKitShimmersTest.swift
//  AdmiralUIKitTests
//

import XCTest

class AddUIKitShimmersTest: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
    }

    func testShimmers() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.tables.staticTexts["Shimmers"].tap()
        
        app.buttons["Ellipse"].tap()
        
        app.staticTexts["Light"].tap()
        app.staticTexts["Dark"].tap()
        app.staticTexts["SME Light"].tap()
        app.staticTexts["SME Dark"].tap()
        
        app.buttons["Ellipse"].tap()
    }
}
