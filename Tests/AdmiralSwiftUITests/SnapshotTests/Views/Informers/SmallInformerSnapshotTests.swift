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
import AdmiralUIResources
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
        SwiftUIThemeManager.shared.theme = .default
        let view = createSmallInformer(style: .default, arrowDirection: .top)
        checkSmallInformer(view: view, named: "DefaultTop.DefaultTheme", testName: "SmallInformer")
    }
    
    func testSmallInformerDefaultBottomDefaultTheme() {
        SwiftUIThemeManager.shared.theme = .default
        let view = createSmallInformer(style: .default, arrowDirection: .bottom)
        checkSmallInformer(view: view, named: "DefaultBottom.DefaultTheme", testName: "SmallInformer")
    }
    
    func testSmallInformerAttentionTopDefaultTheme() {
        SwiftUIThemeManager.shared.theme = .default
        let view = createSmallInformer(style: .attention, arrowDirection: .top)
        checkSmallInformer(view: view, named: "AttentionTop.DefaultTheme", testName: "SmallInformer")
    }
    
    func testSmallInformerAttentionBottomDefaultTheme() {
        SwiftUIThemeManager.shared.theme = .default
        let view = createSmallInformer(style: .attention, arrowDirection: .bottom)
        checkSmallInformer(view: view, named: "AttentionBottom.DefaultTheme", testName: "SmallInformer")
    }
    
    func testSmallInformerSuccessTopDefaultTheme() {
        SwiftUIThemeManager.shared.theme = .default
        let view = createSmallInformer(style: .success, arrowDirection: .top)
        checkSmallInformer(view: view, named: "SuccessTop.DefaultTheme", testName: "SmallInformer")
    }
    
    func testSmallInformerSuccessBottomDefaultTheme() {
        SwiftUIThemeManager.shared.theme = .default
        let view = createSmallInformer(style: .success, arrowDirection: .bottom)
        checkSmallInformer(view: view, named: "SuccessBottom.DefaultTheme", testName: "SmallInformer")
    }
    
    func testSmallInformerErrorTopDefaultTheme() {
        SwiftUIThemeManager.shared.theme = .default
        let view = createSmallInformer(style: .error, arrowDirection: .top)
        checkSmallInformer(view: view, named: "ErrorTop.DefaultTheme", testName: "SmallInformer")
    }
    
    func testSmallInformerErrorBottomDefaultTheme() {
        SwiftUIThemeManager.shared.theme = .default
        let view = createSmallInformer(style: .error, arrowDirection: .bottom)
        checkSmallInformer(view: view, named: "ErrorBottom.DefaultTheme", testName: "SmallInformer")
    }
    
    // MARK: Dark Theme
    
    func testSmallInformerDefaultTopDarkTheme() {
        SwiftUIThemeManager.shared.theme = .dark
        let view = createSmallInformer(style: .default, arrowDirection: .top)
        checkSmallInformer(view: view, named: "DefaultTop.DarkTheme", testName: "SmallInformer")
    }
    
    func testSmallInformerDefaultBottomDarkTheme() {
        SwiftUIThemeManager.shared.theme = .dark
        let view = createSmallInformer(style: .default, arrowDirection: .bottom)
        checkSmallInformer(view: view, named: "DefaultBottom.DarkTheme", testName: "SmallInformer")
    }
    
    func testSmallInformerAttentionTopDarkTheme() {
        SwiftUIThemeManager.shared.theme = .dark
        let view = createSmallInformer(style: .attention, arrowDirection: .top)
        checkSmallInformer(view: view, named: "AttentionTop.DarkTheme", testName: "SmallInformer")
    }
    
    func testSmallInformerAttentionBottomDarkTheme() {
        SwiftUIThemeManager.shared.theme = .dark
        let view = createSmallInformer(style: .attention, arrowDirection: .bottom)
        checkSmallInformer(view: view, named: "AttentionBottom.DarkTheme", testName: "SmallInformer")
    }
    
    func testSmallInformerSuccessTopDarkTheme() {
        SwiftUIThemeManager.shared.theme = .dark
        let view = createSmallInformer(style: .success, arrowDirection: .top)
        checkSmallInformer(view: view, named: "SuccessTop.DarkTheme", testName: "SmallInformer")
    }
    
    func testSmallInformerSuccessBottomDarkTheme() {
        SwiftUIThemeManager.shared.theme = .dark
        let view = createSmallInformer(style: .success, arrowDirection: .bottom)
        checkSmallInformer(view: view, named: "SuccessBottom.DarkTheme", testName: "SmallInformer")
    }
    
    func testSmallInformerErrorTopDarkTheme() {
        SwiftUIThemeManager.shared.theme = .dark
        let view = createSmallInformer(style: .error, arrowDirection: .top)
        checkSmallInformer(view: view, named: "ErrorTop.DarkTheme", testName: "SmallInformer")
    }
    
    func testSmallInformerErrorBottomDarkTheme() {
        SwiftUIThemeManager.shared.theme = .dark
        let view = createSmallInformer(style: .error, arrowDirection: .bottom)
        checkSmallInformer(view: view, named: "ErrorBottom.DarkTheme", testName: "SmallInformer")
    }
    
    func createSmallInformer(style: InformerStyleSwiftUI, arrowDirection: SmallInformerArrowDirection) -> some View {
        let view = SmallInformer(
            title: "SmallInformer",
            informerStyle: style,
            arrowDirection: arrowDirection,
            arrowOffset: 20)
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
