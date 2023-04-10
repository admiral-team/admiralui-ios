//
//  IconListViewSnapshotTests.swift
//  AdmiralSwiftUITests
//
//  Created on 18.11.2021.
//

import XCTest
import SwiftUI
import SnapshotTesting
import AdmiralCore
import AdmiralTheme
import AdmiralUIResources
@testable import AdmiralSwiftUI

private struct IconListViewWrapper<T: View>: View {
    
    // MARK: - Properties
    let view: T
    
    // MARK: - Layout
    var body: some View {
        view
            .frame(width: 50, height: 50)
    }
    
}

final class IconListViewSnapshotTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        Appearance.prepare()
    }
    
    // MARK: - Default Theme
    
    func testIconListViewDefaultTheme() {
        Appearance.shared.theme = .default
        let view = createIconListView()
        checkIconListView(view: view, named: "DefaultTheme", testName: "IconListView")
    }
    
    // MARK: - Dark Theme
    
    func testIconListViewDarkTheme() {
        Appearance.shared.theme = .dark
        let view = createIconListView()
        checkIconListView(view: view, named: "DarkTheme", testName: "IconListView")
    }

    // MARK: - Scheme Provider

    func testSchemeProvider() {
        Appearance.shared.theme = .default
        var scheme = IconListViewScheme(theme: .default)
        scheme.imageTintColor.set(parameter: AColor(color: .systemPink), for: .normal, style: nil)
        let newSchemeProvider = SchemeProvider<IconListViewScheme>(scheme: scheme)

        let view = createIconListView(schemeProvider: newSchemeProvider)
        checkIconListView(view: view, named: "SchemeProvider", testName: "IconListView")

        Appearance.shared.theme = .dark
        let newView = createIconListView(schemeProvider: newSchemeProvider)
        checkIconListView(view: newView, named: "SchemeProvider", testName: "IconListView")
    }
    
    func createIconListView() -> some View {
        let view = IconListView(image: Image(uiImage: Asset.Finance.Solid.cardTSolid.image))
        return view
    }

    func createIconListView(schemeProvider: SchemeProvider<IconListViewScheme>) -> some View {
        let view = IconListView(
            image: Image(uiImage: Asset.Finance.Solid.cardTSolid.image),
            renderingMode: .template,
            schemeProvider: schemeProvider
        )
        return view
    }
    
}

private extension IconListViewSnapshotTests {
    
    func checkIconListView<T: View>(view: T, named: String, testName: String, disabled: Bool = false) {
        let iconListViewWrapper = IconListViewWrapper(view: view)
        let view = UIHostingController(rootView: iconListViewWrapper)
        let result = verifySnapshot(
            matching: view,
            as: .image,
            named: named,
            file: getFilePath(),
            testName: testName)
        XCTAssertNil(result)
    }
    
}
