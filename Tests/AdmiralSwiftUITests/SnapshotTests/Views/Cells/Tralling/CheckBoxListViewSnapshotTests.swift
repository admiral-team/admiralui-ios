//
//  CheckBoxListViewSnapshotTests.swift
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

private struct CheckBoxListViewWrapper<T: View>: View {
    
    // MARK: - Properties
    let view: T
    
    // MARK: - Layout
    var body: some View {
        view
            .frame(width: 50, height: 50)
    }
    
}

final class CheckBoxListViewSnapshotTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        Appearance.prepare()
    }
    
    // MARK: Default Theme
    
    func testCheckBoxListViewSelectedDefaultTheme() {
        SwiftUIThemeManager.shared.theme = .default
        let view = createCheckBoxListView(isSelected: true)
        checkCheckBoxListView(view: view, named: "IsSelectedDefaultTheme", testName: "CheckBoxListView")
    }
    
    func testCheckBoxListViewNotSelectedDefaultTheme() {
        SwiftUIThemeManager.shared.theme = .default
        let view = createCheckBoxListView(isSelected: false)
        checkCheckBoxListView(view: view, named: "NotSelectedDefaultTheme", testName: "CheckBoxListView")
    }
    
    // MARK: Dark Theme
    
    func testCheckBoxListViewSelectedDarkTheme() {
        SwiftUIThemeManager.shared.theme = .dark
        let view = createCheckBoxListView(isSelected: true)
        checkCheckBoxListView(view: view, named: "SelectedDarkTheme", testName: "CheckBoxListView")
    }
    
    func testCheckBoxListViewNotSelectedDarkTheme() {
        SwiftUIThemeManager.shared.theme = .dark
        let view = createCheckBoxListView(isSelected: false)
        checkCheckBoxListView(view: view, named: "NotSelectedDarkTheme", testName: "CheckBoxListView")
    }
    
    func createCheckBoxListView(isSelected: Bool) -> some View {
        let view = CheckBoxListView(isControlSelected: .constant(isSelected))
        return view
    }
    
}

private extension CheckBoxListViewSnapshotTests {
    
    func checkCheckBoxListView<T: View>(view: T, named: String, testName: String, disabled: Bool = false) {
        let checkBoxListViewWrapper = CheckBoxListViewWrapper(view: view)
        let view = UIHostingController(rootView: checkBoxListViewWrapper)
        let result = verifySnapshot(
            matching: view,
            as: .image,
            named: named,
            file: getFilePath(),
            testName: testName)
        XCTAssertNil(result)
    }
    
}
