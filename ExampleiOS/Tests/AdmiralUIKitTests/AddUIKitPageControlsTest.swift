//
//  AddUIKitPageControlsTest.swift
//  AdmiralUIKitTests
//

import XCTest

class AddUIKitPageControlsTest: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
    }

    func testLiner() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.tables.staticTexts["Page Controls"].tap()
        app.tables.staticTexts["Liner"].tap()
        app.staticTexts["Two"].tap()
        app.staticTexts["One"].tap()
        app.staticTexts["Three"].tap()
        app.staticTexts["Four"].tap()
        app.staticTexts["Five"].tap()
        app.staticTexts["Six"].tap()
        app.staticTexts["Seven"].tap()
        app.staticTexts["Seven"].swipeLeft()
        app.staticTexts["Eight"].tap()
        app.staticTexts["Nine"].tap()
        
        app.buttons["Ellipse"].tap()
        
        app.staticTexts["Light"].tap()
        app.staticTexts["Dark"].tap()
        app.staticTexts["SME Light"].tap()
        app.staticTexts["SME Dark"].tap()
        
        app.buttons["Ellipse"].tap()
    }
    
    func testLinerNext() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.tables.staticTexts["Page Controls"].tap()
        app.tables.staticTexts["Liner"].tap()
        app.staticTexts["Next"].tap()
        app.staticTexts["Next"].tap()
        app.staticTexts["Next"].tap()
        app.staticTexts["Next"].tap()
        app.staticTexts["Next"].tap()
        app.staticTexts["Next"].tap()
        app.staticTexts["Next"].tap()
        app.staticTexts["Next"].tap()
        
        app.buttons["Ellipse"].tap()
        
        app.staticTexts["Light"].tap()
        app.staticTexts["Dark"].tap()
        app.staticTexts["SME Light"].tap()
        app.staticTexts["SME Dark"].tap()
        
        app.buttons["Ellipse"].tap()
    }
    
    func testCircle() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.tables.staticTexts["Page Controls"].tap()
        app.tables.staticTexts["Circle"].tap()
        app.staticTexts["One"].tap()
        app.staticTexts["Two"].tap()
        app.staticTexts["Three"].tap()
        app.staticTexts["Four"].tap()
        app.staticTexts["Five"].tap()
        app.staticTexts["Six"].tap()
        app.staticTexts["Seven"].tap()
        app.staticTexts["Seven"].swipeLeft()
        app.staticTexts["Eight"].tap()
        app.staticTexts["Nine"].tap()
        
        app.buttons["Ellipse"].tap()
        
        app.staticTexts["Light"].tap()
        app.staticTexts["Dark"].tap()
        app.staticTexts["SME Light"].tap()
        app.staticTexts["SME Dark"].tap()
        
        app.buttons["Ellipse"].tap()
    }
    
    func testCircleNext() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.tables.staticTexts["Page Controls"].tap()
        app.tables.staticTexts["Circle"].tap()
        app.buttons["arrowRight"].tap()
        app.buttons["arrowRight"].tap()
        app.buttons["arrowRight"].tap()
        app.buttons["arrowRight"].tap()
        app.buttons["arrowRight"].tap()
        app.buttons["arrowRight"].tap()
        app.buttons["arrowRight"].tap()
        app.buttons["arrowRight"].tap()
        app.buttons["arrowRight"].tap()
        app.buttons["arrowRight"].tap()
        app.buttons["arrowRight"].tap()
        app.buttons["arrowRight"].tap()
        app.buttons["arrowRight"].tap()
        
        app.buttons["Ellipse"].tap()
        
        app.staticTexts["Light"].tap()
        app.staticTexts["Dark"].tap()
        app.staticTexts["SME Light"].tap()
        app.staticTexts["SME Dark"].tap()
        
        app.buttons["Ellipse"].tap()
    }
}
