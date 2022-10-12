//
//  AdmiralUIKitContactsTest.swift
//  AdmiralUIKitTests
//

import XCTest

class AdmiralUIKitContactsTest: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
    }

    func testContactsLight() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["Ellipse"].tap()
        
        app.staticTexts["Light"].tap()
        
        app.buttons["Ellipse"].tap()
        
        app.buttons["Инфо"].tap()
        app.tables.staticTexts["Контакты"].tap()
        app.staticTexts["Телеграмм канал"].tap()
    }
    
    func testContactsDark() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["Ellipse"].tap()
        
        app.staticTexts["Dark"].tap()
        
        app.buttons["Ellipse"].tap()
        
        app.buttons["Инфо"].tap()
        app.tables.staticTexts["Контакты"].tap()
        app.staticTexts["Телеграмм канал"].tap()
    }
}
