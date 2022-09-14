//
//  SwitchListViewSnapshotTests.swift
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

private struct SwitchListViewWrapper<T: View>: View {
    
    // MARK: - Properties
    let view: T
    
    // MARK: - Layout
    var body: some View {
        view
            .frame(width: 80, height: 50)
    }
    
}

final class SwitchListViewSnapshotTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        Appearance.prepare()
    }
    
    // MARK: Default Theme
    
    func testSwitchListViewSelectedDefaultTheme() {
        Appearance.shared.theme = .default
        let view = createSwitchListView(isSelected: true)
        checkSwitchListView(view: view, named: "SelectedDefaultTheme", testName: "SwitchListView")
    }
    
    func testSwitchListViewNotSelectedDefaultTheme() {
        Appearance.shared.theme = .default
        let view = createSwitchListView(isSelected: false)
        checkSwitchListView(view: view, named: "NotSelectedDefaultTheme", testName: "SwitchListView")
    }
    
    // MARK: Dark Theme
    
    func testSwitchListViewSelectedDarkTheme() {
        Appearance.shared.theme = .dark
        let view = createSwitchListView(isSelected: true)
        checkSwitchListView(view: view, named: "SelectedDarkTheme", testName: "SwitchListView")
    }
    
    func testSwitchListViewNotSelectedDarkTheme() {
        Appearance.shared.theme = .dark
        let view = createSwitchListView(isSelected: false)
        checkSwitchListView(view: view, named: "NotSelectedDarkTheme", testName: "SwitchListView")
    }
    
    func createSwitchListView(isSelected: Bool) -> some View {
        let view = SwitchListView(isSwitchSelected: .constant(isSelected)).padding()
        return view
    }
    
}

private extension SwitchListViewSnapshotTests {
    
    func checkSwitchListView<T: View>(view: T, named: String, testName: String, disabled: Bool = false) {
        let switchListViewWrapper = SwitchListViewWrapper(view: view)
        let view = UIHostingController(rootView: switchListViewWrapper)
        let result = verifySnapshot(
            matching: view,
            as: .image,
            named: named,
            file: getFilePath(),
            testName: testName)
        XCTAssertNil(result)
    }
    
}
