//
//  NumberBadgeViewSnapshotTests.swift
//  AdmiralSwiftUITests
//
//  Created on 11.11.2021.
//

import XCTest
import SwiftUI
import SnapshotTesting
import AdmiralTheme
import AdmiralUIResources
@testable import AdmiralSwiftUI

private struct BadgeViewWrapper<T: View>: View {

    // MARK: - Properties
    let view: T

    // MARK: - Layout
    var body: some View {
        view
            .frame(width: 45, height: 45)
    }

}

final class BadgeViewSnapshotTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        Appearance.prepare()
    }
    
    // MARK: Default Theme
    
    func testBadgeViewDefaultStyleDefaultTheme() {
        SwiftUIThemeManager.shared.theme = .default
        let view = createBadgeView(style: .default)
        checkNumberBadgeView(view: view, named: "DefaultStyle.DefaultTheme", testName: "BadgeView")
    }
    
    func testBadgeViewNaturalStyleDefaultTheme() {
        SwiftUIThemeManager.shared.theme = .default
        let view = createBadgeView(style: .natural)
        checkNumberBadgeView(view: view, named: "NaturalStyle.DefaultTheme", testName: "BadgeView")
    }
    
    func testBadgeViewAttentionStyleDefaultTheme() {
        SwiftUIThemeManager.shared.theme = .default
        let view = createBadgeView(style: .attention)
        checkNumberBadgeView(view: view, named: "AttentionStyle.DefaultTheme", testName: "BadgeView")
    }
    
    func testBadgeViewSuccessStyleDefaultTheme() {
        SwiftUIThemeManager.shared.theme = .default
        let view = createBadgeView(style: .success)
        checkNumberBadgeView(view: view, named: "SuccessStyle.DefaultTheme", testName: "BadgeView")
    }
    
    func testBadgeViewErrorStyleDefaultTheme() {
        SwiftUIThemeManager.shared.theme = .default
        let view = createBadgeView(style: .error)
        checkNumberBadgeView(view: view, named: "ErrorStyle.DefaultTheme", testName: "BadgeView")
    }
    
    func testBadgeViewAdditionalStyleDefaultTheme() {
        SwiftUIThemeManager.shared.theme = .default
        let view = createBadgeView(style: .additional)
        checkNumberBadgeView(view: view, named: "AdditionalStyle.DefaultTheme", testName: "BadgeView")
    }
    
    // MARK: Dark Theme
    
    func testBadgeViewDefaultStyleDarkTheme() {
        SwiftUIThemeManager.shared.theme = .dark
        let view = createBadgeView(style: .default)
        checkNumberBadgeView(view: view, named: "DefaultStyle.DarkTheme", testName: "BadgeView")
    }
    
    func testBadgeViewNaturalStyleDarkTheme() {
        SwiftUIThemeManager.shared.theme = .dark
        let view = createBadgeView(style: .natural)
        checkNumberBadgeView(view: view, named: "NaturalStyle.DarkTheme", testName: "BadgeView")
    }
    
    func testBadgeViewAttentionStyleDarkTheme() {
        SwiftUIThemeManager.shared.theme = .dark
        let view = createBadgeView(style: .attention)
        checkNumberBadgeView(view: view, named: "AttentionStyle.DarkTheme", testName: "BadgeView")
    }
    
    func testBadgeViewSuccessStyleDarkTheme() {
        SwiftUIThemeManager.shared.theme = .dark
        let view = createBadgeView(style: .success)
        checkNumberBadgeView(view: view, named: "SuccessStyle.DarkTheme", testName: "BadgeView")
    }
    
    func testBadgeViewErrorStyleDarkTheme() {
        SwiftUIThemeManager.shared.theme = .dark
        let view = createBadgeView(style: .error)
        checkNumberBadgeView(view: view, named: "ErrorStyle.DarkTheme", testName: "BadgeView")
    }
    
    func testBadgeViewAdditionalStyleDarkTheme() {
        SwiftUIThemeManager.shared.theme = .dark
        let view = createBadgeView(style: .additional)
        checkNumberBadgeView(view: view, named: "AdditionalStyle.DarkTheme", testName: "BadgeView")
    }
    
    func createBadgeView(style: BadgeStyle) -> some View {
        let numberBadgeView = BadgeView(badgeStyle: style,
                                        value: 10,
                                        content: {})
        return numberBadgeView
    }
    
}

private extension BadgeViewSnapshotTests {

    func checkNumberBadgeView<T: View>(view: T, named: String, testName: String, disabled: Bool = false) {
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
