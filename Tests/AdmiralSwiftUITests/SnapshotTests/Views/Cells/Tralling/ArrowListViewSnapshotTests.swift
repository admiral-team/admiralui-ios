//
//  ArrowListViewSnapshotTests.swift
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

final class ArrowListViewSnapshotTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        Appearance.prepare()
    }
    
    // MARK: Default Theme
    
    func testArrowListViewDefaultTheme() {
        Appearance.shared.theme = .default
        let view = createArrowListView()
        checkArrowListView(view: view, named: "DefaultTheme", testName: "ArrowListView")
    }
    
    // MARK: Dark Theme
    
    func testArrowListViewDarkTheme() {
        Appearance.shared.theme = .dark
        let view = createArrowListView()
        checkArrowListView(view: view, named: "DarkTheme", testName: "ArrowListView")
    }

    // MARK: - Scheme Provider

    func testSchemeProvider() {
        Appearance.shared.theme = .default
        var scheme = ArrowListViewScheme(theme: .default)
        scheme.imageTintColor.set(parameter: AColor(color: .systemPink), for: .normal)
        let newSchemeProvider = SchemeProvider<ArrowListViewScheme>(scheme: scheme)

        let view = createArrowListView(schemeProvider: newSchemeProvider)
        checkArrowListView(view: view, named: "SchemeProvider", testName: "ArrowListView")

        Appearance.shared.theme = .dark
        let newView = createArrowListView(schemeProvider: newSchemeProvider)
        checkArrowListView(view: newView, named: "SchemeProvider", testName: "ArrowListView")
    }
    
    func createArrowListView() -> some View {
        let view = ArrowListView()
            .padding()
        return view
    }

    func createArrowListView(schemeProvider: SchemeProvider<ArrowListViewScheme>) -> some View {
        let view = ArrowListView(schemeProvider: schemeProvider)
            .padding()
        return view
    }
    
}

private extension ArrowListViewSnapshotTests {
    
    func checkArrowListView<T: View>(view: T, named: String, testName: String, disabled: Bool = false) {
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
