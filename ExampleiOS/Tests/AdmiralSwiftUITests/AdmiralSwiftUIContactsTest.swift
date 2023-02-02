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
    
    func testCheckSwiftUI() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["SeatingTabBarItem"].tap()
        let swiftUISwitcher = app.switches["SwitchToSwiftUI"]
        
        if swiftUISwitcher.value as? String == "0" {
            swiftUISwitcher.tap()
        }
    }
    
    func testDarkContact() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["Ellipse"].tap()
        app.buttons["Dark"].tap()
        app.buttons["InfoTabBarItem"].tap()
        app.cells["Contacts"].tap()
        app.staticTexts["Телеграмм канал"].tap()
    }
    
    func testLightContact() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["Ellipse"].tap()
        app.buttons["Light"].tap()
        app.buttons["InfoTabBarItem"].tap()
        app.cells["Contacts"].tap()
        app.staticTexts["Телеграмм канал"].tap()
    }
    
    func testSMEDarkContact() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["Ellipse"].tap()
        app.buttons["SME Dark"].tap()
        app.buttons["InfoTabBarItem"].tap()
        app.cells["Contacts"].tap()
        app.staticTexts["Телеграмм канал"].tap()
    }
    
    func testSMELightContact() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["Ellipse"].tap()
        app.buttons["SME Light"].tap()
        app.buttons["InfoTabBarItem"].tap()
        app.cells["Contacts"].tap()
        app.staticTexts["Телеграмм канал"].tap()
    }
}
