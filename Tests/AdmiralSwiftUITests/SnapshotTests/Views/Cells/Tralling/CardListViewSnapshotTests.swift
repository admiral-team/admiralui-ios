//
//  CardListViewSnapshotTests.swift
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

private struct CardListViewWrapper<T: View>: View {
    
    // MARK: - Properties
    let view: T
    
    // MARK: - Layout
    var body: some View {
        view
            .frame(width: 50, height: 50)
    }
    
}

final class CardListViewSnapshotTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        Appearance.prepare()
    }
    
    // MARK: - Default Theme
    
    func testCardListViewDefaultTheme() {
        Appearance.shared.theme = .default
        let view = createCardListView()
        checkCardListView(view: view, named: "DefaultTheme", testName: "CardListView")
    }
    
    // MARK: - Dark Theme
    
    func testCardListViewDarkTheme() {
        Appearance.shared.theme = .dark
        let view = createCardListView()
        checkCardListView(view: view, named: "DarkTheme", testName: "CardListView")
    }

    // MARK: - Scheme Provider

    func testSchemeProvider() {
        Appearance.shared.theme = .default
        var scheme = CardListViewScheme(theme: .default)
        scheme.imageTintColor.set(parameter: AColor(color: .systemPink), for: .normal)
        let newSchemeProvider = SchemeProvider<CardListViewScheme>(scheme: scheme)

        let view = createCardListView(schemeProvider: newSchemeProvider)
        checkCardListView(view: view, named: "SchemeProvider", testName: "CardListView")

        Appearance.shared.theme = .dark
        let newView = createCardListView(schemeProvider: newSchemeProvider)
        checkCardListView(view: newView, named: "SchemeProvider", testName: "CardListView")
    }
    
    func createCardListView() -> some View {
        let view = CardListView(image: Image(uiImage: Asset.Documents.Solid.accountDetailSolid.image))
        return view
    }

    func createCardListView(schemeProvider: SchemeProvider<CardListViewScheme>) -> some View {
        let view = CardListView(
            image: Image(uiImage: Asset.Documents.Solid.accountDetailSolid.image),
            renderingMode: .template,
            schemeProvider: schemeProvider
        )
        return view
    }
    
}

private extension CardListViewSnapshotTests {
    
    func checkCardListView<T: View>(view: T, named: String, testName: String, disabled: Bool = false) {
        let cardListViewWrapper = CardListViewWrapper(view: view)
        let view = UIHostingController(rootView: cardListViewWrapper)
        let result = verifySnapshot(
            matching: view,
            as: .image,
            named: named,
            file: getFilePath(),
            testName: testName)
        XCTAssertNil(result)
    }
    
}
