//
//  AdmiralUIOnboardingTest.swift
//  AdmiralUIKitTests
//

import XCTest

class AdmiralUIOnboardingTest: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
    }

    func testOnboarding() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.tables.staticTexts["Alerts"].tap()
        app.tables.staticTexts["Onboarding"].tap()
        app.buttons["arrowRight"].tap()
        app.buttons["arrowRight"].tap()
        app.buttons["arrowRight"].tap()
    }
}
