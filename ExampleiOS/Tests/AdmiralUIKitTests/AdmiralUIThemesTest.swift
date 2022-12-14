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
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
