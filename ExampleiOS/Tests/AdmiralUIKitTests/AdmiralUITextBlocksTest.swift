//
//  AdmiralUIKitUITests.swift
//  AdmiralUIKitUITests
//

import XCTest
import ExampleiOS


class AdmiralUIKitTextBlockTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testHeader() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        app.tables.staticTexts["Text Blocks"].tap()
        app.staticTexts["Header"].tap()
        app.staticTexts["Headline Secondary"].tap()
        app.staticTexts["Title 1"].tap()
        app.buttons["Ellipse"].tap()
        app.staticTexts["Light"].tap()
        app.staticTexts["Dark"].tap()
        app.staticTexts["SME Light"].tap()
        app.staticTexts["SME Dark"].tap()
        app.buttons["Ellipse"].tap()
    }
    
    func testAccordion() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        app.tables.staticTexts["Text Blocks"].tap()
        app.staticTexts["Accordion"].tap()
        app.staticTexts["Disabled"].tap()
        app.staticTexts["Default"].tap()
        app.buttons["Ellipse"].tap()
        app.staticTexts["Light"].tap()
        app.staticTexts["Dark"].tap()
        app.staticTexts["SME Light"].tap()
        app.staticTexts["SME Dark"].tap()
        app.buttons["Ellipse"].tap()
    }
    
    func testParagraph() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        app.tables.staticTexts["Text Blocks"].tap()
        app.staticTexts["Paragraph"].tap()
        app.staticTexts["Disabled"].tap()
        app.staticTexts["Default"].tap()
        app.buttons["Ellipse"].tap()
        app.staticTexts["Light"].tap()
        app.staticTexts["Dark"].tap()
        app.staticTexts["SME Light"].tap()
        app.staticTexts["SME Dark"].tap()
        app.buttons["Ellipse"].tap()
    }
    
    func testLink() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        app.tables.staticTexts["Text Blocks"].tap()
        app.staticTexts["Link"].tap()
        app.staticTexts["Disabled"].tap()
        app.staticTexts["Default"].tap()
        app.buttons["Ellipse"].tap()
        app.staticTexts["Light"].tap()
        app.staticTexts["Dark"].tap()
        app.staticTexts["SME Light"].tap()
        app.staticTexts["SME Dark"].tap()
        app.buttons["Ellipse"].tap()
    }
    
    func testPadding() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        app.tables.staticTexts["Text Blocks"].tap()
        app.staticTexts["Padding"].tap()
        app.staticTexts["Disabled"].tap()
        app.staticTexts["Default"].tap()
        app.buttons["Ellipse"].tap()
        app.staticTexts["Light"].tap()
        app.staticTexts["Dark"].tap()
        app.staticTexts["SME Light"].tap()
        app.staticTexts["SME Dark"].tap()
        app.buttons["Ellipse"].tap()
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
