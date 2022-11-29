//
//  AdmiralUIKitTabsTest.swift
//  AdmiralUIKitTests
//

import XCTest

class AdmiralUIKitTabsTest: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
    }

    func testStandardTabs() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.tables.staticTexts["Tabs"].tap()
        app.tables.staticTexts["Standard Tabs"].tap()
        app.otherElements.matching(identifier: "SegmentControlDisabled").element.tap()
        app.otherElements.matching(identifier: "SegmentControlDefault").element.tap()
        
        app.otherElements.matching(identifier: "segmentControl1Two").element.tap()
        app.otherElements.matching(identifier: "segmentControl1One").element.tap()
        
        app.otherElements.matching(identifier: "segmentControl2Two").element.tap()
        app.otherElements.matching(identifier: "segmentControl2Three").element.tap()
        app.otherElements.matching(identifier: "segmentControl2One").element.tap()
        
        app.otherElements.matching(identifier: "segmentControl3Two").element.tap()
        app.otherElements.matching(identifier: "segmentControl3Three").element.tap()
        app.otherElements.matching(identifier: "segmentControl3Four").element.tap()
        app.otherElements.matching(identifier: "segmentControl3One").element.tap()
        
        app.otherElements.matching(identifier: "segmentControl4Two").element.tap()
        app.otherElements.matching(identifier: "segmentControl4Three").element.tap()
        app.otherElements.matching(identifier: "segmentControl4Four").element.tap()
        app.otherElements.matching(identifier: "segmentControl4Five").element.tap()
        app.otherElements.matching(identifier: "segmentControl4One").element.tap()
        
        changeThemes(app: app)
    }
    
    func testLogoTabs() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.tables.staticTexts["Tabs"].tap()
        app.tables.staticTexts["Logo Tabs"].tap()
        app.otherElements.matching(identifier: "SegmentControlDisabled").element.tap()
        app.otherElements.matching(identifier: "SegmentControlDefault").element.tap()
        
        app.otherElements.matching(identifier: "LogoTabOne2").element.tap()
        app.otherElements.matching(identifier: "LogoTabOne1").element.tap()
        
        app.otherElements.matching(identifier: "LogoTabTwo2").element.tap()
        app.otherElements.matching(identifier: "LogoTabTwo3").element.tap()
        app.otherElements.matching(identifier: "LogoTabTwo1").element.tap()
        
        app.otherElements.matching(identifier: "LogoTabThree2").element.tap()
        app.otherElements.matching(identifier: "LogoTabThree3").element.tap()
        app.otherElements.matching(identifier: "LogoTabThree4").element.tap()
        app.otherElements.matching(identifier: "LogoTabThree1").element.tap()
        
        app.otherElements.matching(identifier: "LogoTabFour2").element.tap()
        app.otherElements.matching(identifier: "LogoTabFour3").element.tap()
        app.otherElements.matching(identifier: "LogoTabFour4").element.tap()
        app.otherElements.matching(identifier: "LogoTabFour5").element.tap()
        app.otherElements.matching(identifier: "LogoTabFour1").element.tap()
        
        changeThemes(app: app)
    }
    
    func testInformerTabs() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.tables.staticTexts["Tabs"].tap()
        app.tables.staticTexts["Informer Tabs"].tap()
        app.otherElements.matching(identifier: "SegmentControlDisabled").element.tap()
        app.otherElements.matching(identifier: "SegmentControlDefault").element.tap()
        
        app.otherElements.matching(identifier: "InformerTabOne2").element.tap()
        app.otherElements.matching(identifier: "InformerTabOne1").element.tap()
        
        app.otherElements.matching(identifier: "InformerTabTwo2").element.tap()
        app.otherElements.matching(identifier: "InformerTabTwo3").element.tap()
        app.otherElements.matching(identifier: "InformerTabTwo1").element.tap()
        
        changeThemes(app: app)
    }
    
    func testOutlineSliderTabs() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.tables.staticTexts["Tabs"].tap()
        app.tables.staticTexts["Outline Slider Tabs"].tap()
        app.otherElements.matching(identifier: "SegmentControlDisabled").element.tap()
        app.otherElements.matching(identifier: "SegmentControlDefault").element.tap()
        
        app.cells.matching(identifier: "OutlineSliderTabOne2").element.tap()
        app.cells.matching(identifier: "OutlineSliderTabOne3").element.tap()
        app.cells.matching(identifier: "OutlineSliderTabOne1").element.tap()

        app.cells.matching(identifier: "OutlineSliderTabTwo2").element.tap()
        app.cells.matching(identifier: "OutlineSliderTabTwo3").element.tap()
        app.cells.matching(identifier: "OutlineSliderTabTwo4").element.tap()
        app.cells.matching(identifier: "OutlineSliderTabTwo5").element.tap()
        app.cells.matching(identifier: "OutlineSliderTabTwo6").element.tap()
        app.cells.matching(identifier: "OutlineSliderTabTwo7").element.tap()
        app.cells.matching(identifier: "OutlineSliderTabTwo7").element.swipeLeft()
        app.cells.matching(identifier: "OutlineSliderTabTwo8").element.tap()
        app.cells.matching(identifier: "OutlineSliderTabTwo9").element.tap()
        app.cells.matching(identifier: "OutlineSliderTabTwo9").element.swipeRight()
        app.cells.matching(identifier: "OutlineSliderTabTwo1").element.tap()
        
        app.cells.matching(identifier: "OutlineSliderTabThree2").element.tap()
        app.cells.matching(identifier: "OutlineSliderTabThree3").element.tap()
        app.cells.matching(identifier: "OutlineSliderTabThree4").element.tap()
        app.cells.matching(identifier: "OutlineSliderTabThree1").element.tap()
        
        changeThemes(app: app)
    }
    
    func testUnderlineSliderTabs() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.tables.staticTexts["Tabs"].tap()
        app.tables.staticTexts["Underline Tabs"].tap()
        app.tables.staticTexts["Slider"].tap()
        app.otherElements.matching(identifier: "SegmentControlDisabled").element.tap()
        app.otherElements.matching(identifier: "SegmentControlDefault").element.tap()
        
        app.cells.matching(identifier: "UnderlineSegmentedOne2").element.tap()
        app.cells.matching(identifier: "UnderlineSegmentedOne3").element.tap()
        app.cells.matching(identifier: "UnderlineSegmentedOne1").element.tap()
        
        app.cells.matching(identifier: "UnderlineSegmentedTwo2").element.tap()
        app.cells.matching(identifier: "UnderlineSegmentedTwo3").element.tap()
        app.cells.matching(identifier: "UnderlineSegmentedTwo4").element.tap()
        app.cells.matching(identifier: "UnderlineSegmentedTwo5").element.tap()
        app.cells.matching(identifier: "UnderlineSegmentedTwo6").element.tap()
        app.cells.matching(identifier: "UnderlineSegmentedTwo7").element.tap()
        app.cells.matching(identifier: "UnderlineSegmentedTwo7").element.swipeLeft()
        app.cells.matching(identifier: "UnderlineSegmentedTwo8").element.tap()
        app.cells.matching(identifier: "UnderlineSegmentedTwo9").element.tap()
        app.cells.matching(identifier: "UnderlineSegmentedTwo9").element.swipeRight()
        app.cells.matching(identifier: "UnderlineSegmentedTwo1").element.tap()
        
        app.cells.matching(identifier: "UnderlineSegmentedThree2").element.tap()
        app.cells.matching(identifier: "UnderlineSegmentedThree3").element.tap()
        app.cells.matching(identifier: "UnderlineSegmentedThree4").element.tap()
        app.cells.matching(identifier: "UnderlineSegmentedThree1").element.tap()
        
        changeThemes(app: app)
    }
    
    func testUnderlineCenterTabs() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.tables.staticTexts["Tabs"].tap()
        app.tables.staticTexts["Underline Tabs"].tap()
        app.tables.staticTexts["Center"].tap()
        app.otherElements.matching(identifier: "SegmentControlDisabled").element.tap()
        app.otherElements.matching(identifier: "SegmentControlDefault").element.tap()
        
        app.cells.matching(identifier: "UnderlineCenterSegmentedOne2").element.tap()
        app.cells.matching(identifier: "UnderlineCenterSegmentedOne1").element.tap()
        
        app.cells.matching(identifier: "UnderlineCenterSegmentedTwo2").element.tap()
        app.cells.matching(identifier: "UnderlineCenterSegmentedTwo3").element.tap()
        app.cells.matching(identifier: "UnderlineCenterSegmentedTwo1").element.tap()
        
        app.cells.matching(identifier: "UnderlineCenterSegmentedThree2").element.tap()
        app.cells.matching(identifier: "UnderlineCenterSegmentedThree3").element.tap()
        app.cells.matching(identifier: "UnderlineCenterSegmentedThree4").element.tap()
        app.cells.matching(identifier: "UnderlineCenterSegmentedThree1").element.tap()
        
        app.cells.matching(identifier: "UnderlineCenterSegmentedFour2").element.tap()
        app.cells.matching(identifier: "UnderlineCenterSegmentedFour3").element.tap()
        app.cells.matching(identifier: "UnderlineCenterSegmentedFour4").element.tap()
        app.cells.matching(identifier: "UnderlineCenterSegmentedFour5").element.tap()
        app.cells.matching(identifier: "UnderlineCenterSegmentedFour1").element.tap()
        
        app.cells.matching(identifier: "UnderlineCenterSegmentedFive2").element.tap()
        app.cells.matching(identifier: "UnderlineCenterSegmentedFive3").element.tap()
        app.cells.matching(identifier: "UnderlineCenterSegmentedFive1").element.tap()
        
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
