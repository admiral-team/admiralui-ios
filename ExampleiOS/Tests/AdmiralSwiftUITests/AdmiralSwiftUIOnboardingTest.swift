//
//  AdmiralSwiftUIOnboardingTest.swift
//  AdmiralSwiftUITests
//

import XCTest

class AdmiralSwiftUIOnboardingTest: XCTestCase {
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    override func tearDownWithError() throws {
    }
    
    func testOnboarding() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["Alerts"].tap()
        app.buttons["Onboarding"].tap()
        app.buttons["NextStep"].tap()
        sleep(1)
        app.buttons["NextStep"].tap()
        
        app.buttons["Ellipse"].tap()
        
        app.buttons["Dark"].tap()
        app.buttons["Light"].tap()
        app.buttons["SME Light"].tap()
        app.buttons["SME Dark"].tap()
        
        app.buttons["Ellipse"].tap()
    }
}
