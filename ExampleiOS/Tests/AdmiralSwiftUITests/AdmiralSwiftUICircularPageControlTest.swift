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
    
    func testCircularPageControl() {
        let app = XCUIApplication()
        app.launch()
        
        checkFramework(width: app, framework: .switUI)
        
        app.buttons["Page Controls"].tap()
        app.buttons["Circle"].tap()
        
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
