//
//  AdmiralUIInformers&NotificationsTest.swift
//  AdmiralUIKitTests
//

import XCTest

class AdmiralUIInformers_NotificationsTest: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
    }

    func testBigInformers() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.tables.staticTexts["Informers & Notifications"].tap()
        app.tables.staticTexts["Informers"].tap()
        app.tables.staticTexts["Big Informers"].tap()
        app.otherElements.matching(identifier: "SegmentControlDisabled").element.tap()
        app.otherElements.matching(identifier: "SegmentControlDefault").element.tap()
        
        changeThemes(app: app)
    }
    
    func testSmallInformers() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.tables.staticTexts["Informers & Notifications"].tap()
        app.tables.staticTexts["Informers"].tap()
        app.tables.staticTexts["Small Informers"].tap()
        app.otherElements.matching(identifier: "SegmentControlDisabled").element.tap()
        app.otherElements.matching(identifier: "SegmentControlDefault").element.tap()
        
        changeThemes(app: app)
    }
    
    func testToast() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.tables.staticTexts["Informers & Notifications"].tap()
        app.tables.staticTexts["Notifications"].tap()
        app.tables.staticTexts["Toast"].tap()
        app.staticTexts["Показать Toast"].tap()
        app.staticTexts["Показать Toast"].tap()
        
        changeThemes(app: app)
    }
    
    func testStatic() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.tables.staticTexts["Informers & Notifications"].tap()
        app.tables.staticTexts["Notifications"].tap()
        app.tables.staticTexts["Static"].tap()
        app.otherElements.matching(identifier: "SegmentControlDisabled").element.tap()
        app.otherElements.matching(identifier: "SegmentControlDefault").element.tap()
        
        changeThemes(app: app)
    }
    
    func testAction() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.tables.staticTexts["Informers & Notifications"].tap()
        app.tables.staticTexts["Notifications"].tap()
        app.tables.staticTexts["Action"].tap()
        app.staticTexts["Показать Action"].tap()
        app.staticTexts["Отмена"].tap()
        app.staticTexts["Показать Action"].tap()
        
        changeThemes(app: app)
    }
    
    func changeThemes(app: XCUIApplication) {
        app.buttons["Ellipse"].tap()
        
        app.otherElements.matching(identifier: "ThemeSwitchButton_Light").element.tap()
        app.otherElements.matching(identifier: "ThemeSwitchButton_Dark").element.tap()
        app.otherElements.matching(identifier: "ThemeSwitchButton_SME Light").element.tap()
        app.otherElements.matching(identifier: "ThemeSwitchButton_SME Dark").element.tap()
        
        app.buttons["Ellipse"].tap()
    }
}
