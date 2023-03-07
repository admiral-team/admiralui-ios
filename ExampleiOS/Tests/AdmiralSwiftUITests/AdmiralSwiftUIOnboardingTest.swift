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
        
        checkFramework(width: app, framework: .switUI)
        
        app.buttons["Alerts"].tap()
        app.buttons["Onboarding"].tap()
        app.buttons["NextStep"].tap()
        sleep(1)
        app.buttons["NextStep"].tap()
        
        app.buttons["Ellipse"].tap()
        
        app.buttons["ThemeSwitchButton_Dark"].tap()
        app.buttons["ThemeSwitchButton_SME Light"].tap()
        app.buttons["ThemeSwitchButton_SME Dark"].tap()
        app.buttons["ThemeSwitchButton_Light"].tap()
        
        app.buttons["Ellipse"].tap()
    }
}
