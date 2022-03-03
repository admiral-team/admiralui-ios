//
//  TitleSubtitleButtonListViewSnapshotTests.swift
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

private struct TitleSubtitleButtonListViewWrapper<T: View>: View {
    
    // MARK: - Properties
    let view: T
    
    // MARK: - Layout
    var body: some View {
        view
            .frame(width: 200, height: 200)
    }
    
}

final class TitleSubtitleButtonListViewSnapshotTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        Appearance.prepare()
    }
    
    // MARK: Default Theme
    
    func testTitleSubtitleButtonListViewDefaultTheme() {
        SwiftUIThemeManager.shared.theme = .default
        let view = createTitleSubtitleButtonListView()
        checkTitleSubtitleButtonListView(view: view, named: "DefaultTheme", testName: "TitleSubtitleButtonListView")
    }
    
    // MARK: Dark Theme
    
    func testTitleSubtitleButtonListViewDarkTheme() {
        SwiftUIThemeManager.shared.theme = .dark
        let view = createTitleSubtitleButtonListView()
        checkTitleSubtitleButtonListView(view: view, named: "DarkTheme", testName: "TitleSubtitleButtonListView")
    }
    
    func createTitleSubtitleButtonListView() -> some View {
        let view = TitleSubtitleButtonListView(
            title: "Title",
            tagSubtitle: "Subtitle",
            tagText: "Percent",
            subtitle: "Subtitle 2",
            buttonTitle: "Button",
            buttonAction: {})
            .padding()
        return view
    }
    
}

private extension TitleSubtitleButtonListViewSnapshotTests {
    
    func checkTitleSubtitleButtonListView<T: View>(view: T, named: String, testName: String, disabled: Bool = false) {
        let titleSubtitleButtonListViewWrapper = TitleSubtitleButtonListViewWrapper(view: view)
        let view = UIHostingController(rootView: titleSubtitleButtonListViewWrapper)
        let result = verifySnapshot(
            matching: view,
            as: .image,
            named: named,
            file: getFilePath(),
            testName: testName)
        XCTAssertNil(result)
    }
    
}
