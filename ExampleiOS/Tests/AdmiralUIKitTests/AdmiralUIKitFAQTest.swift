//
//  AdmiralUIKitFAQTest.swift
//  AdmiralUIKitTests
//

import XCTest

class AdmiralUIKitFAQTest: XCTestCase {
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    override func tearDownWithError() throws {
    }
    
    func testLightFAQ() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["Ellipse"].tap()
        
        app.otherElements.matching(identifier: "ThemeSwitchButton_Light").element.tap()
        
        app.buttons["Ellipse"].tap()
        
        tapFAQ(app: app)
    }
    
    func testDarkFAQ() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["Ellipse"].tap()
        
        app.otherElements.matching(identifier: "ThemeSwitchButton_Dark").element.tap()
        
        app.buttons["Ellipse"].tap()
        
        tapFAQ(app: app)
    }
    
    func tapFAQ(app: XCUIApplication) {
        app.buttons["Инфо"].tap()
        app.tables.staticTexts["FAQ"].tap()
        
        app.staticTexts["Зачем нужна дизайн-система?"].tap()
        app.staticTexts["Зачем нужна дизайн-система?"].tap()
        app.staticTexts["Как подключить дизайн-систему?"].tap()
        app.staticTexts["Как подключить дизайн-систему?"].tap()
        app.staticTexts["Как использовать дизайн-систему?"].tap()
        app.staticTexts["Как использовать дизайн-систему?"].tap()
        app.staticTexts["Это только для новых продуктов?"].tap()
        app.staticTexts["Это только для новых продуктов?"].tap()
        app.staticTexts["Как переключать темы?"].tap()
        app.staticTexts["Как переключать темы?"].tap()
        app.staticTexts["Для каких платформ разрабатывается библиотека?"].tap()
        app.staticTexts["Для каких платформ разрабатывается библиотека?"].tap()
        app.staticTexts["Для каких версий операционной системы разработана библиотека?"].tap()
        app.staticTexts["Для каких версий операционной системы разработана библиотека?"].tap()
        app.staticTexts["Где хранится документация по библиотеке?"].tap()
        app.staticTexts["Где хранится документация по библиотеке?"].tap()
        app.staticTexts["Кто ее разрабатывает и поддерживает?"].tap()
        app.staticTexts["Кто ее разрабатывает и поддерживает?"].tap()
        app.staticTexts["Увидел ошибку, кому и как сообщить?"].tap()
        app.staticTexts["Увидел ошибку, кому и как сообщить?"].tap()
        app.staticTexts["Как создать свою тему в приложении?"].tap()
        app.staticTexts["Как создать свою тему в приложении?"].tap()
    }
}
