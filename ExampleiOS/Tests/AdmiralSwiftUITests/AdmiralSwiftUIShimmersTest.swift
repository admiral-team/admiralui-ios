//
//  AdmiralSwiftUIShimmersTest.swift
//  AdmiralSwiftUITests
//

import XCTest

class AdmiralSwiftUIShimmersTest: XCTestCase {
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    override func tearDownWithError() throws {
    }
    
    func testShimmers() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["Shimmers"].tap()
        
        app.buttons["Ellipse"].tap()
        
        app.buttons["Dark"].tap()
        app.buttons["Light"].tap()
        app.buttons["SME Light"].tap()
        app.buttons["SME Dark"].tap()
        
        app.buttons["Ellipse"].tap()
    }
}
