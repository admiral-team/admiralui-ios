//
//  AdmiralUIKitErrorViewTest.swift
//  AdmiralUIKitTests
//

import XCTest

class AdmiralUIKitErrorViewTest: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
    }

    func testErrorView() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.tables.staticTexts["Alerts"].tap()
        app.tables.staticTexts["Error View"].tap()
        app.staticTexts["Хорошо"].tap()
        
        app.buttons["Ellipse"].tap()
        
        app.staticTexts["Light"].tap()
        app.staticTexts["Dark"].tap()
        app.staticTexts["SME Light"].tap()
        app.staticTexts["SME Dark"].tap()
        
        app.buttons["Ellipse"].tap()
    }
}
