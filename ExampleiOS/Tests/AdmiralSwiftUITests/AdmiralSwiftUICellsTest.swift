//
//  AdmiralSwiftUICellsTest.swift
//  AdmiralSwiftUITests
//

import XCTest

class AdmiralSwiftUICellsTest: XCTestCase {
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    override func tearDownWithError() throws {
    }
    
    func testLeadingElements() throws {
        let app = XCUIApplication()
        app.launch()
        
        checkFramework(width: app, framework: .switUI)
        
        app.buttons["Cells"].tap()
        app.buttons["Base Cells"].tap()
        app.buttons["Leading Elements"].tap()
        
        app.buttons["SegmentControlDisabled"].tap()
        app.buttons["SegmentControlDefault"].tap()
        
        changeThemes(app: app)
        
        app.otherElements.matching(identifier: "FirstImageTitleArrowListCell").element.tap()
        app.otherElements.matching(identifier: "LeadingCardTitleArrowListCell").element.tap()
        app.otherElements.matching(identifier: "SecondImageTitleArrowListCell").element.tap()
        app.otherElements.matching(identifier: "ThirdImageTitleArrowListCell").element.tap()
        app.otherElements.matching(identifier: "FourthImageTitleArrowListCell").element.tap()
    }
    
    func testCenterElements() throws {
        let app = XCUIApplication()
        app.launch()
        
        checkFramework(width: app, framework: .switUI)
        
        app.buttons["Cells"].tap()
        app.buttons["Base Cells"].tap()
        app.buttons["Center Elements"].tap()
        
        app.buttons["SegmentControlDisabled"].tap()
        app.buttons["SegmentControlDefault"].tap()
        
        changeThemes(app: app)
        
        app.otherElements.matching(identifier: "TitleListView").element.tap()
        app.otherElements.matching(identifier: "TitleSubtitleListView").element.tap()
        app.otherElements.matching(identifier: "SubtitleTitleListView").element.tap()
        app.otherElements.matching(identifier: "TitleMoreDetailTextMessageListView").element.tap()
        app.otherElements.matching(identifier: "TitleSubtitleButtonListView").element.tap()
    }
    
    func testTrailinElements() throws {
        let app = XCUIApplication()
        app.launch()
        
        checkFramework(width: app, framework: .switUI)
        
        app.buttons["Cells"].tap()
        app.buttons["Base Cells"].tap()
        app.buttons["Trailing Elements"].tap()
        
        app.buttons["SegmentControlDisabled"].tap()
        app.buttons["SegmentControlDefault"].tap()
        
        changeThemes(app: app)
        
        app.otherElements.matching(identifier: "ArrowListCell").element.tap()
        app.otherElements.matching(identifier: "RadioButtonListView").element.tap()
        app.otherElements.matching(identifier: "CheckBoxListView").element.tap()
        app.otherElements.matching(identifier: "SwitcherListView").element.tap()
        app.otherElements.matching(identifier: "TitleIconListCell").element.tap()
        app.otherElements.matching(identifier: "TitleCardListCell").element.tap()
        app.otherElements.matching(identifier: "TitleDatePercentListCell").element.tap()
        app.otherElements.matching(identifier: "TitleImageWithSubtitleListCell").element.tap()
        app.otherElements.matching(identifier: "TitleSubtitleWithImageListCell").element.tap()
        app.otherElements.matching(identifier: "TitleBadgeArrowListCell").element.tap()
        app.otherElements.matching(identifier: "TitleSubtitleImageArrowListCell").element.tap()
        app.otherElements.matching(identifier: "TitleTagControlListCell").element.tap()
    }
    
    func testActionBar() throws {
        let app = XCUIApplication()
        app.launch()
        
        checkFramework(width: app, framework: .switUI)
        
        app.buttons["Cells"].tap()
        app.buttons["Actionbar"].tap()
        
        app.buttons["SegmentControlDisabled"].tap()
        app.buttons["SegmentControlDefault"].tap()
        
        changeThemes(app: app)
        
        app.otherElements.matching(identifier: "DefaultCellSwipe").element.swipeLeft()
        app.buttons["DefaultSecondAction"].tap()
        app.buttons["DefaultFirstAction"].tap()
        app.buttons["DefaultThirdAction"].tap()
        app.buttons["DefaultFourthAction"].tap()
        app.buttons["DefaultFifthAction"].tap()
        app.otherElements.matching(identifier: "DefaultCellSwipe").element.swipeRight()
        
        app.otherElements.matching(identifier: "SecondaryCellSwipe").element.swipeLeft()
        app.buttons["SecondaryFirstAction"].tap()
        app.buttons["SecondarySecondAction"].tap()
        app.buttons["SecondaryThirdAction"].tap()
        app.otherElements.matching(identifier: "SecondaryCellSwipe").element.swipeRight()
    }
    
    func changeThemes(app: XCUIApplication) {
        app.buttons["Ellipse"].tap()
        
        app.buttons["ThemeSwitchButton_Dark"].tap()
        app.buttons["ThemeSwitchButton_SME Light"].tap()
        app.buttons["ThemeSwitchButton_SME Dark"].tap()
        app.buttons["ThemeSwitchButton_Light"].tap()
        
        app.buttons["Ellipse"].tap()
    }
}
