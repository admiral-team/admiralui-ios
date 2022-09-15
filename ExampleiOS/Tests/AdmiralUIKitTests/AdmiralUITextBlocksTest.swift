//
//  AdmiralUIKitUITests.swift
//  AdmiralUIKitUITests
//

import XCTest
import ExampleiOS


class AdmiralUIKitTextBlockTests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
    }

    func testHeader() throws {
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
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
