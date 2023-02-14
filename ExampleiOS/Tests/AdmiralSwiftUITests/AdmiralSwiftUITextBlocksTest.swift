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
    
    func testHeader() throws {
        let app = XCUIApplication()
        app.launch()
        
        checkFramework(width: app, framework: .switUI)
        
        app.buttons["Text Blocks"].tap()
        app.buttons["Header"].tap()
        
        changeThemes(app: app)
        
        app.buttons["HeadlineTitleArrowWithButtonHeader"].tap()
        app.buttons["Title1TitleArrowWithButtonHeader"].tap()
    }
    
    func testAccordion() throws {
        let app = XCUIApplication()
        app.launch()
        
        checkFramework(width: app, framework: .switUI)
        
        app.buttons["Text Blocks"].tap()
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
        
        checkFramework(width: app, framework: .switUI)
        
        app.buttons["Text Blocks"].tap()
        app.buttons["Paragraph"].tap()
        
        changeThemes(app: app)
        
        app.buttons["SegmentControlDisabled"].tap()
        app.buttons["SegmentControlDefault"].tap()
    }
    
    func testLink() throws {
        let app = XCUIApplication()
        app.launch()
        
        checkFramework(width: app, framework: .switUI)
        
        app.buttons["Text Blocks"].tap()
        app.buttons["Link"].tap()
        
        app.buttons["SegmentControlDisabled"].tap()
        app.buttons["SegmentControlDefault"].tap()
        
        changeThemes(app: app)
        
        app.buttons["ButtonBank"].press(forDuration: 2)
    }
    
    func testPadding() throws {
        let app = XCUIApplication()
        app.launch()
        
        checkFramework(width: app, framework: .switUI)
        
        app.buttons["Text Blocks"].tap()
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
