//
//  AdmiralUIRadiobuttonTest.swift
//  AdmiralUIKitTests
//

import XCTest

class AdmiralUIRadiobuttonTest: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
    }

    func testExample() throws {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let app = XCUIApplication()
        app.launch()
        
        app.tables.staticTexts["Radiobutton"].tap()
        app.staticTexts["Disabled"].tap()
        app.staticTexts["Default"].tap()    
    }

}
