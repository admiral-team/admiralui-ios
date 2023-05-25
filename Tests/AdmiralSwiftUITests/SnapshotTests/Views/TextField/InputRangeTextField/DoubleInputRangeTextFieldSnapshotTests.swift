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

    // MARK: - Scheme Provider

    func testSchemeProvider() {
        Appearance.shared.theme = .default
        var scheme = DoubleInputRangeTextFieldScheme()
        scheme.textColor = AColor(color: .systemPink)
        scheme.slider.thumbColor.set(parameter: AColor(color: .systemPink), for: .normal)
        scheme.slider.backgroundColor.set(parameter: AColor(color: .systemPink), for: .normal)
        scheme.textField.textColor = AColor(color: .systemPink)
        scheme.textField.errorColor = AColor(color: .systemPink)
        scheme.textField.underlineColor = AColor(color: .systemPink)
        scheme.textField.placeholderColor.set(parameter: AColor(color: .systemPink), for: .normal)
        let newSchemeProvider = SchemeProvider<DoubleInputRangeTextFieldScheme>(scheme: scheme)

        let view = createDoubleInputRangeTextField(schemeProvider: newSchemeProvider)
        checkDoubleInputRangeTextField(view: view, named: "SchemeProvider", testName: "DoubleInputRangeTextField")

        Appearance.shared.theme = .dark
        let newView = createDoubleInputRangeTextField(schemeProvider: newSchemeProvider)
        checkDoubleInputRangeTextField(view: newView, named: "SchemeProvider", testName: "DoubleInputRangeTextField")
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

    func createDoubleInputRangeTextField(schemeProvider: SchemeProvider<DoubleInputRangeTextFieldScheme>) -> some View {
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
            trailingText: .constant("₽"),
            schemeProvider: schemeProvider
        )
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
