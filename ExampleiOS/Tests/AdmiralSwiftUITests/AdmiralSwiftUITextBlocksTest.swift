//
//  AdmiralSwiftUITextBlocksTest.swift
//  AdmiralSwiftUITests
//

import XCTest

class AdmiralSwiftUITextBlocksTest: XCTestCase {
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    override func tearDownWithError() throws {
    }
    
    func testCheckSwiftUI() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["SeatingTabBarItem"].tap()
        let swiftUISwitcher = app.switches["SwitchToSwiftUI"]
        
        if swiftUISwitcher.value as? String == "0" {
            swiftUISwitcher.tap()
        }
    }
    
    func testHeader() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["Text Blocks, Текстовые блоки"].tap()
        app.buttons["Header"].tap()
        
        changeThemes(app: app)
        
        app.buttons["HeadlineTitleArrowWithButtonHeader"].tap()
        app.buttons["Title1TitleArrowWithButtonHeader"].tap()
    }
    
    func testAccordion() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["Text Blocks, Текстовые блоки"].tap()
        app.buttons["Accordion"].tap()
        
        app.buttons["SegmentControlDisabled"].tap()
        app.buttons["SegmentControlDefault"].tap()
        
        changeThemes(app: app)
        
        app.buttons["ButtonDropDown"].press(forDuration: 2)
        app.buttons["TitleButtonDropDown"].press(forDuration: 2)
    }
    
    func testParagraph() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["Text Blocks, Текстовые блоки"].tap()
        app.buttons["Paragraph"].tap()
        
        changeThemes(app: app)
        
        app.buttons["SegmentControlDisabled"].tap()
        app.buttons["SegmentControlDefault"].tap()
    }
    
    func testLink() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["Text Blocks, Текстовые блоки"].tap()
        app.buttons["Link"].tap()
        
        app.buttons["SegmentControlDisabled"].tap()
        app.buttons["SegmentControlDefault"].tap()
        
        changeThemes(app: app)
        
        app.buttons["ButtonBank"].press(forDuration: 2)
    }
    
    func testPadding() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["Text Blocks, Текстовые блоки"].tap()
        app.buttons["Padding"].tap()
        
        app.buttons["SegmentControlDisabled"].tap()
        app.buttons["SegmentControlDefault"].tap()
        
        changeThemes(app: app)
    }
    
    func changeThemes(app: XCUIApplication) {
        app.buttons["Ellipse"].tap()
        
        app.buttons["Dark"].tap()
        app.buttons["SME Light"].tap()
        app.buttons["SME Dark"].tap()
        app.buttons["Light"].tap()
        
        app.buttons["Ellipse"].tap()
    }
}