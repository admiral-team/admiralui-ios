//
//  AdmiralUICellsTest.swift
//  AdmiralUIKitTests
//

import XCTest

class AdmiralUICellsTest: XCTestCase {
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    override func tearDownWithError() throws {
    }
    
    func testLeadingElements() throws {
        let app = XCUIApplication()
        app.launch()
        
        checkFramework(width: app, framework: .UIKit)
        
        app.tables.staticTexts["Cells"].tap()
        app.staticTexts["Base Cells"].tap()
        app.staticTexts["Leading elements"].tap()
        
        app.otherElements.matching(identifier: "SegmentControlDisabled").element.tap()
        app.otherElements.matching(identifier: "SegmentControlDefault").element.tap()
        
        app.otherElements.matching(identifier: "CardCell").element.tap()
        app.otherElements.matching(identifier: "LargeImageCell").element.tap()
        app.otherElements.matching(identifier: "ImageCell").element.tap()
        app.otherElements.matching(identifier: "ImageBackgroundListViewCell").element.tap()
        app.otherElements.matching(identifier: "ImageNameListViewCell").element.tap()
        
        changeThemes(app: app)
    }
    
    func testCenterElements() throws {
        let app = XCUIApplication()
        app.launch()
        
        checkFramework(width: app, framework: .UIKit)
        
        app.tables.staticTexts["Cells"].tap()
        app.staticTexts["Base Cells"].tap()
        app.staticTexts["Center elements"].tap()
        
        app.otherElements.matching(identifier: "SegmentControlDisabled").element.tap()
        app.otherElements.matching(identifier: "SegmentControlDefault").element.tap()
        
        app.otherElements.matching(identifier: "TitleCell").element.tap()
        app.otherElements.matching(identifier: "TitleSubtitleCell").element.tap()
        app.otherElements.matching(identifier: "SubtitleTitleCell").element.tap()
        app.otherElements.matching(identifier: "TitleMoreDetaileTextMessageListView").element.tap()
        app.otherElements.matching(identifier: "TitleSubtitleButtonListView").element.tap()
        
        changeThemes(app: app)
    }
    
    func testTrailingElements() throws {
        let app = XCUIApplication()
        app.launch()
        
        checkFramework(width: app, framework: .UIKit)
        
        app.tables.staticTexts["Cells"].tap()
        app.staticTexts["Base Cells"].tap()
        app.staticTexts["Trailing elements"].tap()
        
        app.otherElements.matching(identifier: "SegmentControlDisabled").element.tap()
        app.otherElements.matching(identifier: "SegmentControlDefault").element.tap()
        
        app.otherElements.matching(identifier: "RadioButtonCell").element.tap()
        app.otherElements.matching(identifier: "CheckBoxListView").element.tap()
        app.otherElements.matching(identifier: "CheckBoxCell").element.tap()
        app.otherElements.matching(identifier: "SwitchListView").element.tap()
        app.otherElements.matching(identifier: "SwitchListViewCell").element.tap()
        app.otherElements.matching(identifier: "CardListViewCell").element.tap()
        app.otherElements.matching(identifier: "IconListViewCell").element.tap()
        app.otherElements.matching(identifier: "DatePercentListViewCell").element.tap()
        app.otherElements.matching(identifier: "ImageWithSubtitleListViewCell").element.tap()
        app.otherElements.matching(identifier: "SubtitleWithImageListViewCell").element.tap()
        app.otherElements.matching(identifier: "CurcleIconListViewCell").element.tap()
        
        changeThemes(app: app)
    }
    
    func testActionbar() throws {
        let app = XCUIApplication()
        app.launch()
        
        checkFramework(width: app, framework: .UIKit)
        
        app.tables.staticTexts["Cells"].tap()
        app.staticTexts["Actionbar"].tap()
        
        app.otherElements.matching(identifier: "SegmentControlDisabled").element.tap()
        app.otherElements.matching(identifier: "SegmentControlDefault").element.tap()
        
        app.otherElements.matching(identifier: "defaultAction").element.swipeLeft()
        app.otherElements.matching(identifier: "defaultActionItemBarActionOne").element.press(forDuration: 1)
        app.otherElements.matching(identifier: "defaultActionItemBarActionTwo").element.press(forDuration: 1)
        app.otherElements.matching(identifier: "defaultActionItemBarActionThree").element.press(forDuration: 1)
        app.otherElements.matching(identifier: "defaultActionItemBarActionFour").element.press(forDuration: 1)
        app.otherElements.matching(identifier: "defaultActionItemBarActionFive").element.press(forDuration: 1)
        app.otherElements.matching(identifier: "defaultAction").element.swipeRight()
        
        app.otherElements.matching(identifier: "secondaryAction").element.swipeLeft()
        app.otherElements.matching(identifier: "secondaryActionItemBarActionOne").element.press(forDuration: 1)
        app.otherElements.matching(identifier: "secondaryActionItemBarActionTwo").element.press(forDuration: 1)
        app.otherElements.matching(identifier: "secondaryActionItemBarActionThree").element.press(forDuration: 1)
        app.otherElements.matching(identifier: "secondaryAction").element.swipeRight()
        
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
