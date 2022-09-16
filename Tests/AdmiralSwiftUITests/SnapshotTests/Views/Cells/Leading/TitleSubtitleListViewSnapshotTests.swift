//
//  TitleSubtitleListViewSnapshotTests.swift
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

private struct TitleSubtitleListViewWrapper<T: View>: View {
    
    // MARK: - Properties
    let view: T
    
    // MARK: - Layout
    var body: some View {
        view
            .frame(width: 500, height: 300)
    }
    
}

final class TitleSubtitleListViewSnapshotTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        Appearance.prepare()
    }
    
    // MARK: Default Theme
    
    func testTitleSubtitleListViewHeadlineSecondaryDefaultTheme() {
        Appearance.shared.theme = .default
        let view = createTitleSubtitleListView(style: .headlineSecondary)
        checkTitleSubtitleListView(view: view, named: "HeadlineSecondaryDefaultTheme", testName: "TitleSubtitleListView")
    }
    
    func testTitleSubtitleListViewBodyDefaultTheme() {
        Appearance.shared.theme = .default
        let view = createTitleSubtitleListView(style: .body)
        checkTitleSubtitleListView(view: view, named: "BodyDefaultTheme", testName: "TitleSubtitleListView")
    }
    
    func testTitleSubtitleListViewHeadlineDefaultTheme() {
        Appearance.shared.theme = .default
        let view = createTitleSubtitleListView(style: .headline)
        checkTitleSubtitleListView(view: view, named: "HeadlineDefaultTheme", testName: "TitleSubtitleListView")
    }
    
    // MARK: Dark Theme
    
    func testTitleSubtitleListViewHeadlineSecondaryDarkTheme() {
        Appearance.shared.theme = .dark
        let view = createTitleSubtitleListView(style: .headlineSecondary)
        checkTitleSubtitleListView(view: view, named: "HeadlineSecondaryDarkTheme", testName: "TitleSubtitleListView")
    }
    
    func testTitleSubtitleListViewBodyDarkTheme() {
        Appearance.shared.theme = .dark
        let view = createTitleSubtitleListView(style: .body)
        checkTitleSubtitleListView(view: view, named: "BodyDarkTheme", testName: "TitleSubtitleListView")
    }
    
    func testTitleSubtitleListViewHeadlineDarkTheme() {
        Appearance.shared.theme = .dark
        let view = createTitleSubtitleListView(style: .headline)
        checkTitleSubtitleListView(view: view, named: "HeadlineDarkTheme", testName: "TitleSubtitleListView")
    }

    // MARK: - Scheme Provider

    func testSchemeProvider() {
        Appearance.shared.theme = .default
        var scheme = TitleSubTitleSubtitleListViewScheme(theme: .default)
        scheme.titleColor.set(parameter: AColor(color: .systemPink), for: .normal)
        scheme.subtitleColor.set(parameter: AColor(color: .systemPink), for: .normal)
        let newSchemeProvider = SchemeProvider<TitleSubTitleSubtitleListViewScheme>(scheme: scheme)

        let view = createTitleSubtitleListView(schemeProvider: newSchemeProvider)
        checkTitleSubtitleListView(view: view, named: "SchemeProvider", testName: "TitleSubtitleListView")

        Appearance.shared.theme = .dark
        let newView = createTitleSubtitleListView(schemeProvider: newSchemeProvider)
        checkTitleSubtitleListView(view: newView, named: "SchemeProvider", testName: "TitleSubtitleListView")
    }
    
    func createTitleSubtitleListView(style: TitleSubtitleListViewStyle) -> some View {
        let view = TitleSubtitleListView(
            title: "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.",
            subtitle: "SubtitleListView",
            lineLimit: 3,
            titleSubtitleListViewStyle: style)
            .padding()
        return view
    }

    func createTitleSubtitleListView(schemeProvider: SchemeProvider<TitleSubTitleSubtitleListViewScheme>) -> some View {
        let view = TitleSubtitleListView(
            title: "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.",
            subtitle: "SubtitleListView",
            lineLimit: 3,
            titleSubtitleListViewStyle: .title,
            schemeProvider: schemeProvider
        )
            .padding()
        return view
    }
    
}

private extension TitleSubtitleListViewSnapshotTests {
    
    func checkTitleSubtitleListView<T: View>(view: T, named: String, testName: String, disabled: Bool = false) {
        let titleSubtitleListViewWrapper = TitleSubtitleListViewWrapper(view: view)
        let view = UIHostingController(rootView: titleSubtitleListViewWrapper)
        let result = verifySnapshot(
            matching: view,
            as: .image,
            named: named,
            file: getFilePath(),
            testName: testName)
        XCTAssertNil(result)
    }
    
}
