//
//  AdmiralSwiftUIInformersAndNotificationsTest.swift
//  AdmiralSwiftUITests
//

import XCTest

class AdmiralSwiftUIInformersAndNotificationsTest: XCTestCase {
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    override func tearDownWithError() throws {
    }
    
    func testBigInformers() {
        let app = XCUIApplication()
        app.launch()
        
        checkFramework(width: app, framework: .switUI)
        
        app.buttons["Informers & Notifications"].tap()
        app.buttons["Informers"].tap()
        app.buttons["Big Informers"].tap()
        
        app.buttons["SegmentControlDisabled"].tap()
        app.buttons["SegmentControlDefault"].tap()
        
        changeThemes(app: app)
        
        app.buttons["ErrorLinkId"].tap()
        app.buttons["DefaultLinkId"].tap()
    }
    
    func testSmallInformers() {
        let app = XCUIApplication()
        app.launch()
        
        checkFramework(width: app, framework: .switUI)
        
        app.buttons["Informers & Notifications"].tap()
        app.buttons["Informers"].tap()
        app.buttons["Small Informers"].tap()
        
        app.buttons["SegmentControlDisabled"].tap()
        app.buttons["SegmentControlDefault"].tap()
        
        changeThemes(app: app)
    }
    
    func testToast() {
        let app = XCUIApplication()
        app.launch()
        
        checkFramework(width: app, framework: .switUI)
        
        app.buttons["Informers & Notifications"].tap()
        app.buttons["Notifications"].tap()
        app.buttons["Toast"].tap()
        app.buttons["ShowToast"].tap()
        app.buttons["ShowToast"].tap()
        
        changeThemes(app: app)
    }
    
    func testStatic() {
        let app = XCUIApplication()
        app.launch()
        
        checkFramework(width: app, framework: .switUI)
        
        app.buttons["Informers & Notifications"].tap()
        app.buttons["Notifications"].tap()
        app.buttons["Static"].tap()
        
        app.buttons["SegmentControlDisabled"].tap()
        app.buttons["SegmentControlDefault"].tap()
        
        changeThemes(app: app)
    }
    
    func testAction() {
        let app = XCUIApplication()
        app.launch()
        
        checkFramework(width: app, framework: .switUI)
        
        app.buttons["Informers & Notifications"].tap()
        app.buttons["Notifications"].tap()
        app.buttons["Action"].tap()
        app.buttons["ShowToast"].tap()
        sleep(6)
        app.buttons["ShowToast"].tap()
        app.buttons["ToastViewDown.closeButton"].tap()
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
