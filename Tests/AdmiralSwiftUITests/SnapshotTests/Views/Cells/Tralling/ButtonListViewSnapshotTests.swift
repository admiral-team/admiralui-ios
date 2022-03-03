//
//  ButtonListViewSnapshotTests.swift
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

private struct ButtonListViewWrapper<T: View>: View {
    
    // MARK: - Properties
    let view: T
    
    // MARK: - Layout
    var body: some View {
        view
            .frame(width: 200, height: 50)
    }
    
}

final class ButtonListViewSnapshotTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        Appearance.prepare()
    }
    
    // MARK: Default Theme
    
    func testButtonListViewDefaultTheme() {
        SwiftUIThemeManager.shared.theme = .default
        let view = createButtonListView()
        checkButtonListView(view: view, named: "DefaultTheme", testName: "ButtonListView")
    }
    
    // MARK: Dark Theme
    
    func testButtonListViewDarkTheme() {
        SwiftUIThemeManager.shared.theme = .dark
        let view = createButtonListView()
        checkButtonListView(view: view, named: "DarkTheme", testName: "ButtonListView")
    }
    
    func createButtonListView() -> some View {
        let view = ButtonListView(text: "Text", action: {})
        return view
    }
    
}

private extension ButtonListViewSnapshotTests {
    
    func checkButtonListView<T: View>(view: T, named: String, testName: String, disabled: Bool = false) {
        let buttonListViewWrapper = ButtonListViewWrapper(view: view)
        let view = UIHostingController(rootView: buttonListViewWrapper)
        let result = verifySnapshot(
            matching: view,
            as: .image,
            named: named,
            file: getFilePath(),
            testName: testName)
        XCTAssertNil(result)
    }
    
}
