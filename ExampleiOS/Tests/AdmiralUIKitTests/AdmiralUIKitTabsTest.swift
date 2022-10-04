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
        app.staticTexts["Disabled"].tap()
        app.staticTexts["Default"].tap()
        
        let scrollViewsQuery = XCUIApplication().scrollViews
        let element5 = scrollViewsQuery.children(matching: .other).element(boundBy: 1)
        let element = element5.children(matching: .other).element(boundBy: 0)
        element.staticTexts["Two"].tap()
        element.staticTexts["One"].tap()
        
        let element2 = element5.children(matching: .other).element(boundBy: 1)
        element2.staticTexts["Two"].tap()
        element2.staticTexts["One"].tap()
        element2.staticTexts["Three"].tap()
        
        let element3 = element5.children(matching: .other).element(boundBy: 2)
        element3.staticTexts["Two"].tap()
        element3.staticTexts["One"].tap()
        element3.staticTexts["Three"].tap()
        element3.staticTexts["Four"].tap()
        
        let element4 = element5.children(matching: .other).element(boundBy: 3)
        element4.staticTexts["Two"].tap()
        element4.staticTexts["One"].tap()
        element4.staticTexts["Three"].tap()
        element4.staticTexts["Four"].tap()
        scrollViewsQuery.otherElements.staticTexts["Five"].tap()
        
        app.buttons["Ellipse"].tap()
        
        app.staticTexts["Light"].tap()
        app.staticTexts["Dark"].tap()
        app.staticTexts["SME Light"].tap()
        app.staticTexts["SME Dark"].tap()
        
        app.buttons["Ellipse"].tap()
    }
    
    func testLogoTabs() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.tables.staticTexts["Tabs"].tap()
        app.tables.staticTexts["Logo Tabs"].tap()
        app.staticTexts["Disabled"].tap()
        app.staticTexts["Default"].tap()
        
        let element3 = app.scrollViews.children(matching: .other).element(boundBy: 1)
        let element = element3.children(matching: .other).element(boundBy: 0).children(matching: .other).element
        element.children(matching: .other).element(boundBy: 2).children(matching: .other).element(boundBy: 1).tap()
        element.children(matching: .other).element(boundBy: 1).children(matching: .other).element(boundBy: 0).tap()
        
        let element8 = element3.children(matching: .other).element(boundBy: 1).children(matching: .other).element
        let element2 = element8.children(matching: .other).element(boundBy: 2)
        element2.children(matching: .other).element(boundBy: 1).tap()
        element8.children(matching: .other).element(boundBy: 1).children(matching: .other).element(boundBy: 0).tap()
        element2.children(matching: .other).element(boundBy: 2).tap()
        
        let element9 = element3.children(matching: .other).element(boundBy: 2).children(matching: .other).element
        let element4 = element9.children(matching: .other).element(boundBy: 2)
        element4.children(matching: .other).element(boundBy: 1).tap()
        
        let element5 = element9.children(matching: .other).element(boundBy: 1)
        element5.children(matching: .other).element(boundBy: 0).tap()
        element4.children(matching: .other).element(boundBy: 2).tap()
        element5.children(matching: .other).element(boundBy: 3).tap()
        
        let element10 = element3.children(matching: .other).element(boundBy: 3).children(matching: .other).element
        let element6 = element10.children(matching: .other).element(boundBy: 2)
        element6.children(matching: .other).element(boundBy: 1).tap()
        
        let element7 = element10.children(matching: .other).element(boundBy: 1)
        element7.children(matching: .other).element(boundBy: 0).tap()
        element6.children(matching: .other).element(boundBy: 2).tap()
        element7.children(matching: .other).element(boundBy: 3).tap()
        element7.children(matching: .other).element(boundBy: 4).tap()
        
        app.buttons["Ellipse"].tap()
        
        app.staticTexts["Light"].tap()
        app.staticTexts["Dark"].tap()
        app.staticTexts["SME Light"].tap()
        app.staticTexts["SME Dark"].tap()
        
        app.buttons["Ellipse"].tap()
    }
    
    func testInformerTabs() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.tables.staticTexts["Tabs"].tap()
        app.tables.staticTexts["Informer Tabs"].tap()
        app.staticTexts["Disabled"].tap()
        app.staticTexts["Default"].tap()
        
        let element3 = app.scrollViews.children(matching: .other).element(boundBy: 1)
        let element = element3.children(matching: .other).element(boundBy: 0).children(matching: .other).element(boundBy: 0).children(matching: .other).element
        element.children(matching: .other).element(boundBy: 1).staticTexts["в месяц"].tap()
        element.children(matching: .other).element(boundBy: 0).staticTexts["в месяц"].tap()
        
        let element2 = element3.children(matching: .other).element(boundBy: 1).children(matching: .other).element(boundBy: 0).children(matching: .other).element
        element2.children(matching: .other).element(boundBy: 1).tap()
        element2.children(matching: .other).element(boundBy: 0).tap()
        element2.children(matching: .other).element(boundBy: 2).tap()
        
        app.buttons["Ellipse"].tap()
        
        app.staticTexts["Light"].tap()
        app.staticTexts["Dark"].tap()
        app.staticTexts["SME Light"].tap()
        app.staticTexts["SME Dark"].tap()
        
        app.buttons["Ellipse"].tap()
    }
    
    func testIconTabs() throws {
        let app = XCUIApplication()
        app.launch()
        app.tables.staticTexts["Tabs"].tap()
        app.tables.staticTexts["Icon Tabs"].tap()
        app.staticTexts["Disabled"].tap()
        app.staticTexts["Default"].tap()
        
        let element3 = app.scrollViews.children(matching: .other).element(boundBy: 1)
        let element = element3.children(matching: .other).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element
        element.children(matching: .other).element(boundBy: 1).tap()
        element.children(matching: .other).element(boundBy: 0).tap()
        
        let element2 = element3.children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element
        element2.children(matching: .other).element(boundBy: 1).tap()
        element2.children(matching: .other).element(boundBy: 0).tap()
        element2.children(matching: .other).element(boundBy: 2).tap()
                
        app.buttons["Ellipse"].tap()
        
        app.staticTexts["Light"].tap()
        app.staticTexts["Dark"].tap()
        app.staticTexts["SME Light"].tap()
        app.staticTexts["SME Dark"].tap()
        
        app.buttons["Ellipse"].tap()
    }
}
