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
        
        app/*@START_MENU_TOKEN@*/.staticTexts["56 000.00 ₽"]/*[[".cells.staticTexts[\"56 000.00 ₽\"]",".staticTexts[\"56 000.00 ₽\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["5 000.00 ₽"]/*[[".cells.staticTexts[\"5 000.00 ₽\"]",".staticTexts[\"5 000.00 ₽\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["200 000.00 ₽ "]/*[[".cells.staticTexts[\"200 000.00 ₽ \"]",".staticTexts[\"200 000.00 ₽ \"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["2 000 000.00 ₽ "]/*[[".cells.staticTexts[\"2 000 000.00 ₽ \"]",".staticTexts[\"2 000 000.00 ₽ \"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["11 000.00 ₽ "]/*[[".cells.staticTexts[\"11 000.00 ₽ \"]",".staticTexts[\"11 000.00 ₽ \"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["1000.00 ₽ "]/*[[".cells.staticTexts[\"1000.00 ₽ \"]",".staticTexts[\"1000.00 ₽ \"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
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
