//
//  AdmiralSwiftUIButtonsTest.swift
//  AdmiralSwiftUITests
//

import XCTest

class AdmiralSwiftUIButtonsTest: XCTestCase {
    
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
    
    func testPrimaryButtons() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["Buttons, Кнопки"].tap()
        app.buttons["Primary buttons"].tap()
        
        app.buttons["SegmentControlDisabled"].tap()
        app.buttons["SegmentControlDefault"].tap()
        
        app.buttons["TwoTitlePrimaryButtonStyleID"].press(forDuration: 1)
        app.buttons["BigButtonLeftID"].press(forDuration: 1)
        app.buttons["BigButtonRightID"].press(forDuration: 1)
        app.buttons["BigButtonNoneID"].press(forDuration: 1)
        app.buttons["MediumButtonLeftID"].press(forDuration: 1)
        app.buttons["MediumButtonRightID"].press(forDuration: 1)
        app.buttons["MediumButtonNoneID"].press(forDuration: 1)
        app.buttons["SmallButtonLeftID"].press(forDuration: 1)
        app.buttons["SmallButtonRightID"].press(forDuration: 1)
        app.buttons["SmallButtonNoneID"].press(forDuration: 1)
        
        changeThemes(app: app)
    }
    
    func testSecondaryButtons() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["Buttons, Кнопки"].tap()
        app.buttons["Secondary buttons"].tap()
        
        app.buttons["SegmentControlDisabled"].tap()
        app.buttons["SegmentControlDefault"].tap()
        
        app.buttons["BigButtonLeftID"].press(forDuration: 1)
        app.buttons["BigButtonRightID"].press(forDuration: 1)
        app.buttons["BigButtonNoneID"].press(forDuration: 1)
        app.buttons["MediumButtonLeftID"].press(forDuration: 1)
        app.buttons["MediumButtonRightID"].press(forDuration: 1)
        app.buttons["MediumButtonNoneID"].press(forDuration: 1)
        app.buttons["SmallButtonLeftID"].press(forDuration: 1)
        app.buttons["SmallButtonRightID"].press(forDuration: 1)
        app.buttons["SmallButtonNoneID"].press(forDuration: 1)
        
        changeThemes(app: app)
    }
    
    func testGhostButtons() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["Buttons, Кнопки"].tap()
        app.buttons["Ghost buttons"].tap()
        
        app.buttons["SegmentControlDisabled"].tap()
        app.buttons["SegmentControlDefault"].tap()
        
        app.buttons["BigButtonLeftID"].press(forDuration: 1)
        app.buttons["BigButtonRightID"].press(forDuration: 1)
        app.buttons["BigButtonNoneID"].press(forDuration: 1)
        app.buttons["MediumButtonLeftID"].press(forDuration: 1)
        app.buttons["MediumButtonRightID"].press(forDuration: 1)
        app.buttons["MediumButtonNoneID"].press(forDuration: 1)
        app.buttons["SmallButtonLeftID"].press(forDuration: 1)
        app.buttons["SmallButtonRightID"].press(forDuration: 1)
        app.buttons["SmallButtonNoneID"].press(forDuration: 1)
        
        changeThemes(app: app)
    }
    
    func testRules() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["Buttons, Кнопки"].tap()
        app.buttons["Rules"].tap()
        
        app.buttons["SegmentControlDisabled"].tap()
        app.buttons["SegmentControlDefault"].tap()
        
        app.staticTexts["Я согласен с условиями договора и подтверждаю свое согласие на обработку персональных данных"].tap()
        app.staticTexts["Я согласен с условиями договора и подтверждаю свое согласие на обработку персональных данных"].tap()
        
        changeThemes(app: app)
    }
    
    func testOtherButtons() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["Buttons, Кнопки"].tap()
        app.buttons["Other buttons"].tap()
        
        app.buttons["SegmentControlDisabled"].tap()
        app.buttons["SegmentControlDefault"].tap()
        
        app.buttons["AppleWalletButtonID"].tap()
        
        changeThemes(app: app)
    }
    
    func changeThemes(app: XCUIApplication) {
        app.buttons["Ellipse"].tap()
        
        app.buttons["Light"].tap()
        app.buttons["Dark"].tap()
        app.buttons["SME Light"].tap()
        app.buttons["SME Dark"].tap()
        
        app.buttons["Ellipse"].tap()
    }
}
