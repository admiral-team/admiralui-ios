//
//  StandardTextFieldSnapshotTests.swift
//  AdmiralSwiftUITests
//
//  Created on 16.11.2021.
//

import XCTest
import SwiftUI
import SnapshotTesting
import AdmiralTheme
@testable import AdmiralSwiftUI

private struct StandardTextFieldWrapper<T: View>: View {
    
    // MARK: - Properties
    let view: T
    
    // MARK: - Layout
    var body: some View {
        view
            .frame(width: 500, height: 300)
    }
    
}

final class StandardTextFieldSnapshotTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        Appearance.prepare()
    }
    
    // MARK: Default Theme
    
    func testStandardTextFieldDefaultTheme() {
        Appearance.shared.theme = .default
        let view = createStandardTextField()
        checkStandardTextField(view: view, named: "DefaultTheme", testName: "StandardTextField")
    }
    
    // MARK: Dark Theme
    
    func testStandardTextFieldDarkTheme() {
        Appearance.shared.theme = .dark
        let view = createStandardTextField()
        checkStandardTextField(view: view, named: "DarkTheme", testName: "StandardTextField")
    }

    // MARK: - Scheme Provider

    func testSchemeProvider() {
        Appearance.shared.theme = .default
        var scheme = StandardTextFieldScheme()
        scheme.textColor = AColor(color: .systemPink)
        scheme.placeholderColor.set(parameter: AColor(color: .systemPink), for: .normal)
        scheme.underlineColor = AColor(color: .systemPink)
        let newSchemeProvider = SchemeProvider<StandardTextFieldScheme>(scheme: scheme)

        let view = createStandardTextField(schemeProvider: newSchemeProvider)
        checkStandardTextField(view: view, named: "SchemeProvider", testName: "StandardTextField")

        Appearance.shared.theme = .dark
        let newView = createStandardTextField(schemeProvider: newSchemeProvider)
        checkStandardTextField(view: newView, named: "SchemeProvider", testName: "StandardTextField")
    }
    
    func createStandardTextField() -> some View {
        let view = StandardTextField(
            value: .constant("Text"),
            accessibilityIdentifier: "testTextField",
            formatter: Formatter(),
            contentType: .default,
            placeholder: "Placeholder",
            name: "Optional label",
            state: .constant(.normal),
            info: .constant("Additional text"),
            infoNumberOfLines: nil)
        return view
    }

    func createStandardTextField(
        schemeProvider: SchemeProvider<StandardTextFieldScheme>
    ) -> some View {
        let view = StandardTextField(
            value: .constant("Text"),
            accessibilityIdentifier: "testTextField",
            formatter: Formatter(),
            contentType: .default,
            placeholder: "Placeholder",
            name: "Optional label",
            state: .constant(.normal),
            info: .constant("Additional text"),
            infoNumberOfLines: nil,
            schemeProvider: schemeProvider
        )
        return view
    }
    
}

private extension StandardTextFieldSnapshotTests {
    
    func checkStandardTextField<T: View>(view: T, named: String, testName: String, disabled: Bool = false) {
        let standardTextFieldWrapper = StandardTextFieldWrapper(view: view)
        let view = UIHostingController(rootView: standardTextFieldWrapper)
        let result = verifySnapshot(
            matching: view,
            as: .image,
            named: named,
            file: getFilePath(),
            testName: testName)
        XCTAssertNil(result)
    }
    
}
