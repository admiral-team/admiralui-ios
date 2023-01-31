//
//  AdmiralSwiftUIInfoTest.swift
//  AdmiralSwiftUITests
//

import XCTest

class AdmiralSwiftUIInfoTest: XCTestCase {
    
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
    
    func testInfoDark() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["Ellipse"].tap()
        
        app.buttons["Dark"].tap()
        
        app.buttons["Ellipse"].tap()
        
        app.buttons["InfoTabBarItem"].tap()
        app.cells["Info"].tap()
        sleep(2)
    }
    
    func testInfoLight() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["Ellipse"].tap()
        
        app.buttons["Light"].tap()
        
        app.buttons["Ellipse"].tap()
        
        app.buttons["InfoTabBarItem"].tap()
        app.cells["Info"].tap()
        sleep(2)
    }
    
    func testInfoSMEDark() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["Ellipse"].tap()
        
        app.buttons["SME Dark"].tap()
        
        app.buttons["Ellipse"].tap()
        
        app.buttons["InfoTabBarItem"].tap()
        app.cells["Info"].tap()
        sleep(2)
    }
    
    func testInfoSMELight() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["Ellipse"].tap()
        
        app.buttons["SME Light"].tap()
        
        app.buttons["Ellipse"].tap()
        
        app.buttons["InfoTabBarItem"].tap()
        app.cells["Info"].tap()
        sleep(2)
    }
}
