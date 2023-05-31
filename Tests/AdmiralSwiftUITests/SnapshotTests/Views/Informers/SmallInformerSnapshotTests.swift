//
//  SmallInformerSnapshotTests.swift
//  AdmiralSwiftUITests
//
//  Created on 16.11.2021.
//

import XCTest
import SwiftUI
import SnapshotTesting
import AdmiralTheme
@testable import AdmiralSwiftUI

private struct SmallInformerWrapper<T: View>: View {
    
    // MARK: - Properties
    let view: T
    
    // MARK: - Layout
    var body: some View {
        view
            .frame(width: 300, height: 100)
    }
    
}

final class SmallInformerSnapshotTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        Appearance.prepare()
    }
    
    // MARK: Default Theme
    
    func testSmallInformerDefaultTopDefaultTheme() {
        Appearance.shared.theme = .default
        let view = createSmallInformer(style: .default, arrowDirection: .top)
        checkSmallInformer(view: view, named: "DefaultTop.DefaultTheme", testName: "SmallInformer")
    }
    
    func testSmallInformerDefaultBottomDefaultTheme() {
        Appearance.shared.theme = .default
        let view = createSmallInformer(style: .default, arrowDirection: .bottom)
        checkSmallInformer(view: view, named: "DefaultBottom.DefaultTheme", testName: "SmallInformer")
    }
    
    func testSmallInformerAttentionTopDefaultTheme() {
        Appearance.shared.theme = .default
        let view = createSmallInformer(style: .attention, arrowDirection: .top)
        checkSmallInformer(view: view, named: "AttentionTop.DefaultTheme", testName: "SmallInformer")
    }
    
    func testSmallInformerAttentionBottomDefaultTheme() {
        Appearance.shared.theme = .default
        let view = createSmallInformer(style: .attention, arrowDirection: .bottom)
        checkSmallInformer(view: view, named: "AttentionBottom.DefaultTheme", testName: "SmallInformer")
    }
    
    func testSmallInformerSuccessTopDefaultTheme() {
        Appearance.shared.theme = .default
        let view = createSmallInformer(style: .success, arrowDirection: .top)
        checkSmallInformer(view: view, named: "SuccessTop.DefaultTheme", testName: "SmallInformer")
    }
    
    func testSmallInformerSuccessBottomDefaultTheme() {
        Appearance.shared.theme = .default
        let view = createSmallInformer(style: .success, arrowDirection: .bottom)
        checkSmallInformer(view: view, named: "SuccessBottom.DefaultTheme", testName: "SmallInformer")
    }
    
    func testSmallInformerErrorTopDefaultTheme() {
        Appearance.shared.theme = .default
        let view = createSmallInformer(style: .error, arrowDirection: .top)
        checkSmallInformer(view: view, named: "ErrorTop.DefaultTheme", testName: "SmallInformer")
    }
    
    func testSmallInformerErrorBottomDefaultTheme() {
        Appearance.shared.theme = .default
        let view = createSmallInformer(style: .error, arrowDirection: .bottom)
        checkSmallInformer(view: view, named: "ErrorBottom.DefaultTheme", testName: "SmallInformer")
    }
    
    // MARK: Dark Theme
    
    func testSmallInformerDefaultTopDarkTheme() {
        Appearance.shared.theme = .dark
        let view = createSmallInformer(style: .default, arrowDirection: .top)
        checkSmallInformer(view: view, named: "DefaultTop.DarkTheme", testName: "SmallInformer")
    }
    
    func testSmallInformerDefaultBottomDarkTheme() {
        Appearance.shared.theme = .dark
        let view = createSmallInformer(style: .default, arrowDirection: .bottom)
        checkSmallInformer(view: view, named: "DefaultBottom.DarkTheme", testName: "SmallInformer")
    }
    
    func testSmallInformerAttentionTopDarkTheme() {
        Appearance.shared.theme = .dark
        let view = createSmallInformer(style: .attention, arrowDirection: .top)
        checkSmallInformer(view: view, named: "AttentionTop.DarkTheme", testName: "SmallInformer")
    }
    
    func testSmallInformerAttentionBottomDarkTheme() {
        Appearance.shared.theme = .dark
        let view = createSmallInformer(style: .attention, arrowDirection: .bottom)
        checkSmallInformer(view: view, named: "AttentionBottom.DarkTheme", testName: "SmallInformer")
    }
    
    func testSmallInformerSuccessTopDarkTheme() {
        Appearance.shared.theme = .dark
        let view = createSmallInformer(style: .success, arrowDirection: .top)
        checkSmallInformer(view: view, named: "SuccessTop.DarkTheme", testName: "SmallInformer")
    }
    
    func testSmallInformerSuccessBottomDarkTheme() {
        Appearance.shared.theme = .dark
        let view = createSmallInformer(style: .success, arrowDirection: .bottom)
        checkSmallInformer(view: view, named: "SuccessBottom.DarkTheme", testName: "SmallInformer")
    }
    
    func testSmallInformerErrorTopDarkTheme() {
        Appearance.shared.theme = .dark
        let view = createSmallInformer(style: .error, arrowDirection: .top)
        checkSmallInformer(view: view, named: "ErrorTop.DarkTheme", testName: "SmallInformer")
    }
    
    func testSmallInformerErrorBottomDarkTheme() {
        Appearance.shared.theme = .dark
        let view = createSmallInformer(style: .error, arrowDirection: .bottom)
        checkSmallInformer(view: view, named: "ErrorBottom.DarkTheme", testName: "SmallInformer")
    }

    // MARK: - Scheme Providers

    func testSchemeProvider() {
        Appearance.shared.theme = .default
        var scheme = SmallInformerScheme(theme: .default)
        scheme.backgroundColors.set(parameter: AColor(color: .systemPink), isEnabled: true, style: .default)
        scheme.wrapViewBackgroundColors.set(parameter: AColor(color: .systemPink), isEnabled: true, style: .default)
        let newSchemeProvider = SchemeProvider<SmallInformerScheme>(scheme: scheme)

        let view = createSmallInformer(schemeProvider: newSchemeProvider)
        checkSmallInformer(view: view, named: "SchemeProvider", testName: "SmallInformer")

        Appearance.shared.theme = .dark
        let newView = createSmallInformer(schemeProvider: newSchemeProvider)
        checkSmallInformer(view: newView, named: "SchemeProvider", testName: "SmallInformer")
    }
    
    func createSmallInformer(style: InformerStyleSwiftUI, arrowDirection: SmallInformerArrowDirection) -> some View {
        let view = SmallInformer(
            title: "SmallInformer",
            informerStyle: style,
            arrowDirection: arrowDirection,
            arrowOffset: 20)
        return view
    }

    func createSmallInformer(schemeProvider: SchemeProvider<SmallInformerScheme>) -> some View {
        let view = SmallInformer(
            title: "SmallInformer",
            informerStyle: .default,
            arrowDirection: .top,
            arrowOffset: 20,
            schemeProvider: schemeProvider
        )
        return view
    }
    
}

private extension SmallInformerSnapshotTests {
    
    func checkSmallInformer<T: View>(view: T, named: String, testName: String, disabled: Bool = false) {
        let smallInformerWrapper = SmallInformerWrapper(view: view)
        let view = UIHostingController(rootView: smallInformerWrapper)
        let result = verifySnapshot(
            matching: view,
            as: .image,
            named: named,
            file: getFilePath(),
            testName: testName)
        XCTAssertNil(result)
    }
    
}
