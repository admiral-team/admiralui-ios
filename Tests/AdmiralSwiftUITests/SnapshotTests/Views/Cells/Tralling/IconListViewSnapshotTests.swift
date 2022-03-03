//
//  IconListViewSnapshotTests.swift
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
    
    // MARK: Default Theme
    
    func testIconListViewDefaultTheme() {
        SwiftUIThemeManager.shared.theme = .default
        let view = createIconListView()
        checkIconListView(view: view, named: "DefaultTheme", testName: "IconListView")
    }
    
    // MARK: Dark Theme
    
    func testIconListViewDarkTheme() {
        SwiftUIThemeManager.shared.theme = .dark
        let view = createIconListView()
        checkIconListView(view: view, named: "DarkTheme", testName: "IconListView")
    }
    
    func createIconListView() -> some View {
        let view = IconListView(image: Image(uiImage: Asset.Finance.Solid.cardTSolid.image))
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
