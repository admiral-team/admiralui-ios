//
//  LinkViewSnapshotTests.swift
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

private struct LinkViewWrapper<T: View>: View {
    
    // MARK: - Properties
    let view: T
    
    // MARK: - Layout
    var body: some View {
        view
            .frame(width: 100, height: 40)
    }
    
}

final class LinkViewSnapshotTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        Appearance.prepare()
    }
    
    // MARK: Default Theme
    
    func testLinkViewDefaultTheme() {
        Appearance.shared.theme = .default
        let view = createLinkView()
        checkLinkView(view: view, named: "DefaultTheme", testName: "LinkView")
    }
    
    // MARK: Dark Theme
    
    func testLinkViewDarkTheme() {
        Appearance.shared.theme = .default
        let view = createLinkView()
        checkLinkView(view: view, named: "DarkTheme", testName: "LinkView")
    }

    // MARK: - Scheme Provider

    func testSchemeProvider() {
        Appearance.shared.theme = .default
        var scheme = LinkViewScheme(theme: .default)
        scheme.contentListViewScheme.buttonScheme.textColor.set(parameter: AColor(color: .systemPink), for: .normal)
        let newSchemeProvider = SchemeProvider<LinkViewScheme>(scheme: scheme)

        let customSwitch = createLinkView(schemeProvider: newSchemeProvider)
        checkLinkView(view: customSwitch, named: "SchemeProvider", testName: "LinkView")

        Appearance.shared.theme = .dark
        let newCustomSwitch = createLinkView(schemeProvider: newSchemeProvider)
        checkLinkView(view: newCustomSwitch, named: "SchemeProvider", testName: "LinkView")
    }
    
    func createLinkView() -> some View {
        let view = LinkView(buttonTitle: "Button", buttonAction: {})
        return view
    }

    func createLinkView(schemeProvider: SchemeProvider<LinkViewScheme>) -> some View {
        let view = LinkView(
            buttonTitle: "Button",
            schemeProvider: schemeProvider,
            buttonAction: {})
        return view
    }
    
}

private extension LinkViewSnapshotTests {
    
    func checkLinkView<T: View>(view: T, named: String, testName: String, disabled: Bool = false) {
        let linkViewWrapper = LinkViewWrapper(view: view)
        let view = UIHostingController(rootView: linkViewWrapper)
        let result = verifySnapshot(
            matching: view,
            as: .image,
            named: named,
            file: getFilePath(),
            testName: testName)
        XCTAssertNil(result)
    }
    
}
