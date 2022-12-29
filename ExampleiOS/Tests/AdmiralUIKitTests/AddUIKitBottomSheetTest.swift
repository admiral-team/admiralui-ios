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
        
        changeThemes(app: app)
        
        app.staticTexts["Показать Bottom-sheet"].tap()
        app.cells["CellBottomSheetOne"].tap()
        app.cells["CellBottomSheetTwo"].tap()
        app.cells["CellBottomSheetThree"].tap()
        app.cells["CellBottomSheetFour"].tap()
        app.cells["CellBottomSheetFive"].tap()
        app.cells["CellBottomSheetSix"].tap()
        app.staticTexts["Готово"].tap()
    }
    
    func testBottomSheetAllCards() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.tables.staticTexts["Bottom-sheet"].tap()
        
        changeThemes(app: app)
        
        app.staticTexts["Показать Bottom-sheet"].tap()
        app.staticTexts["Выбрать все карты"].tap()
        app.staticTexts["Готово"].tap()
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
