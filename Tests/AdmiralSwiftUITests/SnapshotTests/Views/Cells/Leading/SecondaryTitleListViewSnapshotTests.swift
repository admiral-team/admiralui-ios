//
//  SecondaryTitleListViewSnapshotTests.swift
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

private struct SecondaryTitleListViewWrapper<T: View>: View {
    
    // MARK: - Properties
    let view: T
    
    // MARK: - Layout
    var body: some View {
        view
            .frame(width: 100, height: 100)
    }
    
}

final class SecondaryTitleListViewSnapshotTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        Appearance.prepare()
    }
    
    // MARK: Default Theme
    
    func testSecondaryTitleListViewDefaultTheme() {
        SwiftUIThemeManager.shared.theme = .default
        let view = createSecondaryTitleListView()
        checkSecondaryTitleListView(view: view, named: "DefaultTheme", testName: "SecondaryTitleListView")
    }
    
    // MARK: Dark Theme
    
    func testSecondaryTitleListViewDarkTheme() {
        SwiftUIThemeManager.shared.theme = .dark
        let view = createSecondaryTitleListView()
        checkSecondaryTitleListView(view: view, named: "DarkTheme", testName: "SecondaryTitleListView")
    }
    
    func createSecondaryTitleListView() -> some View {
        let view = SecondaryTitleListView(title: "Title")
        return view
    }
    
}

private extension SecondaryTitleListViewSnapshotTests {
    
    func checkSecondaryTitleListView<T: View>(view: T, named: String, testName: String, disabled: Bool = false) {
        let secondaryTitleListViewWrapper = SecondaryTitleListViewWrapper(view: view)
        let view = UIHostingController(rootView: secondaryTitleListViewWrapper)
        let result = verifySnapshot(
            matching: view,
            as: .image,
            named: named,
            file: getFilePath(),
            testName: testName)
        XCTAssertNil(result)
    }
    
}
