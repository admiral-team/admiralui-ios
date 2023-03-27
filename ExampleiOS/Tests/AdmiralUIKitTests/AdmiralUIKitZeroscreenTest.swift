//
//  AdmiralUIKitZeroscreenTest.swift
//  AdmiralUIKitTests
//

import XCTest

class AdmiralUIKitZeroscreenTest: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
    }

    func testZeroscreen() throws {
        let app = XCUIApplication()
        app.launch()
        
        checkFramework(width: app, framework: .UIKit)
        
        app.tables.staticTexts["Alerts"].tap()
        app.tables.staticTexts["Zeroscreen"].tap()
        app.staticTexts["Хорошо"].tap()
    }
}
