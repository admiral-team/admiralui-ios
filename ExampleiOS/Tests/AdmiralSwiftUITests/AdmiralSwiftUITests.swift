//
//  AdmiralSwiftUITesting.swift
//  AdmiralSwiftUITesting
//
//  Created on 20.10.2021.
//

import XCTest

class UITextFieldAccesabilityUITests: XCTestCase {

    private var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        self.app = XCUIApplication()
        self.app.launch()
        checkFramework(width: app, framework: .switUI)
    }

    func test_text_field() {
        let taskNameTextField = self.app.textFields["testTextField"]
        let testString = "test example"
        taskNameTextField.tap()
        taskNameTextField.typeText(testString)
        XCTAssertEqual(testString.count, 12)
    }

}
