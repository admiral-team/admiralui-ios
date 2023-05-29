//
//  SecurityTextFieldSnapshotTests.swift
//  AdmiralSwiftUITests
//
//  Created on 16.11.2021.
//

import XCTest
import SwiftUI
import SnapshotTesting
import AdmiralTheme
@testable import AdmiralSwiftUI

private struct SecurityTextFieldWrapper<T: View>: View {
    
    // MARK: - Properties
    let view: T
    
    // MARK: - Layout
    var body: some View {
        view
            .frame(width: 500, height: 200)
    }
    
}

final class SecurityTextFieldSnapshotTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        Appearance.prepare()
    }
    
    // MARK: Default Theme
    
    func testSecurityTextFieldDefaultStateDefaultTheme() {
        Appearance.shared.theme = .default
        let view = createSecurityTextField(state: .default)
        checkSecurityTextField(view: view, named: "DefaultStateDefaultTheme", testName: "SecurityTextField")
    }
    
    func testSecurityTextFieldNormalStateDefaultTheme() {
        Appearance.shared.theme = .default
        let view = createSecurityTextField(state: .normal)
        checkSecurityTextField(view: view, named: "NormalStateDefaultTheme", testName: "SecurityTextField")
    }
    
    func testSecurityTextFieldErrorStateDefaultTheme() {
        Appearance.shared.theme = .default
        let view = createSecurityTextField(state: .error)
        checkSecurityTextField(view: view, named: "ErrorStateDefaultTheme", testName: "SecurityTextField")
    }
    
    func testSecurityTextFieldDisabledStateDefaultTheme() {
        Appearance.shared.theme = .default
        let view = createSecurityTextField(state: .disabled)
        checkSecurityTextField(view: view, named: "DisabledStateDefaultTheme", testName: "SecurityTextField")
    }
    
    func testSecurityTextFieldReadOnlyStateDefaultTheme() {
        Appearance.shared.theme = .default
        let view = createSecurityTextField(state: .readOnly)
        checkSecurityTextField(view: view, named: "ReadOnlyStateDefaultTheme", testName: "SecurityTextField")
    }
    
    // MARK: Dark Theme
    
    func testSecurityTextFieldDefaultStateDarkTheme() {
        Appearance.shared.theme = .dark
        let view = createSecurityTextField(state: .default)
        checkSecurityTextField(view: view, named: "DefaultStateDarkTheme", testName: "SecurityTextField")
    }
    
    func testSecurityTextFieldNormalStateDarkTheme() {
        Appearance.shared.theme = .dark
        let view = createSecurityTextField(state: .normal)
        checkSecurityTextField(view: view, named: "NormalStateDarkTheme", testName: "SecurityTextField")
    }
    
    func testSecurityTextFieldErrorStateDarkTheme() {
        Appearance.shared.theme = .dark
        let view = createSecurityTextField(state: .error)
        checkSecurityTextField(view: view, named: "ErrorStateDarkTheme", testName: "SecurityTextField")
    }
    
    func testSecurityTextFieldDisabledStateDarkTheme() {
        Appearance.shared.theme = .dark
        let view = createSecurityTextField(state: .disabled)
        checkSecurityTextField(view: view, named: "DisabledStateDarkTheme", testName: "SecurityTextField")
    }
    
    func testSecurityTextFieldReadOnlyStateDarkTheme() {
        Appearance.shared.theme = .dark
        let view = createSecurityTextField(state: .readOnly)
        checkSecurityTextField(view: view, named: "ReadOnlyStateDarkTheme", testName: "SecurityTextField")
    }

    // MARK: - Scheme Provider

    func testSchemeProvider() {
        Appearance.shared.theme = .default
        var scheme = StandardTextFieldScheme()
        scheme.textColor = AColor(color: .systemPink)
        scheme.placeholderColor.set(parameter: AColor(color: .systemPink), for: .normal)
        scheme.underlineColor = AColor(color: .systemPink)
        let newSchemeProvider = SchemeProvider<StandardTextFieldScheme>(scheme: scheme)

        let view = createSecurityTextField(schemeProvider: newSchemeProvider)
        checkSecurityTextField(view: view, named: "SchemeProvider", testName: "SecurityTextField")

        Appearance.shared.theme = .dark
        let newView = createSecurityTextField(schemeProvider: newSchemeProvider)
        checkSecurityTextField(view: newView, named: "SchemeProvider", testName: "SecurityTextField")
    }
    
    func createSecurityTextField(state: TextInputState) -> some View {
        let view = SecurityTextField(
            .constant("Text"),
            accessibilityIdentifier: "123",
            contentType: .default,
            placeholder: "Placeholder",
            name: "Optional label",
            state: .constant(state),
            info: .constant("Additional text"))
        return view
    }

    func createSecurityTextField(schemeProvider: SchemeProvider<StandardTextFieldScheme>) -> some View {
        let view = SecurityTextField(
            .constant(nil),
            accessibilityIdentifier: "123",
            contentType: .default,
            placeholder: "Placeholder",
            name: "Optional label",
            state: .constant(.normal),
            info: .constant("Additional text"),
            schemeProvider: schemeProvider
        )
        return view
    }
    
}

private extension SecurityTextFieldSnapshotTests {
    
    func checkSecurityTextField<T: View>(view: T, named: String, testName: String, disabled: Bool = false) {
        let securityTextFieldWrapper = SecurityTextFieldWrapper(view: view)
        let view = UIHostingController(rootView: securityTextFieldWrapper)
        let result = verifySnapshot(
            matching: view,
            as: .image,
            named: named,
            file: getFilePath(),
            testName: testName)
        XCTAssertNil(result)
    }
    
}
