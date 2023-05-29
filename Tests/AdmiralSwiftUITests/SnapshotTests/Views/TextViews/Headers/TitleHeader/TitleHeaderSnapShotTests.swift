//
//  TitleHeaderSnapShotTests.swift
//  AdmiralSwiftUITests
//
//  Created on 12.11.2021.
//

import XCTest
import SwiftUI
import SnapshotTesting
import AdmiralTheme
@testable import AdmiralSwiftUI

private struct TitleHeaderWrapper<T: View>: View {
    
    // MARK: - Properties
    let view: T
    
    // MARK: - Layout
    var body: some View {
        view
            .frame(width: 160, height: 80)
    }
    
}

final class TitleHeaderSnapshotTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        Appearance.prepare()
    }
    
    // MARK: Default Theme
    
    func testTitleSubtitleHeaderTitleStyleDefaultTheme() {
        Appearance.shared.theme = .default
        let view = createTitleHeader(style: .title)
        checkTitleHeader(view: view, named: "TitleStyle.DefaultTheme", testName: "TitleHeader")
    }
    
    func testTitleSubtitleHeaderBodyStyleDefaultTheme() {
        Appearance.shared.theme = .default
        let view = createTitleHeader(style: .body)
        checkTitleHeader(view: view, named: "BodyStyle.DefaultTheme", testName: "TitleHeader")
    }
    
    func testTitleSubtitleHeaderHeadlineStyleDefaultTheme() {
        Appearance.shared.theme = .default
        let view = createTitleHeader(style: .headline)
        checkTitleHeader(view: view, named: "Headline.DefaultTheme", testName: "TitleHeader")
    }
    
    func testTitleSubtitleHeaderHeadlineSecondaryStyleDefaultTheme() {
        Appearance.shared.theme = .default
        let view = createTitleHeader(style: .headlineSecondary)
        checkTitleHeader(view: view, named: "HeadlineSecondary.DefaultTheme", testName: "TitleHeader")
    }
    
    // MARK: Dark Theme
    
    func testTitleSubtitleHeaderTitleStyleDarkTheme() {
        Appearance.shared.theme = .dark
        let view = createTitleHeader(style: .title)
        checkTitleHeader(view: view, named: "TitleStyle.DarkTheme", testName: "TitleHeader")
    }
    
    func testTitleSubtitleHeaderBodyStyleDarkTheme() {
        Appearance.shared.theme = .dark
        let view = createTitleHeader(style: .body)
        checkTitleHeader(view: view, named: "BodyStyle.DarkTheme", testName: "TitleHeader")
    }
    
    func testTitleSubtitleHeaderHeadlineStyleDarkTheme() {
        Appearance.shared.theme = .dark
        let view = createTitleHeader(style: .headline)
        checkTitleHeader(view: view, named: "Headline.DarkTheme", testName: "TitleHeader")
    }
    
    func testTitleSubtitleHeaderHeadlineSecondaryStyleDarkTheme() {
        Appearance.shared.theme = .dark
        let view = createTitleHeader(style: .headlineSecondary)
        checkTitleHeader(view: view, named: "HeadlineSecondary.DarkTheme", testName: "TitleHeader")
    }
    
    func createTitleHeader(style: HeaderStyle) -> some View {
        let view = TitleHeader(title: "TitleHeader", headerStyle: style)
        return view
    }
    
}

private extension TitleHeaderSnapshotTests {
    
    func checkTitleHeader<T: View>(view: T, named: String, testName: String, disabled: Bool = false) {
        let titleHeaderWrapper = TitleHeaderWrapper(view: view)
        let view = UIHostingController(rootView: titleHeaderWrapper)
        let result = verifySnapshot(
            matching: view,
            as: .image,
            named: named,
            file: getFilePath(),
            testName: testName)
        XCTAssertNil(result)
    }
    
}
