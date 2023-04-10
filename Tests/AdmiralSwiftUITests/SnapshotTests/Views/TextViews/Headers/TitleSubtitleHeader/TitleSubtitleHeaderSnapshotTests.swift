//
//  TitleSubtitleHeaderSnapshotTests.swift
//  AdmiralSwiftUITests
//
//  Created on 12.11.2021.
//

import XCTest
import SwiftUI
import SnapshotTesting
import AdmiralCore
import AdmiralTheme
import AdmiralUIResources
@testable import AdmiralSwiftUI

private struct TitleSubtitleHeaderWrapper<T: View>: View {
    
    // MARK: - Properties
    let view: T
    
    // MARK: - Layout
    var body: some View {
        view
            .frame(width: 150, height: 80)
    }
    
}

final class TitleSubtitleHeaderSnapshotTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        Appearance.prepare()
    }
    
    // MARK: Default Theme
    
    func testTitleSubtitleHeaderTitleStyleDefaultTheme() {
        Appearance.shared.theme = .default
        let view = createTitleSubtitleHeader(style: .title)
        checkTitleSubtitleHeader(view: view, named: "TitleStyle.DefaultTheme", testName: "TitleSubtitleHeader")
    }
    
    func testTitleSubtitleHeaderBodyStyleDefaultTheme() {
        Appearance.shared.theme = .default
        let view = createTitleSubtitleHeader(style: .body)
        checkTitleSubtitleHeader(view: view, named: "BodyStyle.DefaultTheme", testName: "TitleSubtitleHeader")
    }
    
    func testTitleSubtitleHeaderHeadlineStyleDefaultTheme() {
        Appearance.shared.theme = .default
        let view = createTitleSubtitleHeader(style: .headline)
        checkTitleSubtitleHeader(view: view, named: "Headline.DefaultTheme", testName: "TitleSubtitleHeader")
    }
    
    func testTitleSubtitleHeaderHeadlineSecondaryStyleDefaultTheme() {
        Appearance.shared.theme = .default
        let view = createTitleSubtitleHeader(style: .headlineSecondary)
        checkTitleSubtitleHeader(view: view, named: "HeadlineSecondary.DefaultTheme", testName: "TitleSubtitleHeader")
    }
    
    // MARK: Dark Theme
    
    func testTitleSubtitleHeaderTitleStyleDarkTheme() {
        Appearance.shared.theme = .dark
        let view = createTitleSubtitleHeader(style: .title)
        checkTitleSubtitleHeader(view: view, named: "TitleStyle.DarkTheme", testName: "TitleSubtitleHeader")
    }
    
    func testTitleSubtitleHeaderBodyStyleDarkTheme() {
        Appearance.shared.theme = .dark
        let view = createTitleSubtitleHeader(style: .body)
        checkTitleSubtitleHeader(view: view, named: "BodyStyle.DarkTheme", testName: "TitleSubtitleHeader")
    }
    
    func testTitleSubtitleHeaderHeadlineStyleDarkTheme() {
        Appearance.shared.theme = .dark
        let view = createTitleSubtitleHeader(style: .headline)
        checkTitleSubtitleHeader(view: view, named: "Headline.DarkTheme", testName: "TitleSubtitleHeader")
    }
    
    func testTitleSubtitleHeaderHeadlineSecondaryStyleDarkTheme() {
        Appearance.shared.theme = .dark
        let view = createTitleSubtitleHeader(style: .headlineSecondary)
        checkTitleSubtitleHeader(view: view, named: "HeadlineSecondary.DarkTheme", testName: "TitleSubtitleHeader")
    }
    
    func createTitleSubtitleHeader(style: HeaderStyle) -> some View {
        let view = TitleSubtitleHeader(title: "TitleHeader", subtitle: "SubtitleHeader", headerStyle: style)
        return view
    }
    
}

private extension TitleSubtitleHeaderSnapshotTests {
    
    func checkTitleSubtitleHeader<T: View>(view: T, named: String, testName: String, disabled: Bool = false) {
        let titleSubtitleHeaderWrapper = TitleSubtitleHeaderWrapper(view: view)
        let view = UIHostingController(rootView: titleSubtitleHeaderWrapper)
        let result = verifySnapshot(
            matching: view,
            as: .image,
            named: named,
            file: getFilePath(),
            testName: testName)
        XCTAssertNil(result)
    }
    
}
