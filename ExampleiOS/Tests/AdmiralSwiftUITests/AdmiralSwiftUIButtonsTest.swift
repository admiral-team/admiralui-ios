//
//  AdmiralSwiftUIButtonsTest.swift
//  AdmiralSwiftUITests
//

import XCTest

class AdmiralSwiftUIButtonsTest: XCTestCase {
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    override func tearDownWithError() throws {
    }
    
    func testPrimaryButtons() throws {
        let app = XCUIApplication()
        app.launch()
        
        checkFramework(width: app, framework: .switUI)
        
        app.buttons["Buttons"].tap()
        app.buttons["Primary buttons"].tap()
        
        app.buttons["SegmentControlDisabled"].tap()
        app.buttons["SegmentControlDefault"].tap()
        
        app.buttons["TwoTitlePrimaryButtonStyleID"].press(forDuration: 1)
        app.buttons["BigButtonLeftID"].press(forDuration: 1)
        app.buttons["BigButtonRightID"].press(forDuration: 1)
        app.buttons["BigButtonNoneID"].press(forDuration: 1)
        app.buttons["MediumButtonLeftID"].press(forDuration: 1)
        app.buttons["MediumButtonRightID"].press(forDuration: 1)
        app.buttons["MediumButtonNoneID"].press(forDuration: 1)
        app.buttons["SmallButtonLeftID"].press(forDuration: 1)
        app.buttons["SmallButtonRightID"].press(forDuration: 1)
        app.buttons["SmallButtonNoneID"].press(forDuration: 1)
        
        changeThemes(app: app)
    }
    
    func testSecondaryButtons() throws {
        let app = XCUIApplication()
        app.launch()
        
        checkFramework(width: app, framework: .switUI)
        
        app.buttons["Buttons"].tap()
        app.buttons["Secondary buttons"].tap()
        
        app.buttons["SegmentControlDisabled"].tap()
        app.buttons["SegmentControlDefault"].tap()
        
        changeThemes(app: app)
        
        app.buttons["BigButtonLeftID"].press(forDuration: 1)
        app.buttons["BigButtonRightID"].press(forDuration: 1)
        app.buttons["BigButtonNoneID"].press(forDuration: 1)
        app.buttons["MediumButtonLeftID"].press(forDuration: 1)
        app.buttons["MediumButtonRightID"].press(forDuration: 1)
        app.buttons["MediumButtonNoneID"].press(forDuration: 1)
        app.buttons["SmallButtonLeftID"].press(forDuration: 1)
        app.buttons["SmallButtonRightID"].press(forDuration: 1)
        app.buttons["SmallButtonNoneID"].press(forDuration: 1)
    }
    
    func testGhostButtons() throws {
        let app = XCUIApplication()
        app.launch()
        
        checkFramework(width: app, framework: .switUI)
        
        app.buttons["Buttons"].tap()
        app.buttons["Ghost buttons"].tap()
        
        app.buttons["SegmentControlDisabled"].tap()
        app.buttons["SegmentControlDefault"].tap()
        
        changeThemes(app: app)
        
        app.buttons["BigButtonLeftID"].press(forDuration: 1)
        app.buttons["BigButtonRightID"].press(forDuration: 1)
        app.buttons["BigButtonNoneID"].press(forDuration: 1)
        app.buttons["MediumButtonLeftID"].press(forDuration: 1)
        app.buttons["MediumButtonRightID"].press(forDuration: 1)
        app.buttons["MediumButtonNoneID"].press(forDuration: 1)
        app.buttons["SmallButtonLeftID"].press(forDuration: 1)
        app.buttons["SmallButtonRightID"].press(forDuration: 1)
        app.buttons["SmallButtonNoneID"].press(forDuration: 1)
    }
    
    func testRules() throws {
        let app = XCUIApplication()
        app.launch()
        
        checkFramework(width: app, framework: .switUI)
        
        app.buttons["Buttons"].tap()
        app.buttons["Rules"].tap()
        
        app.buttons["SegmentControlDisabled"].tap()
        app.buttons["SegmentControlDefault"].tap()
        
        changeThemes(app: app)
       
        app.buttons["CheckBoxAccessibilityIdentifier"].tap()
        app.buttons["LinkButtonAccessibilityIdentifier"].tap()
    }
    
    func testOtherButtons() throws {
        let app = XCUIApplication()
        app.launch()
        
        checkFramework(width: app, framework: .switUI)
        
        app.buttons["Buttons"].tap()
        app.buttons["Other buttons"].tap()
        
        app.buttons["SegmentControlDisabled"].tap()
        app.buttons["SegmentControlDefault"].tap()
        
        changeThemes(app: app)
        
        app.buttons["AppleWalletButtonID"].tap()
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
