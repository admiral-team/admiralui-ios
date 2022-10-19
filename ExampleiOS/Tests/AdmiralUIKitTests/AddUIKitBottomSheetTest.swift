//
//  AddUIKitBottomSheetTest.swift
//  AdmiralUIKitTests
//

import XCTest

class AddUIKitBottomSheetTest: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
    }

    func testBottomSheet() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.tables.staticTexts["Bottom-sheet"].tap()
        
        app.buttons["Ellipse"].tap()
        
        app.staticTexts["Light"].tap()
        app.staticTexts["Dark"].tap()
        app.staticTexts["SME Light"].tap()
        app.staticTexts["SME Dark"].tap()
        
        app.buttons["Ellipse"].tap()
        
        app.staticTexts["Показать Bottom-sheet"].tap()
        
        app.staticTexts["Зарплатная карта"].tap()
        app.staticTexts["5 000.00 ₽"].tap()
        app.staticTexts["Новая карта"].tap()
        app.staticTexts["2 000 000.00 ₽ "].tap()
        app.staticTexts["11 000.00 ₽ "].tap()
        app.staticTexts["1000.00 ₽ "].tap()
        app.staticTexts["Готово"].tap()
    }
    
    func testBottomSheetAllCards() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.tables.staticTexts["Bottom-sheet"].tap()
        
        app.buttons["Ellipse"].tap()
        
        app.staticTexts["Light"].tap()
        app.staticTexts["Dark"].tap()
        app.staticTexts["SME Light"].tap()
        app.staticTexts["SME Dark"].tap()
        
        app.buttons["Ellipse"].tap()
        
        app.staticTexts["Показать Bottom-sheet"].tap()
        app.staticTexts["Выбрать все карты"].tap()
        app.staticTexts["Готово"].tap()
    }
}
