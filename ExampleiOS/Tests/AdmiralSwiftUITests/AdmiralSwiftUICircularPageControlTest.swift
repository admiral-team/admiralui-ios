//
//  AdmiralSwiftUICircularPageControlTest.swift
//  AdmiralSwiftUITests
//

import XCTest

class AdmiralSwiftUICircularPageControlTest: XCTestCase {
    
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
    
    func testCircularPageControl() {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["Page Controls"].tap()
        app.buttons["Circular"].tap()
        
        app.buttons["SliderControlsSecond"].tap()
        app.buttons["SliderControlsFirst"].tap()
        app.buttons["SliderControlsThird"].tap()
        app.buttons["SliderControlsFourth"].tap()
        app.buttons["SliderControlsFifth"].tap()
        app.buttons["SliderControlsFifth"].swipeLeft()
        app.buttons["SliderControlsSeventh"].tap()
        app.buttons["SliderControlsEighth"].tap()
        app.buttons["SliderControlsNineth"].tap()
        app.buttons["SliderControlsTenth"].tap()
        app.buttons["SliderControlsEleventh"].tap()
        app.buttons["SliderControlsEleventh"].swipeRight()
        
        for _ in 0..<11 {
            app.buttons["NextCircularPageControll"].tap()
        }
    }
}
