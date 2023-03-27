//
//  AdmiralSwiftUIThemesTest.swift
//  AdmiralSwiftUITests
//

import XCTest

class AdmiralSwiftUIThemesTest: XCTestCase {
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    override func tearDownWithError() throws {
    }
    
    func testThemes() throws {
        let app = XCUIApplication()
        app.launch()
        
        checkFramework(width: app, framework: .switUI)
        
        app.buttons["Themes"].tap()
        app.cells["Light"].tap()
        app.buttons["Применить"].tap()
        app.cells["Dark"].tap()
        app.buttons["Применить"].tap()
        app.cells["SME Light"].tap()
        app.buttons["Применить"].tap()
        app.cells["SME Dark"].tap()
        app.buttons["Применить"].tap()
    }
}
