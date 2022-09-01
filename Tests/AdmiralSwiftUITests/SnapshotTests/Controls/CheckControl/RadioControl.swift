//
//  RadioControl.swift
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

private struct RadioControlButtonWrapper<T: View>: View {

    // MARK: - Properties
    let view: T

    // MARK: - Layout
    var body: some View {
        view
            .frame(width: 300, height: 50)
    }

}

final class RadioControlSnapshotTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        Appearance.prepare()
    }
    
    // MARK: Default Theme

    func testSelectedRadioControl() {
        Appearance.shared.theme = .default
        let radioControl = RadioControl(isSelected: .constant(true), text: "SelectedRadioControl")
        checkRadioControl(view: radioControl, named: "selectedNormal", testName: "RadioControl")
    }

    func testNotSelectedRadioControl() {
        Appearance.shared.theme = .default
        let radioControl = RadioControl(isSelected: .constant(false), text: "NotSelectedRadioControl")
        checkRadioControl(view: radioControl, named: "notSelectedNormal", testName: "RadioControl")
    }

    func testSelectedRadioControlError() {
        Appearance.shared.theme = .default
        let radioControl = RadioControl(isSelected: .constant(true), text: "SelectedRadioControlError", checkState: .error)
        checkRadioControl(view: radioControl, named: "selectedError", testName: "RadioControl")
    }

    func testNotSelectedRadioControlError() {
        Appearance.shared.theme = .default
        let radioControl = RadioControl(isSelected: .constant(false), text: "NotSelectedRadioControlError", checkState: .error)
        checkRadioControl(view: radioControl, named: "notSelectedError", testName: "RadioControl")
    }
    
    // MARK: Dark Theme
    
    func testSelectedRadioControlDarkTheme() {
        Appearance.shared.theme = .dark
        let radioControl = RadioControl(isSelected: .constant(true), text: "SelectedRadioControl")
        checkRadioControl(view: radioControl, named: "selectedNormalDarkTheme", testName: "RadioControl")
    }

    func testNotSelectedRadioControlDarkTheme() {
        Appearance.shared.theme = .dark
        let radioControl = RadioControl(isSelected: .constant(false), text: "NotSelectedRadioControl")
        checkRadioControl(view: radioControl, named: "notSelectedNormalDarkTheme", testName: "RadioControl")
    }

    func testSelectedRadioControlErrorDarkTheme() {
        Appearance.shared.theme = .dark
        let radioControl = RadioControl(isSelected: .constant(true), text: "SelectedRadioControlError", checkState: .error)
        checkRadioControl(view: radioControl, named: "selectedErrorDarkTheme", testName: "RadioControl")
    }

    func testNotSelectedRadioControlErrorDarkTheme() {
        Appearance.shared.theme = .dark
        let radioControl = RadioControl(isSelected: .constant(false), text: "NotSelectedRadioControlError", checkState: .error)
        checkRadioControl(view: radioControl, named: "notSelectedErrorDarkTheme", testName: "RadioControl")
    }

}

private extension RadioControlSnapshotTests {

    func checkRadioControl<T: View>(view: T, named: String, testName: String) {
        let radioControlButtonWrapper = RadioControlButtonWrapper(view: view)
        let view = UIHostingController(rootView: radioControlButtonWrapper)
        let result = verifySnapshot(
            matching: view,
            as: .image,
            named: named,
            file: getFilePath(),
            testName: testName)
        XCTAssertNil(result)
    }

}
