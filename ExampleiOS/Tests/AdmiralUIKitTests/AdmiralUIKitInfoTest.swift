//
//  AdmiralUIKitInfoTest.swift
//  AdmiralUIKitTests
//

import XCTest

class AdmiralUIKitInfoTest: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
    }

    func testInfoLight() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["Ellipse"].tap()
        
        app.staticTexts["Light"].tap()
        
        app.buttons["Ellipse"].tap()
        
        app.buttons["Инфо"].tap()
        app.tables.staticTexts["Инфо"].tap()
    }
    
    func testInfoDark() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["Ellipse"].tap()
        
        app.staticTexts["Dark"].tap()
        
        app.buttons["Ellipse"].tap()
        
        app.buttons["Инфо"].tap()
        app.tables.staticTexts["Инфо"].tap()
    }
}
