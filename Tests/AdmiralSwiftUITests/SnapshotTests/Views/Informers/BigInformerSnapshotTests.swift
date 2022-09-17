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
        Appearance.shared.theme = .default
        let view = createBigInformer(style: .default)
        checkBigInformer(view: view, named: "Default.DefaultTheme", testName: "BigInformer")
    }
    
    func testBigInformerSuccessStateDefaultTheme() {
        Appearance.shared.theme = .default
        let view = createBigInformer(style: .success)
        checkBigInformer(view: view, named: "Success.DefaultTheme", testName: "BigInformer")
    }
    
    func testBigInformerAttentionStateDefaultTheme() {
        Appearance.shared.theme = .default
        let view = createBigInformer(style: .attention)
        checkBigInformer(view: view, named: "Attention.DefaultTheme", testName: "BigInformer")
    }
    
    func testBigInformerErrorStateDefaultTheme() {
        Appearance.shared.theme = .default
        let view = createBigInformer(style: .error)
        checkBigInformer(view: view, named: "Error.DefaultTheme", testName: "BigInformer")
    }
    
    // MARK: Dark Theme
    
    func testBigInformerDefaultStateDarkTheme() {
        Appearance.shared.theme = .dark
        let view = createBigInformer(style: .default)
        checkBigInformer(view: view, named: "Default.DarkTheme", testName: "BigInformer")
    }
    
    func testBigInformerSuccessStateDarkTheme() {
        Appearance.shared.theme = .dark
        let view = createBigInformer(style: .success)
        checkBigInformer(view: view, named: "Success.DarkTheme", testName: "BigInformer")
    }
    
    func testBigInformerAttentionStateDarkTheme() {
        Appearance.shared.theme = .dark
        let view = createBigInformer(style: .attention)
        checkBigInformer(view: view, named: "Attention.DarkTheme", testName: "BigInformer")
    }
    
    func testBigInformerErrorStateDarkTheme() {
        Appearance.shared.theme = .dark
        let view = createBigInformer(style: .error)
        checkBigInformer(view: view, named: "Error.DarkTheme", testName: "BigInformer")
    }

    // MARK: - Scheme Providers

    func testSchemeProvider() {
        Appearance.shared.theme = .default
        var scheme = BigInformerScheme(theme: .default)
        scheme.backgroundColors.set(parameter: AColor(color: .systemPink), isEnabled: true, style: .default)
        scheme.wrapViewBackgroundColors.set(parameter: AColor(color: .systemPink), isEnabled: true, style: .default)
        let newSchemeProvider = SchemeProvider<BigInformerScheme>(scheme: scheme)

        let view = createBigInformer(schemeProvider: newSchemeProvider)
        checkBigInformer(view: view, named: "SchemeProvider", testName: "BigInformer")

        Appearance.shared.theme = .dark
        let newView = createBigInformer(schemeProvider: newSchemeProvider)
        checkBigInformer(view: newView, named: "SchemeProvider", testName: "BigInformer")
    }
    
    func createBigInformer(style: InformerStyleSwiftUI) -> some View {
        let bigInformerView = BigInformer(
            title: "BigInformer",
            subtitle: "BigInformer Check",
            informerStyle: style,
            onDetail: {})
        return bigInformerView
    }

    func createBigInformer(schemeProvider: SchemeProvider<BigInformerScheme>) -> some View {
        let bigInformerView = BigInformer(
            title: "BigInformer",
            subtitle: "BigInformer Check",
            informerStyle: .default,
            schemeProvider: schemeProvider,
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
