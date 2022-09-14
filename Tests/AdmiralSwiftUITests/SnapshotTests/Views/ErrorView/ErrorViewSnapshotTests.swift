//
//  ErrorViewSnapshotTests.swift
//  AdmiralSwiftUITests
//
//  Created on 09.11.2021.
//

import XCTest
import SwiftUI
import SnapshotTesting
import AdmiralTheme
import AdmiralUIResources
@testable import AdmiralSwiftUI

private struct ErrorViewWrapper<T: View>: View {

    // MARK: - Properties
    let view: T

    // MARK: - Layout
    var body: some View {
        view
            .frame(width: 300, height: 300)
    }

}

final class ErrorViewSnapshotTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        Appearance.prepare()
    }
    
    // MARK: Default Theme
    
    func testErrorViewDefaultTheme() {
        Appearance.shared.theme = .default
        let view = createErrorView()
        checkErrorView(view: view, named: "DefaultTheme", testName: "ErrorView")
    }
    
    // MARK: Dark Theme
    
    func testErrorViewDarkTheme() {
        Appearance.shared.theme = .dark
        let view = createErrorView()
        checkErrorView(view: view, named: "DarkTheme", testName: "ErrorView")
    }

    func testErrorViewSchemeProvider() {
        Appearance.shared.theme = .default
        var scheme = ErrorViewScheme(theme: .default)
        scheme.titleColor = AColor(color: .systemPink)
        let newSchemeProvider = SchemeProvider<ErrorViewScheme>(scheme: scheme)

        let view = createErrorView(schemeProvider: newSchemeProvider)
        checkErrorView(view: view, named: "NewSchemeProvider", testName: "ErrorView")

        Appearance.shared.theme = .dark
        let newView = createErrorView(schemeProvider: newSchemeProvider)
        checkErrorView(view: newView, named: "NewSchemeProvider", testName: "ErrorView")
    }
    
    func createErrorView() -> some View {
        let errorView = ErrorView(
            text: "ErrorView",
            buttonTitle: "Button",
            buttonAction: {})
        return errorView
    }

    func createErrorView(schemeProvider: SchemeProvider<ErrorViewScheme>) -> some View {
        let errorView = ErrorView(
            text: "ErrorView",
            buttonTitle: "Button",
            buttonAction: {},
            schemeProvider: schemeProvider
        )
        return errorView
    }
    
}

private extension ErrorViewSnapshotTests {

    func checkErrorView<T: View>(view: T, named: String, testName: String, disabled: Bool = false) {
        let errorViewWrapper = ErrorViewWrapper(view: view)
        let view = UIHostingController(rootView: errorViewWrapper)
        let result = verifySnapshot(
            matching: view,
            as: .image,
            named: named,
            file: getFilePath(),
            testName: testName)
        XCTAssertNil(result)
    }

}
