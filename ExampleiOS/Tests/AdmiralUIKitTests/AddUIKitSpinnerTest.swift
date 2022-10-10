//
//  AddUIKitSpinnerTest.swift
//  AdmiralUIKitTests
//

import XCTest

class AddUIKitSpinnerTest: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
    }

    func testSpinner() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.tables.staticTexts["Spinner"].tap()
        app.staticTexts["Medium"].tap()
        app.staticTexts["Big"].tap()
        app.staticTexts["Small"].tap()
        
        app.buttons["Ellipse"].tap()
        
        app.staticTexts["Light"].tap()
        app.staticTexts["Dark"].tap()
        app.staticTexts["SME Light"].tap()
        app.staticTexts["SME Dark"].tap()
        
        app.buttons["Ellipse"].tap()
    }
}
