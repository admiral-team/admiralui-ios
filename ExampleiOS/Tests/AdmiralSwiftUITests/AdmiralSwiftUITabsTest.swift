//
//  AdmiralSwiftUITabsTest.swift
//  AdmiralSwiftUITests
//

import XCTest

class AdmiralSwiftUITabsTest: XCTestCase {
    
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
    
    func testLogoTabs() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["Tabs"].tap()
        app.buttons["Logo Tabs"].tap()
        
        app.buttons["SegmentControlDisabled"].tap()
        app.buttons["SegmentControlDefault"].tap()
        
        changeThemes(app: app)
        
        app.buttons["TwoControlsSecond"].tap()
        app.buttons["TwoControlsFirst"].tap()
        
        app.buttons["ThreeControlsSecond"].tap()
        app.buttons["ThreeControlsThird"].tap()
        app.buttons["ThreeControlsFirst"].tap()
        
        app.buttons["FourControlsSecond"].tap()
        app.buttons["FourControlsThird"].tap()
        app.buttons["FourControlsFourth"].tap()
        app.buttons["FourControlsFirst"].tap()
        
        app.buttons["FiveControlsSecond"].tap()
        app.buttons["FiveControlsThird"].tap()
        app.buttons["FiveControlsFourth"].tap()
        app.buttons["FiveControlsFive"].tap()
        app.buttons["FiveControlsFirst"].tap()
        
    }
    
    func testInformerTabs() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["Tabs"].tap()
        app.buttons["Informer Tabs"].tap()
        
        app.buttons["SegmentControlDisabled"].tap()
        app.buttons["SegmentControlDefault"].tap()
        
        changeThemes(app: app)
        
        app.buttons["TwoControlsSecond"].tap()
        app.buttons["TwoControlsFirst"].tap()
        
        app.buttons["ThreeControlsSecond"].tap()
        app.buttons["ThreeControlsThird"].tap()
        app.buttons["ThreeControlsFirst"].tap()
    }
    
    func testOutlineSliderTabs() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["Tabs"].tap()
        app.buttons["Outline Slider Tabs"].tap()
        
        app.buttons["SegmentControlDisabled"].tap()
        app.buttons["SegmentControlDefault"].tap()
        
        changeThemes(app: app)
        
        app.buttons["ThreeControlsSecond"].tap()
        app.buttons["ThreeControlsThird"].tap()
        app.buttons["ThreeControlsFirst"].tap()
        
        app.buttons["SliderControlsSecond"].tap()
        app.buttons["SliderControlsFirst"].tap()
        app.buttons["SliderControlsThird"].tap()
        app.buttons["SliderControlsFourth"].tap()
        app.buttons["SliderControlsFifth"].tap()
        app.buttons["SliderControlsFifth"].swipeLeft()
        app.buttons["SliderControlsSixth"].tap()
        app.buttons["SliderControlsSeventh"].tap()
        app.buttons["SliderControlsEighth"].tap()
        app.buttons["SliderControlsNineth"].tap()
        app.buttons["SliderControlsTenth"].tap()
        app.buttons["SliderControlsEleventh"].tap()
        
        app.buttons["NotificationsSecond"].tap()
        app.buttons["NotificationsThird"].tap()
        app.buttons["NotificationsFourth"].tap()
        app.buttons["NotificationsFirst"].tap()
    }
    
    func testUnderlineSliderTabs() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["Tabs"].tap()
        app.buttons["Underline Tabs"].tap()
        app.buttons["Slider"].tap()
        
        app.buttons["SegmentControlDisabled"].tap()
        app.buttons["SegmentControlDefault"].tap()
        
        changeThemes(app: app)
        
        app.buttons["ThreeControlsSecond"].tap()
        app.buttons["ThreeControlsThird"].tap()
        app.buttons["ThreeControlsFirst"].tap()
        
        app.buttons["SliderControlsSecond"].tap()
        app.buttons["SliderControlsThird"].tap()
        app.buttons["SliderControlsFirst"].tap()
        app.buttons["SliderControlsFourth"].tap()
        app.buttons["SliderControlsFifth"].tap()
        app.buttons["SliderControlsSixth"].tap()
        app.buttons["SliderControlsSeventh"].tap()
        app.buttons["SliderControlsEighth"].tap()
        app.buttons["SliderControlsEighth"].swipeLeft()
        app.buttons["SliderControlsNineth"].tap()
        app.buttons["SliderControlsTenth"].tap()
        app.buttons["SliderControlsEleventh"].tap()
        
        app.buttons["NotificationsSecond"].tap()
        app.buttons["NotificationsThird"].tap()
        app.buttons["NotificationsFourth"].tap()
        app.buttons["NotificationsFirst"].tap()
        
    }
    
    func testUnderlineCenterTabs() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["Tabs"].tap()
        app.buttons["Underline Tabs"].tap()
        app.buttons["Center"].tap()
        
        app.buttons["SegmentControlDisabled"].tap()
        app.buttons["SegmentControlDefault"].tap()
        
        changeThemes(app: app)
        
        app.buttons["TwoControlsSecond"].tap()
        app.buttons["TwoControlsFirst"].tap()
        
        app.buttons["ThreeControlsSecond"].tap()
        app.buttons["ThreeControlsThird"].tap()
        app.buttons["ThreeControlsFirst"].tap()
        
        app.buttons["FourControlsSecond"].tap()
        app.buttons["FourControlsThird"].tap()
        app.buttons["FourControlsFourth"].tap()
        app.buttons["FourControlsFirst"].tap()
        
        app.buttons["FiveControlsSecond"].tap()
        app.buttons["FiveControlsThird"].tap()
        app.buttons["FiveControlsFourth"].tap()
        app.buttons["FiveControlsFifth"].tap()
        app.buttons["FiveControlsFirst"].tap()
    }
    
    func testIconTabs() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["Tabs"].tap()
        app.buttons["Icon Tabs"].tap()
        
        app.buttons["SegmentControlDisabled"].tap()
        app.buttons["SegmentControlDefault"].tap()
        
        changeThemes(app: app)
        
        app.buttons["TwoControlsSecond"].tap()
        app.buttons["TwoControlsFirst"].tap()
        
        app.buttons["ThreeControlsSecond"].tap()
        app.buttons["ThreeControlsThird"].tap()
        app.buttons["ThreeControlsFirst"].tap()
        
        app.buttons["EmbeddedInScrollViewSecond"].tap()
        app.buttons["EmbeddedInScrollViewFirst"].tap()
        app.buttons["EmbeddedInScrollViewThird"].tap()
        app.buttons["EmbeddedInScrollViewThird"].swipeLeft()
        app.buttons["EmbeddedInScrollViewFourth"].tap()
        app.buttons["EmbeddedInScrollViewFifth"].tap()
    }
    
    func testStandartTabs() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["Tabs"].tap()
        app.buttons["Standard Tabs"].tap()
        
        app.buttons["SegmentControlDisabled"].tap()
        app.buttons["SegmentControlDefault"].tap()
        
        changeThemes(app: app)
        
        app.buttons["TwoControlsSecond"].tap()
        app.buttons["TwoControlsFirst"].tap()
        
        app.buttons["ThreeControlsSecond"].tap()
        app.buttons["ThreeControlsThird"].tap()
        app.buttons["ThreeControlsFirst"].tap()
        
        app.buttons["FourControlsSecond"].tap()
        app.buttons["FourControlsThird"].tap()
        app.buttons["FourControlsFourth"].tap()
        app.buttons["FourControlsFirst"].tap()
        
        app.buttons["FiveControlsSecond"].tap()
        app.buttons["FiveControlsThird"].tap()
        app.buttons["FiveControlsFourth"].tap()
        app.buttons["FiveControlsFifth"].tap()
        app.buttons["FiveControlsFirst"].tap()
    }
    
    func changeThemes(app: XCUIApplication) {
        app.buttons["Ellipse"].tap()
        
        app.buttons["Dark"].tap()
        app.buttons["SME Light"].tap()
        app.buttons["SME Dark"].tap()
        app.buttons["Light"].tap()
        
        app.buttons["Ellipse"].tap()
    }
}
