//
//  SubtitleTitleHeaderSnapshotTests.swift
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

private struct SubtitleTitleHeaderWrapper<T: View>: View {
    
    // MARK: - Properties
    let view: T
    
    // MARK: - Layout
    var body: some View {
        view
            .frame(width: 180, height: 80)
    }
    
}

final class SubtitleTitleHeaderSnapshotTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        Appearance.prepare()
    }
    
    // MARK: Default Theme
    
    func testSubtitleTitleHeaderTitleStyleDefaultTheme() {
        Appearance.shared.theme = .default
        let view = createSubtitleTitleHeader(style: .title)
        checkSubtitleTitleHeader(view: view, named: "TitleStyle.DefaultTheme", testName: "SubtitleTitleHeader")
    }
    
    func testSubtitleTitleHeaderBodyStyleDefaultTheme() {
        Appearance.shared.theme = .default
        let view = createSubtitleTitleHeader(style: .body)
        checkSubtitleTitleHeader(view: view, named: "BodyStyle.DefaultTheme", testName: "SubtitleTitleHeader")
    }
    
    func testSubtitleTitleHeaderHeadlineStyleDefaultTheme() {
        Appearance.shared.theme = .default
        let view = createSubtitleTitleHeader(style: .headline)
        checkSubtitleTitleHeader(view: view, named: "Headline.DefaultTheme", testName: "SubtitleTitleHeader")
    }
    
    func testSubtitleTitleHeaderHeadlineSecondaryStyleDefaultTheme() {
        Appearance.shared.theme = .default
        let view = createSubtitleTitleHeader(style: .headlineSecondary)
        checkSubtitleTitleHeader(view: view, named: "HeadlineSecondary.DefaultTheme", testName: "SubtitleTitleHeader")
    }
    
    // MARK: Dark Theme
    
    func testSubtitleTitleHeaderTitleStyleDarkTheme() {
        Appearance.shared.theme = .default
        let view = createSubtitleTitleHeader(style: .title)
        checkSubtitleTitleHeader(view: view, named: "TitleStyle.DarkTheme", testName: "SubtitleTitleHeader")
    }
    
    func testSubtitleTitleHeaderBodyStyleDarkTheme() {
        Appearance.shared.theme = .default
        let view = createSubtitleTitleHeader(style: .body)
        checkSubtitleTitleHeader(view: view, named: "BodyStyle.DarkTheme", testName: "SubtitleTitleHeader")
    }
    
    func testSubtitleTitleHeaderHeadlineStyleDarkTheme() {
        Appearance.shared.theme = .default
        let view = createSubtitleTitleHeader(style: .headline)
        checkSubtitleTitleHeader(view: view, named: "Headline.DarkTheme", testName: "SubtitleTitleHeader")
    }
    
    func testSubtitleTitleHeaderHeadlineSecondaryStyleDarkTheme() {
        Appearance.shared.theme = .default
        let view = createSubtitleTitleHeader(style: .headlineSecondary)
        checkSubtitleTitleHeader(view: view, named: "HeadlineSecondary.DarkTheme", testName: "SubtitleTitleHeader")
    }
    
    func createSubtitleTitleHeader(style: HeaderStyle) -> some View {
        let view = SubtitleTitleHeader(title: "TitleHeader", subtitle: "SubtitleTitleHeader", headerStyle: style)
        return view
    }
    
}

private extension SubtitleTitleHeaderSnapshotTests {
    
    func checkSubtitleTitleHeader<T: View>(view: T, named: String, testName: String, disabled: Bool = false) {
        let subtitleTitleHeaderWrapper = SubtitleTitleHeaderWrapper(view: view)
        let view = UIHostingController(rootView: subtitleTitleHeaderWrapper)
        let result = verifySnapshot(
            matching: view,
            as: .image,
            named: named,
            file: getFilePath(),
            testName: testName)
        XCTAssertNil(result)
    }
    
}
