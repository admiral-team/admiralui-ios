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
        
        app.collectionViews.children(matching: .other).otherElements.matching(identifier: "OutlineSliderTabOne2000").element.tap()
//        app.otherElements.matching(identifier: "OutlineSliderTabOne2000").element.tap()
//        app.otherElements.matching(identifier: "OutlineSliderTabOne3").element.tap()
//        app.otherElements.matching(identifier: "OutlineSliderTabOne1").element.tap()

//        app.otherElements.matching(identifier: "OutlineSliderTabTwo2").element.tap()
//        app.otherElements.matching(identifier: "OutlineSliderTabTwo3").element.tap()
//        app.otherElements.matching(identifier: "OutlineSliderTabTwo4").element.tap()
//        app.otherElements.matching(identifier: "OutlineSliderTabTwo5").element.tap()
//        app.otherElements.matching(identifier: "OutlineSliderTabTwo6").element.tap()
//        app.otherElements.matching(identifier: "OutlineSliderTabTwo7").element.tap()
//        app.otherElements.matching(identifier: "OutlineSliderTabTwo8").element.tap()
//        app.otherElements.matching(identifier: "OutlineSliderTabTwo9").element.tap()
//        app.otherElements.matching(identifier: "OutlineSliderTabTwo1").element.tap()
        
        changeThemes(app: app)
    }
    
    func changeThemes(app: XCUIApplication) {
        app.buttons["Ellipse"].tap()
        
        app.staticTexts["Light"].tap()
        app.staticTexts["Dark"].tap()
        app.staticTexts["SME Light"].tap()
        app.staticTexts["SME Dark"].tap()
        
        app.buttons["Ellipse"].tap()
    }
}
