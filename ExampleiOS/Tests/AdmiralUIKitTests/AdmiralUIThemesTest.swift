//
//  AdmiralUIKitUITests.swift
//  AdmiralUIKitUITests
//

import XCTest

class AdmiralUIKitThemesTests: XCTestCase {
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    override func tearDownWithError() throws {
    }
    
    func testThemes() throws {
        let app = XCUIApplication()
        app.launch()
        
        checkFramework(width: app, framework: .UIKit)
        
        app.tables.staticTexts["Themes"].tap()
        app.tables.staticTexts["Light"].tap()
        app.buttons["Применить"].tap()
        app.tables.staticTexts["Dark"].tap()
        app.buttons["Применить"].tap()
        app.tables.staticTexts["SME Light"].tap()
        app.buttons["Применить"].tap()
        app.tables.staticTexts["SME Dark"].tap()
        app.buttons["Применить"].tap()
    }
}
