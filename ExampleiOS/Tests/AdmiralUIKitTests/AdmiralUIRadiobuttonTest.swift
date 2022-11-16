//
//  AdmiralUIRadiobuttonTest.swift
//  AdmiralUIKitTests
//

import XCTest

class AdmiralUIRadiobuttonTest: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
    }

    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.tables.staticTexts["Radiobutton"].tap()
        app.otherElements.matching(identifier: "SegmentControlDisabled").element.tap()
        app.otherElements.matching(identifier: "SegmentControlDefault").element.tap()
        
        
        app.otherElements.matching(identifier: "RadioControlsFirstDefault").element.tap()
        app.otherElements.matching(identifier: "RadioControlsSecondDefault").element.tap()
        
        app.otherElements.matching(identifier: "RadioControlsFirstSelected").element.tap()
        app.otherElements.matching(identifier: "RadioControlsSecondSelected").element.tap()
        
        app.otherElements.matching(identifier: "RadioControlsFirstError").element.tap()
        app.otherElements.matching(identifier: "RadioControlsSecondError").element.tap()
        
        app.buttons["Ellipse"].tap()
        
        app.staticTexts["Light"].tap()
        app.staticTexts["Dark"].tap()
        app.staticTexts["SME Light"].tap()
        app.staticTexts["SME Dark"].tap()
        
        app.buttons["Ellipse"].tap()
    }
}
