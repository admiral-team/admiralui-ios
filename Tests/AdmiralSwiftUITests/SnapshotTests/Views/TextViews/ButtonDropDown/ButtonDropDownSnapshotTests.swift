//
//  ButtonDropDownSnapshotTests.swift
//  AdmiralSwiftUITests
//
//  Created on 12.11.2021.
//

import XCTest
import SwiftUI
import SnapshotTesting
import AdmiralTheme
import AdmiralUIResources
@testable import AdmiralSwiftUI

private struct ButtonDropDownWrapper<T: View>: View {
    
    // MARK: - Properties
    let view: T
    
    // MARK: - Layout
    var body: some View {
        view
            .frame(width: 200, height: 100)
    }
    
}

final class ButtonDropDownSnapshotTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        Appearance.prepare()
    }
    
    // MARK: Default Theme
    
    func testButtonDropDownDefaultTheme() {
        Appearance.shared.theme = .default
        let view = createButtonDropDown()
        checkButtonDropDown(view: view, named: "DefaultTheme", testName: "ButtonDropDown")
    }
    
    // MARK: Dark Theme
    
    func testButtonDropDownDarkTheme() {
        Appearance.shared.theme = .default
        let view = createButtonDropDown()
        checkButtonDropDown(view: view, named: "DarkTheme", testName: "ButtonDropDown")
    }
    
    func createButtonDropDown() -> some View {
        let view = ButtonDropDown(buttonTitle: "ButtonDropDown", buttonAction: {})
        return view
    }
    
}

private extension ButtonDropDownSnapshotTests {
    
    func checkButtonDropDown<T: View>(view: T, named: String, testName: String, disabled: Bool = false) {
        let buttonDropDownWrapper = ButtonDropDownWrapper(view: view)
        let view = UIHostingController(rootView: buttonDropDownWrapper)
        let result = verifySnapshot(
            matching: view,
            as: .image,
            named: named,
            file: getFilePath(),
            testName: testName)
        XCTAssertNil(result)
    }
    
}
