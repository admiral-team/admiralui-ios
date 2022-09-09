//
//  CheckBox.swift
//  AdmiralUIResources
//
//  Created on 25.10.2021.
//

import XCTest
import SwiftUI
import SnapshotTesting
import AdmiralTheme
import AdmiralUIResources
@testable import AdmiralSwiftUI

private struct CheckControlWrapper<T: View>: View {

    // MARK: - Properties
    let view: T

    // MARK: - Layout
    var body: some View {
        view
            .frame(width: 200, height: 50)
    }

}

final class CheckControlSnapshotTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        Appearance.prepare()
    }
    
    // MARK: Default Theme

    func testSelectedCheckBox() {
        SwiftUIThemeManager.shared.theme = .default
        let checkBox = CheckBox(isSelected: .constant(true), text: "CheckBox", checkState: .normal)
        checkControl(view: checkBox, named: "selected", testName: "CheckBoxNormal")
    }

    func testNotSelectedCheckBox() {
        SwiftUIThemeManager.shared.theme = .default
        let checkBox = CheckBox(isSelected: .constant(false), text: "CheckBox", checkState: .normal)
        checkControl(view: checkBox, named: "notSelected", testName: "CheckBoxNormal")
    }

    func testSelectedCheckBoxError() {
        SwiftUIThemeManager.shared.theme = .default
        let checkBox = CheckBox(isSelected: .constant(true), text: "CheckBox", checkState: .error)
        checkControl(view: checkBox, named: "selected", testName: "CheckBoxError")
    }

    func testNotSelectedCheckBoxError() {
        SwiftUIThemeManager.shared.theme = .default
        let checkBox = CheckBox(isSelected: .constant(false), text: "CheckBox", checkState: .error)
        checkControl(view: checkBox, named: "notSelected", testName: "CheckBoxError")
    }
    
    // MARK: Dark Theme
    
    func testSelectedCheckBoxDarkTheme() {
        SwiftUIThemeManager.shared.theme = .dark
        let checkBox = CheckBox(isSelected: .constant(true), text: "CheckBox", checkState: .normal)
        checkControl(view: checkBox, named: "selectedDarkTheme", testName: "CheckBoxNormal")
    }

    func testNotSelectedCheckBoxDarkTheme() {
        SwiftUIThemeManager.shared.theme = .dark
        let checkBox = CheckBox(isSelected: .constant(false), text: "CheckBox", checkState: .normal)
        checkControl(view: checkBox, named: "notSelectedDarkTheme", testName: "CheckBoxNormal")
    }

    func testSelectedCheckBoxErrorDarkTheme() {
        SwiftUIThemeManager.shared.theme = .dark
        let checkBox = CheckBox(isSelected: .constant(true), text: "CheckBox", checkState: .error)
        checkControl(view: checkBox, named: "selectedDarkTheme", testName: "CheckBoxError")
    }

    func testNotSelectedCheckBoxErrorDarkTheme() {
        SwiftUIThemeManager.shared.theme = .dark
        let checkBox = CheckBox(isSelected: .constant(false), text: "CheckBox", checkState: .error)
        checkControl(view: checkBox, named: "notSelectedDarkTheme", testName: "CheckBoxError")
    }

    func testCheckBoxSchemeProvider() {
        SwiftUIThemeManager.shared.theme = .default

        var scheme = CheckControlScheme()
        scheme.textColor.set(parameter: AColor(color: .systemPink), for: .normal)
        scheme.tintColor.set(parameter: AColor(color: .systemPink), for: .normal, state: .normal)
        let newSchemeProvider: SchemeProvider<CheckControlScheme> = SchemeProvider<CheckControlScheme>(scheme: scheme)

        let checkBox = CheckBox(
            isSelected: .constant(false),
            text: "CheckBox",
            checkState: .normal,
            schemeProvider: newSchemeProvider
        )
        checkControl(view: checkBox, named: "SchemeProvider", testName: "CheckBox")

        SwiftUIThemeManager.shared.theme = .dark
        let newCheckBox = CheckBox(
            isSelected: .constant(false),
            text: "CheckBox",
            checkState: .normal,
            schemeProvider: newSchemeProvider
        )
        checkControl(view: newCheckBox, named: "SchemeProvider", testName: "CheckBox")
    }

}

private extension CheckControlSnapshotTests {

    func checkControl<T: View>(view: T, named: String, testName: String) {
        let checkControlWrapper = CheckControlWrapper(view: view)
        let view = UIHostingController(rootView: checkControlWrapper)
        let result = verifySnapshot(
            matching: view,
            as: .image,
            named: named,
            file: getFilePath(),
            testName: testName)
        XCTAssertNil(result)
    }

}
