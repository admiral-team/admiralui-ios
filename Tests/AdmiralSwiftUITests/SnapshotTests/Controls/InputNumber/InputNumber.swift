//
//  InputNumber.swift
//  AdmiralUIResources
//
//  Created on 25.10.2021.
//

import XCTest
import SwiftUI
import SnapshotTesting
import AdmiralTheme
import AdmiralUIResources
@testable import AdmiralSwiftUI

final class InputNumberSnapshotTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        Appearance.prepare()
    }
    
    // MARK: Default Theme

    func testInputNumber() {
        SwiftUIThemeManager.shared.theme = .default
        let view = createInputNumber()
        checkInputNumber(view: view, named: "default", testName: "InputNumber")
    }
    
    // MARK: Dark Theme

    func testInputNumberDarkTheme() {
        SwiftUIThemeManager.shared.theme = .dark
        let view = createInputNumber()
        checkInputNumber(view: view, named: "defaultDarkTheme", testName: "InputNumber")
    }
    
    func createInputNumber() -> some View {
        let inputNumber = InputNumber(
            titleText: .constant("InputNumber"),
            value: .constant(5.0),
            minimumValue: .constant(0.0),
            maximumValue: .constant(10.0),
            stepValue: .constant(1.0)
        ).frame(width: 300, height: 60, alignment: .center)
        return inputNumber
    }

}

private extension InputNumberSnapshotTests {

    func checkInputNumber<T: View>(view: T, named: String, testName: String) {
        let view = UIHostingController(rootView: view)
        let result = verifySnapshot(
            matching: view,
            as: .image,
            named: named,
            file: getFilePath(),
            testName: testName)
        XCTAssertNil(result)
    }

}
