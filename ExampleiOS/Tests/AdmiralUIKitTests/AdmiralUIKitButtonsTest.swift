//
//  AdmiralUIKitUITests.swift
//  AdmiralUIKitUITests
//

import XCTest

class AdmiralUIKitButtonsTests: XCTestCase {
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    override func tearDownWithError() throws {
    }
    
    func testPrimaryButtons() throws {
        let app = XCUIApplication()
        app.launch()
        
        checkFramework(width: app, framework: .UIKit)
        
        app.tables.staticTexts["Buttons"].tap()
        app.tables.staticTexts["Primary buttons"].tap()
        app.otherElements.matching(identifier: "SegmentControlDisabled").element.tap()
        app.otherElements.matching(identifier: "SegmentControlDefault").element.tap()
        
        app.buttons["PrimaryButtonBig"].press(forDuration: 2)
        app.buttons["secondPrimaryButtonBig"].press(forDuration: 2)
        app.buttons["thirdPrimaryButtonBig"].press(forDuration: 2)
        app.buttons["primaryButtonMedium"].press(forDuration: 2)
        app.buttons["secondPrimaryButtonMedium"].press(forDuration: 2)
        app.buttons["thirdPrimaryButtonMedium"].press(forDuration: 2)
        app.buttons["primaryButtonSmall"].press(forDuration: 2)
        app.buttons["secondPrimaryButtonSmall"].press(forDuration: 2)
        app.buttons["thirdPrimaryButtonSmall"].press(forDuration: 2)
        
        changeThemes(app: app)
    }
    
    func testSecondaryButtons() throws {
        let app = XCUIApplication()
        app.launch()
        
        checkFramework(width: app, framework: .UIKit)
        
        app.tables.staticTexts["Buttons"].tap()
        app.tables.staticTexts["Secondary buttons"].tap()
        app.otherElements.matching(identifier: "SegmentControlDisabled").element.tap()
        app.otherElements.matching(identifier: "SegmentControlDefault").element.tap()
        
        app.buttons["SecondaryPrimaryButtonBig"].press(forDuration: 2)
        app.buttons["SecondarySecondPrimaryButtonBig"].press(forDuration: 2)
        app.buttons["SecondaryThirdPrimaryButtonBig"].press(forDuration: 2)
        app.buttons["SecondaryPrimaryButtonMedium"].press(forDuration: 2)
        app.buttons["SecondarySecondPrimaryButtonMedium"].press(forDuration: 2)
        app.buttons["SecondaryThirdPrimaryButtonMedium"].press(forDuration: 2)
        app.buttons["SecondaryPrimaryButtonSmall"].press(forDuration: 2)
        app.buttons["SecondarySecondPrimaryButtonSmall"].press(forDuration: 2)
        app.buttons["SecondaryThirdPrimaryButtonSmall"].press(forDuration: 2)
        
        changeThemes(app: app)
    }
    
    func testGhostButtons() throws {
        let app = XCUIApplication()
        app.launch()
        
        checkFramework(width: app, framework: .UIKit)
        
        app.tables.staticTexts["Buttons"].tap()
        app.tables.staticTexts["Ghost buttons"].tap()
        app.otherElements.matching(identifier: "SegmentControlDisabled").element.tap()
        app.otherElements.matching(identifier: "SegmentControlDefault").element.tap()
        
        app.buttons["GhostPrimaryButtonBig"].press(forDuration: 2)
        app.buttons["GhostSecondPrimaryButtonBig"].press(forDuration: 2)
        app.buttons["GhostThirdPrimaryButtonBig"].press(forDuration: 2)
        app.buttons["GhostPrimaryButtonMedium"].press(forDuration: 2)
        app.buttons["GhostSecondPrimaryButtonMedium"].press(forDuration: 2)
        app.buttons["GhostThirdPrimaryButtonMedium"].press(forDuration: 2)
        app.buttons["GhostPrimaryButtonSmall"].press(forDuration: 2)
        app.buttons["GhostSecondPrimaryButtonSmall"].press(forDuration: 2)
        app.buttons["GhostThirdPrimaryButtonSmall"].press(forDuration: 2)
        
        changeThemes(app: app)
    }
    
    func testRules() throws {
        let app = XCUIApplication()
        app.launch()
        
        checkFramework(width: app, framework: .UIKit)
        
        app.tables.staticTexts["Buttons"].tap()
        app.tables.staticTexts["Rules"].tap()
        app.otherElements.matching(identifier: "SegmentControlDisabled").element.tap()
        app.otherElements.matching(identifier: "SegmentControlDefault").element.tap()
        
        app.staticTexts["Я согласен с условиями договора и подтверждаю свое согласие на обработку персональных данных"].tap()
        app.staticTexts["Я согласен с условиями договора и подтверждаю свое согласие на обработку персональных данных"].tap()
        
        changeThemes(app: app)
    }
    
    func testOtherButtons() throws {
        let app = XCUIApplication()
        app.launch()
        
        checkFramework(width: app, framework: .UIKit)
        
        app.tables.staticTexts["Buttons"].tap()
        app.tables.staticTexts["Other buttons"].tap()
        app.otherElements.matching(identifier: "SegmentControlDisabled").element.tap()
        app.otherElements.matching(identifier: "SegmentControlDefault").element.tap()
        
        app.buttons["OtherButton"].press(forDuration: 2)
        
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
