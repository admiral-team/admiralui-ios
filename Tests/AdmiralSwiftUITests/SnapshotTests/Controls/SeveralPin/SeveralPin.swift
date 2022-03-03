//
//  SeveralPin.swift
//  AdmiralUIResources
//
//  Created on 26.10.2021.
//

import XCTest
import SwiftUI
import SnapshotTesting
import AdmiralTheme
import AdmiralUIResources
@testable import AdmiralSwiftUI

private struct ButtonWrapper<T: View>: View {

    // MARK: - Properties
    let view: T
    let disabled: Bool

    // MARK: - Layout
    var body: some View {
        view
            .frame(width: 30, height: 30)
            .disabled(disabled)
    }

}

final class SeveralPinButtonSnapshotTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        Appearance.prepare()
    }
    
    // MARK: Default Theme

    func testSeveralPinButton() {
        SwiftUIThemeManager.shared.theme = .default
        let severalPinButton = Button(action: {}, label: {}).buttonStyle(SeveralPinButtonStyle(value: .constant("")))
        checkMapButton(view: severalPinButton, named: "default", testName: "severalPinButton")
    }

    func testSeveralPinButtonDisabled() {
        SwiftUIThemeManager.shared.theme = .default
        let severalPinButton = Button(action: {}, label: {}).buttonStyle(SeveralPinButtonStyle(value: .constant("")))
        checkMapButton(view: severalPinButton, named: "default", testName: "severalPinButtonDisabled", disabled: true)
    }
    
    // MARK: Dark Theme

    func testSeveralPinButtonDarkTheme() {
        SwiftUIThemeManager.shared.theme = .dark
        let severalPinButton = Button(action: {}, label: {}).buttonStyle(SeveralPinButtonStyle(value: .constant("")))
        checkMapButton(view: severalPinButton, named: "defaultDarkTheme", testName: "severalPinButton")
    }

    func testSeveralPinButtonDisabledDarkTheme() {
        SwiftUIThemeManager.shared.theme = .dark
        let severalPinButton = Button(action: {}, label: {}).buttonStyle(SeveralPinButtonStyle(value: .constant("")))
        checkMapButton(view: severalPinButton, named: "defaultDarkTheme", testName: "severalPinButtonDisabled", disabled: true)
    }

}

private extension SeveralPinButtonSnapshotTests {

    func checkMapButton<T: View>(view: T, named: String, testName: String, disabled: Bool = false) {
        let buttonWrapper = ButtonWrapper(view: view, disabled: disabled)
        let view = UIHostingController(rootView: buttonWrapper)
        let result = verifySnapshot(
            matching: view,
            as: .image,
            named: named,
            file: getFilePath(),
            testName: testName)
        XCTAssertNil(result)
    }

}

