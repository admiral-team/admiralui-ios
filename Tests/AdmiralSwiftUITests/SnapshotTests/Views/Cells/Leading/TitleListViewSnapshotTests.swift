//
//  TitleListViewSnapshotTests.swift
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

private struct TitleListViewWrapper<T: View>: View {
    
    // MARK: - Properties
    let view: T
    
    // MARK: - Layout
    var body: some View {
        view
            .frame(width: 500, height: 200)
    }
    
}

final class TitleListViewSnapshotTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        Appearance.prepare()
    }
    
    // MARK: Default Theme
    
    func testTitleListViewHeadlineSecondaryDefaultTheme() {
        SwiftUIThemeManager.shared.theme = .default
        let view = createTitleListView(style: .headlineSecondary)
        checkTitleListView(view: view, named: "HeadlineSecondaryDefaultTheme", testName: "TitleListView")
    }
    
    func testTitleListViewParagraphDefaultTheme() {
        SwiftUIThemeManager.shared.theme = .default
        let view = createTitleListView(style: .paragraph)
        checkTitleListView(view: view, named: "ParagraphDefaultTheme", testName: "TitleListView")
    }
    
    func testTitleListViewHeadlineDefaultTheme() {
        SwiftUIThemeManager.shared.theme = .default
        let view = createTitleListView(style: .headline)
        checkTitleListView(view: view, named: "HeadlineDefaultTheme", testName: "TitleListView")
    }
    
    func testTitleListViewBodyDefaultTheme() {
        SwiftUIThemeManager.shared.theme = .default
        let view = createTitleListView(style: .body)
        checkTitleListView(view: view, named: "BodyDefaultTheme", testName: "TitleListView")
    }
    
    // MARK: Dark Theme
    
    func testTitleListViewHeadlineSecondaryDarkTheme() {
        SwiftUIThemeManager.shared.theme = .dark
        let view = createTitleListView(style: .headlineSecondary)
        checkTitleListView(view: view, named: "HeadlineSecondaryDarkTheme", testName: "TitleListView")
    }
    
    func testTitleListViewParagraphDarkTheme() {
        SwiftUIThemeManager.shared.theme = .dark
        let view = createTitleListView(style: .paragraph)
        checkTitleListView(view: view, named: "ParagraphDarkTheme", testName: "TitleListView")
    }
    
    func testTitleListViewHeadlineDarkTheme() {
        SwiftUIThemeManager.shared.theme = .dark
        let view = createTitleListView(style: .headline)
        checkTitleListView(view: view, named: "HeadlineDarkTheme", testName: "TitleListView")
    }
    
    func testTitleListViewBodyDarkTheme() {
        SwiftUIThemeManager.shared.theme = .dark
        let view = createTitleListView(style: .body)
        checkTitleListView(view: view, named: "BodyDarkTheme", testName: "TitleListView")
    }
    
    func createTitleListView(style: TitleListViewStyle) -> some View {
        let view = TitleListView(
            title: "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.",
            textAligment: .center,
            lineLimit: 3,
            titleListViewStyle: style
        ).padding()
        return view
    }
    
}

private extension TitleListViewSnapshotTests {

    func checkTitleListView<T: View>(view: T, named: String, testName: String, disabled: Bool = false) {
        let titleListViewWrapper = TitleListViewWrapper(view: view)
        let view = UIHostingController(rootView: titleListViewWrapper)
        let result = verifySnapshot(
            matching: view,
            as: .image,
            named: named,
            file: getFilePath(),
            testName: testName)
        XCTAssertNil(result)
    }
    
}
