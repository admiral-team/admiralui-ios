//
//  DatePercentListViewSnapshotTests.swift
//  AdmiralSwiftUITests
//
//  Created on 18.11.2021.
//

import XCTest
import SwiftUI
import SnapshotTesting
import AdmiralTheme
import AdmiralUIResources
@testable import AdmiralSwiftUI

private struct DatePercentListViewWrapper<T: View>: View {
    
    // MARK: - Properties
    let view: T
    
    // MARK: - Layout
    var body: some View {
        view
            .frame(width: 400, height: 50)
    }
    
}

final class DatePercentListViewSnapshotTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        Appearance.prepare()
    }
    
    // MARK: - Default Theme
    
    func testDatePercentListViewDefaultTheme() {
        Appearance.shared.theme = .default
        let view = createDatePercentListView()
        checkDatePercentListView(view: view, named: "DefaultTheme", testName: "DatePercentListView")
    }
    
    // MARK: - Dark Theme
    
    func testDatePercentListViewDarkTheme() {
        Appearance.shared.theme = .dark
        let view = createDatePercentListView()
        checkDatePercentListView(view: view, named: "DarkTheme", testName: "DatePercentListView")
    }

    // MARK: - Scheme Provider

    func testSchemeProvider() {
        Appearance.shared.theme = .default
        var scheme = DatePercentListViewScheme(theme: .default)
        scheme.titleColor.set(parameter: AColor(color: .systemPink), for: .normal)
        scheme.subtitleColor.set(parameter: AColor(color: .systemPink), for: .normal)
        let newSchemeProvider = SchemeProvider<DatePercentListViewScheme>(scheme: scheme)

        let view = createDatePercentListView(schemeProvider: newSchemeProvider)
        checkDatePercentListView(view: view, named: "SchemeProvider", testName: "DatePercentListView")

        Appearance.shared.theme = .dark
        let newView = createDatePercentListView(schemeProvider: newSchemeProvider)
        checkDatePercentListView(view: newView, named: "SchemeProvider", testName: "DatePercentListView")
    }
    
    func createDatePercentListView() -> some View {
        let view = DatePercentListView(date: "Date", percent: "Text")
        return view
    }

    func createDatePercentListView(schemeProvider: SchemeProvider<DatePercentListViewScheme>) -> some View {
        let view = DatePercentListView(
            date: "Date",
            percent: "Text",
            schemeProvider: schemeProvider
        )
        return view
    }
    
}

private extension DatePercentListViewSnapshotTests {
    
    func checkDatePercentListView<T: View>(view: T, named: String, testName: String, disabled: Bool = false) {
        let datePercentListViewWrapper = DatePercentListViewWrapper(view: view)
        let view = UIHostingController(rootView: datePercentListViewWrapper)
        let result = verifySnapshot(
            matching: view,
            as: .image,
            named: named,
            file: getFilePath(),
            testName: testName)
        XCTAssertNil(result)
    }
    
}
