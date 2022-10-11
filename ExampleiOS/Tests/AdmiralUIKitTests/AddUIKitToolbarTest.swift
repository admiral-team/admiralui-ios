//
//  AddUIKitToolbarTest.swift
//  AdmiralUIKitTests
//

import XCTest

class AddUIKitToolbarTest: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
    }

    func testToolbar() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.tables.staticTexts["Tool bar"].tap()

        app.buttons["minusOutline"].tap()
        app.buttons["minusOutline"].tap()
        app.buttons["minusOutline"].tap()
        app.buttons["plusOutline"].tap()
        app.buttons["plusOutline"].tap()
        app.buttons["plusOutline"].tap()
        
        app.buttons["Ellipse"].tap()
        
        app.staticTexts["Light"].tap()
        app.staticTexts["Dark"].tap()
        app.staticTexts["SME Light"].tap()
        app.staticTexts["SME Dark"].tap()
        
        app.buttons["Ellipse"].tap()
    }
}
