//
//  AdmiralUIKitAllertTest.swift
//  AdmiralUIKitTests
//

import XCTest

class AdmiralUIKitAllertTest: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
    }

    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.tables.staticTexts["Alerts"].tap()
        app.tables.staticTexts["Alert"].tap()
        app.staticTexts["Показать Alert"].tap()
        app.staticTexts["Хорошо"].tap()
        app.staticTexts["Показать Alert"].tap()
        app.staticTexts["Отмена"].tap()
        
        app.buttons["Ellipse"].tap()
        
        app.staticTexts["Light"].tap()
        app.staticTexts["Dark"].tap()
        app.staticTexts["SME Light"].tap()
        app.staticTexts["SME Dark"].tap()
        
        app.buttons["Ellipse"].tap()
    }
}
