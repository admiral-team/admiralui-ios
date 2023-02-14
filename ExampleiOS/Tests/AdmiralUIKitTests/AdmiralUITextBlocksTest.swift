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
        
        checkFramework(width: app, framework: .UIKit)
        
        app.tables.staticTexts["Text Blocks"].tap()
        app.staticTexts["Header"].tap()
        app.staticTexts["Headline Secondary"].tap()
        app.staticTexts["Title 1"].tap()
        
        changeThemes(app: app)
    }
    
    func testAccordion() throws {
        let app = XCUIApplication()
        app.launch()
        
        checkFramework(width: app, framework: .UIKit)
        
        app.tables.staticTexts["Text Blocks"].tap()
        app.staticTexts["Accordion"].tap()
        app.otherElements.matching(identifier: "SegmentControlDisabled").element.tap()
        app.otherElements.matching(identifier: "SegmentControlDefault").element.tap()
        
        changeThemes(app: app)
    }
    
    func testParagraph() throws {
        let app = XCUIApplication()
        app.launch()
        
        checkFramework(width: app, framework: .UIKit)
        
        app.tables.staticTexts["Text Blocks"].tap()
        app.staticTexts["Paragraph"].tap()
        app.otherElements.matching(identifier: "SegmentControlDisabled").element.tap()
        app.otherElements.matching(identifier: "SegmentControlDefault").element.tap()
        
        changeThemes(app: app)
    }
    
    func testLink() throws {
        let app = XCUIApplication()
        app.launch()
        
        checkFramework(width: app, framework: .UIKit)
        
        app.tables.staticTexts["Text Blocks"].tap()
        app.staticTexts["Link"].tap()
        app.otherElements.matching(identifier: "SegmentControlDisabled").element.tap()
        app.otherElements.matching(identifier: "SegmentControlDefault").element.tap()
        
        app.staticTexts["Подробнее на сайте банка"].press(forDuration: 2)
        
        changeThemes(app: app)
    }
    
    func testPadding() throws {
        let app = XCUIApplication()
        app.launch()
        
        checkFramework(width: app, framework: .UIKit)
        
        app.tables.staticTexts["Text Blocks"].tap()
        app.staticTexts["Padding"].tap()
        app.otherElements.matching(identifier: "SegmentControlDisabled").element.tap()
        app.otherElements.matching(identifier: "SegmentControlDefault").element.tap()
        
        changeThemes(app: app)
    }
    
    func changeThemes(app: XCUIApplication) {
        app.buttons["Ellipse"].tap()
        
        checkFramework(width: app, framework: .UIKit)
        
        app.otherElements.matching(identifier: "ThemeSwitchButton_Light").element.tap()
        app.otherElements.matching(identifier: "ThemeSwitchButton_Dark").element.tap()
        app.otherElements.matching(identifier: "ThemeSwitchButton_SME Light").element.tap()
        app.otherElements.matching(identifier: "ThemeSwitchButton_SME Dark").element.tap()
        
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
