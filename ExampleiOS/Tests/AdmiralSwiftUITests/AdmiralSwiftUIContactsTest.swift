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
        app.buttons["Dark"].tap()
        app.buttons["InfoTabBarItem"].tap()
        app.cells["Contacts"].tap()
        app.staticTexts["Телеграмм канал"].tap()
    }
    
    func testLightContact() throws {
        let app = XCUIApplication()
        app.launch()
        
        checkFramework(width: app, framework: .switUI)
        
        app.buttons["Ellipse"].tap()
        app.buttons["Light"].tap()
        app.buttons["InfoTabBarItem"].tap()
        app.cells["Contacts"].tap()
        app.staticTexts["Телеграмм канал"].tap()
    }
    
    func testSMEDarkContact() throws {
        let app = XCUIApplication()
        app.launch()
        
        checkFramework(width: app, framework: .switUI)
        
        app.buttons["Ellipse"].tap()
        app.buttons["SME Dark"].tap()
        app.buttons["InfoTabBarItem"].tap()
        app.cells["Contacts"].tap()
        app.staticTexts["Телеграмм канал"].tap()
    }
    
    func testSMELightContact() throws {
        let app = XCUIApplication()
        app.launch()
        
        checkFramework(width: app, framework: .switUI)
        
        app.buttons["Ellipse"].tap()
        app.buttons["SME Light"].tap()
        app.buttons["InfoTabBarItem"].tap()
        app.cells["Contacts"].tap()
        app.staticTexts["Телеграмм канал"].tap()
    }
}
