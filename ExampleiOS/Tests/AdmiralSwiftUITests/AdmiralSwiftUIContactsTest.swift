//
//  AdmiralSwiftUIContactsTest.swift
//  AdmiralSwiftUITests
//

import XCTest

class AdmiralSwiftUIContactsTest: XCTestCase {
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    override func tearDownWithError() throws {
    }
    
    func testDarkContact() throws {
        let app = XCUIApplication()
        app.launch()
        
        checkFramework(width: app, framework: .switUI)
        
        app.buttons["Ellipse"].tap()
        app.buttons["ThemeSwitchButton_Dark"].tap()
        app.buttons["InfoTabBarItem"].tap()
        app.cells["Contacts"].tap()
        app.staticTexts["Телеграмм канал"].tap()
    }
    
    func testLightContact() throws {
        let app = XCUIApplication()
        app.launch()
        
        checkFramework(width: app, framework: .switUI)
        
        app.buttons["Ellipse"].tap()
        app.buttons["ThemeSwitchButton_Light"].tap()
        app.buttons["InfoTabBarItem"].tap()
        app.cells["Contacts"].tap()
        app.staticTexts["Телеграмм канал"].tap()
    }
    
    func testSMEDarkContact() throws {
        let app = XCUIApplication()
        app.launch()
        
        checkFramework(width: app, framework: .switUI)
        
        app.buttons["Ellipse"].tap()
        app.buttons["ThemeSwitchButton_SME Dark"].tap()
        app.buttons["InfoTabBarItem"].tap()
        app.cells["Contacts"].tap()
        app.staticTexts["Телеграмм канал"].tap()
    }
    
    func testSMELightContact() throws {
        let app = XCUIApplication()
        app.launch()
        
        checkFramework(width: app, framework: .switUI)
        
        app.buttons["Ellipse"].tap()
        app.buttons["ThemeSwitchButton_SME Light"].tap()
        app.buttons["InfoTabBarItem"].tap()
        app.cells["Contacts"].tap()
        app.staticTexts["Телеграмм канал"].tap()
    }
}
