//
//  AdmiralSwiftUITestingLaunchTests.swift
//  AdmiralSwiftUITesting
//
//  Created on 20.10.2021.
//

import XCTest

class AdmiralSwiftUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        
        
        
        let elementsQuery = XCUIApplication().scrollViews.otherElements
        elementsQuery.buttons["Tabs, Вкладки"].tap()
        elementsQuery.buttons["Icon Tabs"].tap()
        elementsQuery.buttons["TwoControlsSecond"].tap()
        elementsQuery.buttons["TwoControlsFirst"].tap()
        
        app.buttons["SegmentControlDisabled"].tap()
        app.buttons["SegmentControlDefault"].tap()
        
                
        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app


    }
}
