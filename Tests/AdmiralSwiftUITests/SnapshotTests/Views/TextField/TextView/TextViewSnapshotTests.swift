//
//  TextViewSnapshotTests.swift
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

private struct TextViewWrapper<T: View>: View {
    
    // MARK: - Properties
    let view: T
    
    // MARK: - Layout
    var body: some View {
        view
            .frame(width: 300, height: 200)
    }
    
}

final class TextViewSnapshotTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        Appearance.prepare()
    }
    
    // MARK: Default Theme
    
    func testTextViewNormalDefaultTheme() {
        Appearance.shared.theme = .default
        let view = createTextView(state: .normal)
        checkTextView(view: view, named: "Normal.DefaultTheme", testName: "TextView")
    }
    
    func testTextViewReadOnlyDefaultTheme() {
        Appearance.shared.theme = .default
        let view = createTextView(state: .readOnly)
        checkTextView(view: view, named: "ReadOnly.DefaultTheme", testName: "TextView")
    }
    
    func testTextViewDisabledDefaultTheme() {
        Appearance.shared.theme = .default
        let view = createTextView(state: .disabled)
        checkTextView(view: view, named: "Disabled.DefaultTheme", testName: "TextView")
    }
    
    func testTextViewErrorDefaultTheme() {
        Appearance.shared.theme = .default
        let view = createTextView(state: .error)
        checkTextView(view: view, named: "Error.DefaultTheme", testName: "TextView")
    }
    
    // MARK: Dark Theme
    
    func testTextViewNormalDarkTheme() {
        Appearance.shared.theme = .dark
        let view = createTextView(state: .normal)
        checkTextView(view: view, named: "Normal.DarkTheme", testName: "TextView")
    }
    
    func testTextViewReadOnlyDarkTheme() {
        Appearance.shared.theme = .dark
        let view = createTextView(state: .readOnly)
        checkTextView(view: view, named: "ReadOnly.DarkTheme", testName: "TextView")
    }
    
    func testTextViewDisabledDarkTheme() {
        Appearance.shared.theme = .dark
        let view = createTextView(state: .disabled)
        checkTextView(view: view, named: "Disabled.DarkTheme", testName: "TextView")
    }
    
    func testTextViewErrorDarkTheme() {
        Appearance.shared.theme = .dark
        let view = createTextView(state: .error)
        checkTextView(view: view, named: "Error.DarkTheme", testName: "TextView")
    }

    // MARK: - Scheme Provider

    func testSchemeProvider() {
        Appearance.shared.theme = .default
        var scheme = StandardTextFieldScheme()
        scheme.textColor = AColor(color: .systemPink)
        scheme.placeholderColor.set(parameter: AColor(color: .systemPink), for: .normal)
        scheme.underlineColor = AColor(color: .systemPink)
        let newSchemeProvider = SchemeProvider<StandardTextFieldScheme>(scheme: scheme)

        let view = createTextView(schemeProvider: newSchemeProvider)
        checkTextView(view: view, named: "SchemeProvider", testName: "TextView")

        Appearance.shared.theme = .dark
        let newView = createTextView(schemeProvider: newSchemeProvider)
        checkTextView(view: newView, named: "SchemeProvider", testName: "TextView")
    }
    
    func createTextView(state: TextInputState) -> some View {
        let view = TextView(
            .constant("Text"),
            contentType: .default,
            placeholder: "Placeholder",
            name: "Optional label",
            state: .constant(state),
            info: .constant("Additional text"),
            infoNumberOfLines: 3)
        return view
    }

    func createTextView(schemeProvider: SchemeProvider<StandardTextFieldScheme>) -> some View {
        let view = TextView(
            .constant("Text"),
            contentType: .default,
            placeholder: "Placeholder",
            name: "Optional label",
            state: .constant(.normal),
            info: .constant("Additional text"),
            infoNumberOfLines: 3,
            schemeProvider: schemeProvider
        )
        return view
    }
    
}

private extension TextViewSnapshotTests {
    
    func checkTextView<T: View>(view: T, named: String, testName: String, disabled: Bool = false) {
        let textViewWrapper = TextViewWrapper(view: view)
        let view = UIHostingController(rootView: textViewWrapper)
        let result = verifySnapshot(
            matching: view,
            as: .image,
            named: named,
            file: getFilePath(),
            testName: testName)
        XCTAssertNil(result)
    }
    
}
