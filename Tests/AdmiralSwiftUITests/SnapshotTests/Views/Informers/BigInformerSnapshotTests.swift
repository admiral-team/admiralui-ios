//
//  BigInformerSnapshotTests.swift
//  AdmiralSwiftUITests
//
//  Created on 10.11.2021.
//

import XCTest
import SwiftUI
import SnapshotTesting
import AdmiralTheme
import AdmiralUIResources
@testable import AdmiralSwiftUI

private struct BigInformerWrapper<T: View>: View {

    // MARK: - Properties
    let view: T

    // MARK: - Layout
    var body: some View {
        view
            .frame(width: 400, height: 100)
    }

}

final class BigInformerSnapshotTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        Appearance.prepare()
    }
    
    // MARK: Default Theme
    
    func testBigInformerDefaultStateDefaultTheme() {
        SwiftUIThemeManager.shared.theme = .default
        let view = createBigInformer(style: .default)
        checkBigInformer(view: view, named: "Default.DefaultTheme", testName: "BigInformer")
    }
    
    func testBigInformerSuccessStateDefaultTheme() {
        SwiftUIThemeManager.shared.theme = .default
        let view = createBigInformer(style: .success)
        checkBigInformer(view: view, named: "Success.DefaultTheme", testName: "BigInformer")
    }
    
    func testBigInformerAttentionStateDefaultTheme() {
        SwiftUIThemeManager.shared.theme = .default
        let view = createBigInformer(style: .attention)
        checkBigInformer(view: view, named: "Attention.DefaultTheme", testName: "BigInformer")
    }
    
    func testBigInformerErrorStateDefaultTheme() {
        SwiftUIThemeManager.shared.theme = .default
        let view = createBigInformer(style: .error)
        checkBigInformer(view: view, named: "Error.DefaultTheme", testName: "BigInformer")
    }
    
    // MARK: Dark Theme
    
    func testBigInformerDefaultStateDarkTheme() {
        SwiftUIThemeManager.shared.theme = .dark
        let view = createBigInformer(style: .default)
        checkBigInformer(view: view, named: "Default.DarkTheme", testName: "BigInformer")
    }
    
    func testBigInformerSuccessStateDarkTheme() {
        SwiftUIThemeManager.shared.theme = .dark
        let view = createBigInformer(style: .success)
        checkBigInformer(view: view, named: "Success.DarkTheme", testName: "BigInformer")
    }
    
    func testBigInformerAttentionStateDarkTheme() {
        SwiftUIThemeManager.shared.theme = .dark
        let view = createBigInformer(style: .attention)
        checkBigInformer(view: view, named: "Attention.DarkTheme", testName: "BigInformer")
    }
    
    func testBigInformerErrorStateDarkTheme() {
        SwiftUIThemeManager.shared.theme = .dark
        let view = createBigInformer(style: .error)
        checkBigInformer(view: view, named: "Error.DarkTheme", testName: "BigInformer")
    }
    
    func createBigInformer(style: InformerStyleSwiftUI) -> some View {
        let bigInformerView = BigInformer(
            title: "BigInformer",
            subtitle: "BigInformer Check",
            informerStyle: style,
            onDetail: {})
        return bigInformerView
    }
    
}

private extension BigInformerSnapshotTests {

    func checkBigInformer<T: View>(view: T, named: String, testName: String, disabled: Bool = false) {
        let bigInformerWrapper = BigInformerWrapper(view: view)
        let view = UIHostingController(rootView: bigInformerWrapper)
        let result = verifySnapshot(
            matching: view,
            as: .image,
            named: named,
            file: getFilePath(),
            testName: testName)
        XCTAssertNil(result)
    }

}
