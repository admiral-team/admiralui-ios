//
//  ButtonListViewSnapshotTests.swift
//  AdmiralSwiftUITests
//
//  Created on 18.11.2021.
//

import XCTest
import SwiftUI
import SnapshotTesting
import AdmiralCore
import AdmiralTheme
import AdmiralUIResources
@testable import AdmiralSwiftUI

private struct ButtonListViewWrapper<T: View>: View {
    
    // MARK: - Properties
    let view: T
    
    // MARK: - Layout
    var body: some View {
        view
            .frame(width: 200, height: 50)
    }
    
}

final class ButtonListViewSnapshotTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        Appearance.prepare()
    }
    
    // MARK: Default Theme
    
    func testButtonListViewDefaultTheme() {
        Appearance.shared.theme = .default
        let view = createButtonListView()
        checkButtonListView(view: view, named: "DefaultTheme", testName: "ButtonListView")
    }
    
    // MARK: Dark Theme
    
    func testButtonListViewDarkTheme() {
        Appearance.shared.theme = .dark
        let view = createButtonListView()
        checkButtonListView(view: view, named: "DarkTheme", testName: "ButtonListView")
    }

    // MARK: - Scheme Provider

    func testSchemeProvider() {
        Appearance.shared.theme = .default
        var scheme = ButtonListViewScheme(theme: .default)
        scheme.buttonScheme.textColor.set(parameter: AColor(color: .systemPink), for: .normal)
        let newSchemeProvider = SchemeProvider<ButtonListViewScheme>(scheme: scheme)

        let view = createButtonListView(schemeProvider: newSchemeProvider)
        checkButtonListView(view: view, named: "SchemeProvider", testName: "ButtonListView")

        Appearance.shared.theme = .dark
        let newView = createButtonListView(schemeProvider: newSchemeProvider)
        checkButtonListView(view: newView, named: "SchemeProvider", testName: "ButtonListView")
    }
    
    func createButtonListView() -> some View {
        let view = ButtonListView(text: "Text", action: {})
        return view
    }

    func createButtonListView(schemeProvider: SchemeProvider<ButtonListViewScheme>) -> some View {
        let view = ButtonListView(
            text: "Text",
            schemeProvider: schemeProvider,
            action: {}
        )
        return view
    }
    
}

private extension ButtonListViewSnapshotTests {
    
    func checkButtonListView<T: View>(view: T, named: String, testName: String, disabled: Bool = false) {
        let buttonListViewWrapper = ButtonListViewWrapper(view: view)
        let view = UIHostingController(rootView: buttonListViewWrapper)
        let result = verifySnapshot(
            matching: view,
            as: .image,
            named: named,
            file: getFilePath(),
            testName: testName)
        XCTAssertNil(result)
    }
    
}
