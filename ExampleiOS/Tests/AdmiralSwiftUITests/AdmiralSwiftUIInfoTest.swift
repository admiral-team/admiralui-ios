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
    
    func testInfoDark() throws {
        let app = XCUIApplication()
        app.launch()
        
        checkFramework(width: app, framework: .switUI)
        
        app.buttons["Ellipse"].tap()
        
        app.buttons["ThemeSwitchButton_Dark"].tap()
        
        app.buttons["Ellipse"].tap()
        
        app.buttons["InfoTabBarItem"].tap()
        app.cells["Info"].tap()
        sleep(2)
    }
    
    func testInfoLight() throws {
        let app = XCUIApplication()
        app.launch()
        
        checkFramework(width: app, framework: .switUI)
        
        app.buttons["Ellipse"].tap()
        
        app.buttons["ThemeSwitchButton_Light"].tap()
        
        app.buttons["Ellipse"].tap()
        
        app.buttons["InfoTabBarItem"].tap()
        app.cells["Info"].tap()
        sleep(2)
    }
    
    func testInfoSMEDark() throws {
        let app = XCUIApplication()
        app.launch()
        
        checkFramework(width: app, framework: .switUI)
        
        app.buttons["Ellipse"].tap()

        app.buttons["ThemeSwitchButton_SME Dark"].tap()
        
        app.buttons["Ellipse"].tap()
        
        app.buttons["InfoTabBarItem"].tap()
        app.cells["Info"].tap()
        sleep(2)
    }
    
    func testInfoSMELight() throws {
        let app = XCUIApplication()
        app.launch()
        
        checkFramework(width: app, framework: .switUI)
        
        app.buttons["Ellipse"].tap()
        
        app.buttons["ThemeSwitchButton_Light"].tap()
        
        app.buttons["Ellipse"].tap()
        
        app.buttons["InfoTabBarItem"].tap()
        app.cells["Info"].tap()
        sleep(2)
    }
}
