//
//  InputRangeTextFieldSnapshotTests.swift
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

private struct InputRangeTextFieldWrapper<T: View>: View {
    
    // MARK: - Properties
    let view: T
    
    // MARK: - Layout
    var body: some View {
        view
            .frame(width: 800, height: 200)
    }
    
}

final class InputRangeTextFieldSnapshotTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        Appearance.prepare()
    }
    
    // MARK: Default Theme
    
    func testInputRangeTextFieldDefaultTheme() {
        Appearance.shared.theme = .default
        let view = createInputRangeTextField()
        checkInputRangeTextField(view: view, named: "DefaultTheme", testName: "InputRangeTextField")
    }
    
    // MARK: Dark Theme
    
    func testInputRangeTextFieldDarkTheme() {
        Appearance.shared.theme = .dark
        let view = createInputRangeTextField()
        checkInputRangeTextField(view: view, named: "DarkTheme", testName: "InputRangeTextField")
    }

    // MARK: - Scheme Provider

    func testSchemeProvider() {
        Appearance.shared.theme = .default
        var scheme = InputRangeTextFieldScheme()
        scheme.textFieldScheme.textColor = AColor(color: .systemPink)
        scheme.sliderScheme.tintColor.set(parameter: AColor(color: .systemPink), for: .normal)
        scheme.sliderScheme.thumbColor.set(parameter: AColor(color: .systemPink), for: .normal)
        let newSchemeProvider = SchemeProvider<InputRangeTextFieldScheme>(scheme: scheme)

        let view = createInputRangeTextField(schemeProvider: newSchemeProvider)
        checkInputRangeTextField(view: view, named: "SchemeProvider", testName: "InputRangeTextField")

        Appearance.shared.theme = .dark
        let newView = createInputRangeTextField(schemeProvider: newSchemeProvider)
        checkInputRangeTextField(view: newView, named: "SchemeProvider", testName: "InputRangeTextField")
    }
    
    func createInputRangeTextField() -> some View {
        let view = InputRangeTextField(.constant("InputRangeTextField"))
        return view
    }

    func createInputRangeTextField(schemeProvider: SchemeProvider<InputRangeTextFieldScheme>) -> some View {
        let view = InputRangeTextField(
            .constant("InputRangeTextField"),
            schemeProvider: schemeProvider
        )
        return view
    }
    
}

private extension InputRangeTextFieldSnapshotTests {
    
    func checkInputRangeTextField<T: View>(view: T, named: String, testName: String, disabled: Bool = false) {
        let inputRangeTextFieldWrapper = InputRangeTextFieldWrapper(view: view)
        let view = UIHostingController(rootView: inputRangeTextFieldWrapper)
        let result = verifySnapshot(
            matching: view,
            as: .image,
            named: named,
            file: getFilePath(),
            testName: testName)
        XCTAssertNil(result)
    }
    
}
