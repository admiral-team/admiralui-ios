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
import AdmiralUIResources
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
        SwiftUIThemeManager.shared.theme = .default
        let view = createTitleMoreDetailTextMessageListView()
        checkTitleMoreDetailTextMessageListView(view: view, named: "DefaultTheme", testName: "TitleMoreDetailTextMessageListView")
    }
    
    // MARK: Dark Theme
    
    func testTitleMoreDetailTextMessageListViewDarkTheme() {
        SwiftUIThemeManager.shared.theme = .dark
        let view = createTitleMoreDetailTextMessageListView()
        checkTitleMoreDetailTextMessageListView(view: view, named: "DarkTheme", testName: "TitleMoreDetailTextMessageListView")
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
