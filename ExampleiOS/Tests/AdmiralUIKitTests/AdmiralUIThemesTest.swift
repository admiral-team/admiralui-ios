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
        
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Themes"]/*[[".cells.staticTexts[\"Themes\"]",".staticTexts[\"Themes\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Light"]/*[[".cells.staticTexts[\"Light\"]",".staticTexts[\"Light\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Применить"].tap()
        app.tables.staticTexts["Dark"].tap()
        app.buttons["Применить"].tap()
        app.tables.staticTexts["SME Light"].tap()
        app.buttons["Применить"].tap()
        app.tables.staticTexts["SME Dark"].tap()
        app.buttons["Применить"].tap()
    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
