//
//  TitleMoreDetailTextMessageListViewSnapshotTests.swift
//  AdmiralSwiftUITests
//
//  Created on 18.11.2021.
//

import XCTest
import SwiftUI
import SnapshotTesting
import AdmiralTheme
@testable import AdmiralSwiftUI

private struct TitleMoreDetailTextMessageListViewWrapper<T: View>: View {
    
    // MARK: - Properties
    let view: T
    
    // MARK: - Layout
    var body: some View {
        view
            .frame(width: 200, height: 200)
    }
    
}

final class TitleMoreDetailTextMessageListViewSnapshotTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        Appearance.prepare()
    }
    
    // MARK: Default Theme
    
    func testTitleMoreDetailTextMessageListViewDefaultTheme() {
        Appearance.shared.theme = .default
        let view = createTitleMoreDetailTextMessageListView()
        checkTitleMoreDetailTextMessageListView(view: view, named: "DefaultTheme", testName: "TitleMoreDetailTextMessageListView")
    }
    
    // MARK: Dark Theme
    
    func testTitleMoreDetailTextMessageListViewDarkTheme() {
        Appearance.shared.theme = .dark
        let view = createTitleMoreDetailTextMessageListView()
        checkTitleMoreDetailTextMessageListView(view: view, named: "DarkTheme", testName: "TitleMoreDetailTextMessageListView")
    }

    // MARK: - Scheme Provider

    func testSchemeProvider() {
        Appearance.shared.theme = .default
        var scheme = TitleMoreDetailTextMessageListViewScheme(theme: .default)
        scheme.detaileMoreLabelTextColor.set(parameter: AColor(color: .systemPink), for: .normal)
        scheme.detaileTitleLabelTextColor.set(parameter: AColor(color: .systemPink), for: .normal)
        scheme.titleLabelTextColor.set(parameter: AColor(color: .systemPink), for: .normal)
        scheme.subtitleLabelTextColor.set(parameter: AColor(color: .systemPink), for: .normal)
        let newSchemeProvider = SchemeProvider<TitleMoreDetailTextMessageListViewScheme>(scheme: scheme)

        let view = createTitleMoreDetailTextMessageListView(schemeProvider: newSchemeProvider)
        checkTitleMoreDetailTextMessageListView(view: view, named: "SchemeProvider", testName: "TitleMoreDetailTextMessageListView")

        Appearance.shared.theme = .dark
        let newView = createTitleMoreDetailTextMessageListView(schemeProvider: newSchemeProvider)
        checkTitleMoreDetailTextMessageListView(view: newView, named: "SchemeProvider", testName: "TitleMoreDetailTextMessageListView")
    }
    
    func createTitleMoreDetailTextMessageListView() -> some View {
        let view = TitleMoreDetailTextMessageListView(
            title: "Title",
            more: "More",
            detaile: "Detail",
            detaileMore: "More",
            subtitle: "Subtitle",
            tagText: "Percent",
            messageText: "Text message",
            infoImage: AdmiralUIResources.AssetSymbol.Service.Outline.info.image)
        return view
    }

    func createTitleMoreDetailTextMessageListView(schemeProvider: SchemeProvider<TitleMoreDetailTextMessageListViewScheme>) -> some View {
        let view = TitleMoreDetailTextMessageListView(
            title: "Title",
            more: "More",
            detaile: "Detail",
            detaileMore: "More",
            subtitle: "Subtitle",
            tagText: "Percent",
            messageText: "Text message",
            infoImage: AdmiralUIResources.AssetSymbol.Service.Outline.info.image,
            schemeProvider: schemeProvider
        )
        return view
    }
    
}

private extension TitleMoreDetailTextMessageListViewSnapshotTests {
    
    func checkTitleMoreDetailTextMessageListView<T: View>(view: T, named: String, testName: String, disabled: Bool = false) {
        let titleMoreDetailTextMessageListViewWrapper = TitleMoreDetailTextMessageListViewWrapper(view: view)
        let view = UIHostingController(rootView: titleMoreDetailTextMessageListViewWrapper)
        let result = verifySnapshot(
            matching: view,
            as: .image,
            named: named,
            file: getFilePath(),
            testName: testName)
        XCTAssertNil(result)
    }
    
}
