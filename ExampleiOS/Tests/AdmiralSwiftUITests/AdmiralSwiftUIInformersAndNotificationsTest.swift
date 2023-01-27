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
    
    func testCheckSwiftUI() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["SeatingTabBarItem"].tap()
        let swiftUISwitcher = app.switches["SwitchToSwiftUI"]
        
        if swiftUISwitcher.value as? String == "0" {
            swiftUISwitcher.tap()
        }
    }
    
    func testBigInformers() {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["Informers & Notifications, Информеры"].tap()
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
        
        app.buttons["Informers & Notifications, Информеры"].tap()
        app.buttons["Informers"].tap()
        app.buttons["Small Informers"].tap()
        
        app.buttons["SegmentControlDisabled"].tap()
        app.buttons["SegmentControlDefault"].tap()
        
        changeThemes(app: app)
    }
    
    func testToast() {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["Informers & Notifications, Информеры"].tap()
        app.buttons["Notifications"].tap()
        app.buttons["Toast"].tap()
        app.buttons["ShowToast"].tap()
        app.buttons["ShowToast"].tap()
        
        changeThemes(app: app)
    }
    
    func testStatic() {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["Informers & Notifications, Информеры"].tap()
        app.buttons["Notifications"].tap()
        app.buttons["Static"].tap()
        
        app.buttons["SegmentControlDisabled"].tap()
        app.buttons["SegmentControlDefault"].tap()
        
        changeThemes(app: app)
    }
    
    func testAction() {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["Informers & Notifications, Информеры"].tap()
        app.buttons["Notifications"].tap()
        app.buttons["Action"].tap()
        app.buttons["ShowToast"].tap()
        sleep(6)
        app.buttons["ShowToast"].tap()
        app.buttons["ToastViewDown.closeButton"].tap()
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
