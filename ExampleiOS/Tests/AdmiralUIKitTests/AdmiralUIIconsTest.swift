//
//  AdmiralUIKitUITests.swift
//  AdmiralUIKitUITests
//

import XCTest

class AdmiralUIKitIconsTest: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
    }

    func testIcons() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Icons"]/*[[".cells.staticTexts[\"Icons\"]",".staticTexts[\"Icons\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.otherElements.matching(identifier: "SegmentControlSolid").element.tap()
        app.otherElements.matching(identifier: "SegmentControlOutline").element.tap()
        
        app.windows.children(matching: .other).element.swipeUp()
        app.windows.children(matching: .other).element.swipeDown()
        
        app.buttons["Ellipse"].tap()
        
        app.staticTexts["Light"].tap()
        app.staticTexts["Dark"].tap()
        app.staticTexts["SME Light"].tap()
        app.staticTexts["SME Dark"].tap()
        
        app.buttons["Ellipse"].tap()
        
        _ = app.textFields["Поиск"]
        app.textFields["Поиск"].tap()
        app.textFields["Поиск"].typeText("Bank")
        app.buttons["closeSolid"].tap()
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
