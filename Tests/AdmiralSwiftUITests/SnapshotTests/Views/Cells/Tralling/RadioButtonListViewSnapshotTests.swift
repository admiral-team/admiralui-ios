//
//  RadioButtonListViewSnapshotTests.swift
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

private struct RadioButtonListViewWrapper<T: View>: View {
    
    // MARK: - Properties
    let view: T
    
    // MARK: - Layout
    var body: some View {
        view
            .frame(width: 50, height: 50)
    }
    
}

final class RadioButtonListViewSnapshotTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        Appearance.prepare()
    }
    
    // MARK: Default Theme
    
    func testRadioButtonListViewSelectedDefaultTheme() {
        Appearance.shared.theme = .default
        let view = createRadioButtonListView(isSelected: true)
        checkRadioButtonListView(view: view, named: "SelectedDefaultTheme", testName: "RadioButtonListView")
    }
    
    func testRadioButtonListViewNotSelectedDefaultTheme() {
        Appearance.shared.theme = .default
        let view = createRadioButtonListView(isSelected: false)
        checkRadioButtonListView(view: view, named: "NotSelectedDefaultTheme", testName: "RadioButtonListView")
    }
    
    // MARK: Dark Theme
    
    func testRadioButtonListViewSelectedDarkTheme() {
        Appearance.shared.theme = .dark
        let view = createRadioButtonListView(isSelected: true)
        checkRadioButtonListView(view: view, named: "SelectedDarkTheme", testName: "RadioButtonListView")
    }
    
    func testRadioButtonListViewNotSelectedDarkTheme() {
        Appearance.shared.theme = .dark
        let view = createRadioButtonListView(isSelected: false)
        checkRadioButtonListView(view: view, named: "NotSelectedDarkTheme", testName: "RadioButtonListView")
    }
    
    func createRadioButtonListView(isSelected: Bool) -> some View {
        let view = RadioButtonListView(isControlSelected: .constant(isSelected))
        return view
    }
    
}

private extension RadioButtonListViewSnapshotTests {
    
    func checkRadioButtonListView<T: View>(view: T, named: String, testName: String, disabled: Bool = false) {
        let radioButtonListViewWrapper = RadioButtonListViewWrapper(view: view)
        let view = UIHostingController(rootView: radioButtonListViewWrapper)
        let result = verifySnapshot(
            matching: view,
            as: .image,
            named: named,
            file: getFilePath(),
            testName: testName)
        XCTAssertNil(result)
    }
    
}
