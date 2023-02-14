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
        
        checkFramework(width: app, framework: .UIKit)
        
        app.buttons["Ellipse"].tap()
        app.otherElements.matching(identifier: "ThemeSwitchButton_Light").element.tap()
        app.buttons["Ellipse"].tap()
        
        checkContacts(app: app)
    }
    
    func testContactsDark() throws {
        let app = XCUIApplication()
        app.launch()
        
        checkFramework(width: app, framework: .UIKit)
        
        app.buttons["Ellipse"].tap()
        app.otherElements.matching(identifier: "ThemeSwitchButton_Dark").element.tap()
        app.buttons["Ellipse"].tap()
        
        checkContacts(app: app)
    }
    
    func testContactsSMELight() throws {
        let app = XCUIApplication()
        app.launch()
        
        checkFramework(width: app, framework: .UIKit)
        
        app.buttons["Ellipse"].tap()
        app.otherElements.matching(identifier: "ThemeSwitchButton_SME Light").element.tap()
        app.buttons["Ellipse"].tap()
        
        checkContacts(app: app)
    }
    
    func testContactsSMEDark() throws {
        let app = XCUIApplication()
        app.launch()
        
        checkFramework(width: app, framework: .UIKit)
        
        app.buttons["Ellipse"].tap()
        app.otherElements.matching(identifier: "ThemeSwitchButton_SME Dark").element.tap()
        app.buttons["Ellipse"].tap()
        
        checkContacts(app: app)
    }
    
    func checkContacts(app: XCUIApplication) {
        app.buttons["Инфо"].tap()
        app.tables.staticTexts["Контакты"].tap()
        app.staticTexts["Телеграмм канал"].tap()
    }
}
