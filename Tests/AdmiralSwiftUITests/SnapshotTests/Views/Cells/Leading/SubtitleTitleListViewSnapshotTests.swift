//
//  SubtitleTitleListViewSnapshotTests.swift
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

private struct SubtitleTitleListViewWrapper<T: View>: View {
    
    // MARK: - Properties
    let view: T
    
    // MARK: - Layout
    var body: some View {
        view
            .frame(width: 500, height: 300)
    }
    
}

final class SubtitleTitleListViewSnapshotTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        Appearance.prepare()
    }
    
    // MARK: Default Theme
    
    func testSubtitleTitleListViewHeadlineSecondaryDefaultTheme() {
        Appearance.shared.theme = .default
        let view = createSubtitleTitleListView(style: .headlineSecondary)
        checkSubtitleTitleListView(view: view, named: "HeadlineSecondaryDefaultTheme", testName: "SubtitleTitleList")
    }
    
    func testSubtitleTitleListViewBodyDefaultTheme() {
        Appearance.shared.theme = .default
        let view = createSubtitleTitleListView(style: .body)
        checkSubtitleTitleListView(view: view, named: "BodyDefaultTheme", testName: "SubtitleTitleList")
    }
    
    func testSubtitleTitleListViewHeadlineDefaultTheme() {
        Appearance.shared.theme = .default
        let view = createSubtitleTitleListView(style: .headline)
        checkSubtitleTitleListView(view: view, named: "HeadlineDefaultTheme", testName: "SubtitleTitleList")
    }
    
    // MARK: Dark Theme
    
    func testSubtitleTitleListViewHeadlineSecondaryDarkTheme() {
        Appearance.shared.theme = .dark
        let view = createSubtitleTitleListView(style: .headlineSecondary)
        checkSubtitleTitleListView(view: view, named: "HeadlineSecondaryDarkTheme", testName: "SubtitleTitleList")
    }
    
    func testSubtitleTitleListViewBodyDarkTheme() {
        Appearance.shared.theme = .dark
        let view = createSubtitleTitleListView(style: .body)
        checkSubtitleTitleListView(view: view, named: "BodyDarkTheme", testName: "SubtitleTitleList")
    }
    
    func testSubtitleTitleListViewHeadlineDarkTheme() {
        Appearance.shared.theme = .dark
        let view = createSubtitleTitleListView(style: .headline)
        checkSubtitleTitleListView(view: view, named: "HeadlineDarkTheme", testName: "SubtitleTitleList")
    }

    // MARK: - Scheme Provider

    func testSchemeProvider() {
        Appearance.shared.theme = .default
        var scheme = SubtitleTitleListViewScheme(theme: .default)
        scheme.titleColor.set(parameter: AColor(color: .systemPink), for: .normal)
        scheme.subtitleColor.set(parameter: AColor(color: .systemPink), for: .normal)
        let newSchemeProvider = SchemeProvider<SubtitleTitleListViewScheme>(scheme: scheme)

        let view = createSubtitleTitleListView(schemeProvider: newSchemeProvider)
        checkSubtitleTitleListView(view: view, named: "SchemeProvider", testName: "SubtitleTitleList")

        Appearance.shared.theme = .dark
        let newView = createSubtitleTitleListView(schemeProvider: newSchemeProvider)
        checkSubtitleTitleListView(view: newView, named: "SchemeProvider", testName: "SubtitleTitleList")
    }
    
    func createSubtitleTitleListView(style: TitleSubtitleListViewStyle) -> some View {
        let view = SubtitleTitleListView(
            title: "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.",
            subtitle: "SubtitleListView",
            lineLimit: 3,
            titleSubtitleListViewStyle: style)
            .padding()
        return view
    }

    func createSubtitleTitleListView(schemeProvider: SchemeProvider<SubtitleTitleListViewScheme>) -> some View {
        let view = SubtitleTitleListView(
            title: "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.",
            subtitle: "SubtitleListView",
            lineLimit: 3,
            titleSubtitleListViewStyle: .title,
            schemeProvider: schemeProvider
        ).padding()
        return view
    }
    
}

private extension SubtitleTitleListViewSnapshotTests {
    
    func checkSubtitleTitleListView<T: View>(view: T, named: String, testName: String, disabled: Bool = false) {
        let subtitleTitleListViewWrapper = SubtitleTitleListViewWrapper(view: view)
        let view = UIHostingController(rootView: subtitleTitleListViewWrapper)
        let result = verifySnapshot(
            matching: view,
            as: .image,
            named: named,
            file: getFilePath(),
            testName: testName)
        XCTAssertNil(result)
    }
    
}
