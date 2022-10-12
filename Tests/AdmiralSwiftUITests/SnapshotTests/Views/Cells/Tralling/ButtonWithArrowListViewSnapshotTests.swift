//
//  ButtonWithArrowListViewSnapshotTests.swift
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

private struct ButtonWithArrowListViewWrapper<T: View>: View {
    
    // MARK: - Properties
    let view: T
    
    // MARK: - Layout
    var body: some View {
        view
            .frame(width: 300, height: 50)
    }
    
}

final class ButtonWithArrowListViewSnapshotTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        Appearance.prepare()
    }
    
    // MARK: Default Theme
    
    func testButtonWithArrowListViewDefaultTheme() {
        Appearance.shared.theme = .default
        let view = createButtonWithArrowListView()
        checkButtonWithArrowListView(view: view, named: "DefaultTheme", testName: "ButtonWithArrowListView")
    }
    
    // MARK: Dark Theme
    
    func testButtonWithArrowListViewDarkTheme() {
        Appearance.shared.theme = .dark
        let view = createButtonWithArrowListView()
        checkButtonWithArrowListView(view: view, named: "DarkTheme", testName: "ButtonWithArrowListView")
    }

    // MARK: - Scheme Provider

    func testSchemeProvider() {
        Appearance.shared.theme = .default
        var scheme = ButtonWithArrowListViewScheme(theme: .default)
        scheme.button.textColor.set(parameter: AColor(color: .systemPink), for: .normal)
        scheme.button.imageColor.set(parameter: AColor(color: .systemPink), for: .normal)
        let newSchemeProvider = SchemeProvider<ButtonWithArrowListViewScheme>(scheme: scheme)

        let view = createButtonWithArrowListView(schemeProvider: newSchemeProvider)
        checkButtonWithArrowListView(view: view, named: "SchemeProvider", testName: "ButtonWithArrowListView")

        Appearance.shared.theme = .dark
        let newView = createButtonWithArrowListView(schemeProvider: newSchemeProvider)
        checkButtonWithArrowListView(view: newView, named: "SchemeProvider", testName: "ButtonWithArrowListView")
    }
    
    func createButtonWithArrowListView() -> some View {
        let view = ButtonWithArrowListView(
            text: "ButtonWithArrowListView",
            image: Image(uiImage: Asset.Finance.Solid.debitCardSolid.image),
            action: {})
        return view
    }

    func createButtonWithArrowListView(schemeProvider: SchemeProvider<ButtonWithArrowListViewScheme>) -> some View {
        let view = ButtonWithArrowListView(
            text: "ButtonWithArrowListView",
            image: Image(uiImage: Asset.Finance.Solid.debitCardSolid.image),
            schemeProvider: schemeProvider,
            action: {})
        return view
    }
    
}

private extension ButtonWithArrowListViewSnapshotTests {
    
    func checkButtonWithArrowListView<T: View>(view: T, named: String, testName: String, disabled: Bool = false) {
        let buttonWithArrowListViewWrapper = ButtonWithArrowListViewWrapper(view: view)
        let view = UIHostingController(rootView: buttonWithArrowListViewWrapper)
        let result = verifySnapshot(
            matching: view,
            as: .image,
            named: named,
            file: getFilePath(),
            testName: testName)
        XCTAssertNil(result)
    }
    
}
