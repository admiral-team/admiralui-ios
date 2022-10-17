//
//  AddSwiftUIThemesTest.swift
//  AdmiralSwiftUITests
//

import XCTest

class AddSwiftUIThemesTest: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
    }

    func testThemes() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["Themes, Цветовая палитра и схема"].tap()

        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Light"]/*[[".cells.staticTexts[\"Light\"]",".staticTexts[\"Light\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Применить"].tap()
        app.tables.staticTexts["Dark"].tap()
        app.buttons["Применить"].tap()
        app.tables.staticTexts["SME Light"].tap()
        app.buttons["Применить"].tap()
        app.tables.staticTexts["SME Dark"].tap()
        app.buttons["Применить"].tap()
    }
}
