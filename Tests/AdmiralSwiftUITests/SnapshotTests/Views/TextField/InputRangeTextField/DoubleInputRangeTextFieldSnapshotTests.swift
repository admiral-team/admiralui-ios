//
//  DoubleInputRangeTextFieldSnapshotTests.swift
//  AdmiralSwiftUITests
//
//  Created on 16.11.2021.
//

import XCTest
import SwiftUI
import SnapshotTesting
import AdmiralTheme
import AdmiralUIResources
@testable import AdmiralSwiftUI

private struct DoubleInputRangeTextFieldWrapper<T: View>: View {
    
    // MARK: - Properties
    let view: T
    
    // MARK: - Layout
    var body: some View {
        view
            .frame(width: 500, height: 150)
    }
    
}

final class DoubleInputRangeTextFieldSnapshotTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        Appearance.prepare()
    }
    
    // MARK: Default Theme
    
    func testDoubleInputRangeTextFieldDefaultTheme() {
        Appearance.shared.theme = .default
        let view = createDoubleInputRangeTextField()
        checkDoubleInputRangeTextField(view: view, named: "DefaultTheme", testName: "DoubleInputRangeTextField")
    }
    
    // MARK: Dark Theme
    
    func testDoubleInputRangeTextFieldDarkTheme() {
        Appearance.shared.theme = .dark
        let view = createDoubleInputRangeTextField()
        checkDoubleInputRangeTextField(view: view, named: "DarkTheme", testName: "DoubleInputRangeTextField")
    }
    
    func createDoubleInputRangeTextField() -> some View {
        let view = DoubleInputRangeTextField(
            .constant("Content"),
            contentTo: .constant("contentTo"),
            placeholderFrom: "PlaceholderFrom",
            placeholderTo: "PlaceholderTo",
            name: "Optional label",
            info: .constant("Additional text"),
            sliderValueFrom: 100,
            sliderValueTo: 300,
            minValue: 100,
            maxValue: 1000,
            leadingText: .constant("₽"),
            trailingText: .constant("₽"))
        return view
    }
    
}

private extension DoubleInputRangeTextFieldSnapshotTests {
    
    func checkDoubleInputRangeTextField<T: View>(view: T, named: String, testName: String, disabled: Bool = false) {
        let doubleInputRangeTextFieldWrapper = DoubleInputRangeTextFieldWrapper(view: view)
        let view = UIHostingController(rootView: doubleInputRangeTextFieldWrapper)
        let result = verifySnapshot(
            matching: view,
            as: .image,
            named: named,
            file: getFilePath(),
            testName: testName)
        XCTAssertNil(result)
    }
    
}
