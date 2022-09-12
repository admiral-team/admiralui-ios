//
//  CustomSwitch.swift
//  AdmiralUIResources
//
//  Created on 22.10.2021.
//

import XCTest
import SwiftUI
import SnapshotTesting
import AdmiralTheme
import AdmiralUIResources
@testable import AdmiralSwiftUI

final class CustomSwitchSnapshotTests: XCTestCase {

    override func setUp() {
        super.setUp()
        Appearance.prepare()
    }
    
    // MARK: Default Theme
    
    func testCustomSwitch() {
        SwiftUIThemeManager.shared.theme = .default
        let customSwitch = CustomSwitch(isOn: .constant(true)).frame(width: 60, height: 60)
        checkSwitch(view: customSwitch, named: "Custom", testName: "Switch")
    }
    
    // MARK: Dark Theme
    
    func testCustomSwitchDarkTheme() {
        SwiftUIThemeManager.shared.theme = .dark
        let customSwitch = CustomSwitch(isOn: .constant(true)).frame(width: 60, height: 60)
        checkSwitch(view: customSwitch, named: "CustomDarkTheme", testName: "Switch")
    }

    func testCustomSwitchSchemeProvider() {
        SwiftUIThemeManager.shared.theme = .default
        var scheme = CustomSwitchScheme()
        scheme.onTintColorColor = AColor(color: .systemPink)
        let newSchemeProvider = SchemeProvider<CustomSwitchScheme>(scheme: scheme)

        let customSwitch = CustomSwitch(
            isOn: .constant(true),
            schemeProvider: newSchemeProvider
        ).frame(width: 60, height: 60)
        checkSwitch(view: customSwitch, named: "SchemeProvider", testName: "Switch")

        SwiftUIThemeManager.shared.theme = .dark
        let newCustomSwitch = CustomSwitch(
            isOn: .constant(true),
            schemeProvider: newSchemeProvider
        ).frame(width: 60, height: 60)
        checkSwitch(view: newCustomSwitch, named: "SchemeProvider", testName: "Switch")
    }

}

private extension CustomSwitchSnapshotTests {

    func checkSwitch<T: View>(view: T, named: String, testName: String) {
        let view = UIHostingController(rootView: view)
        let result = verifySnapshot(
            matching: view,
            as: .image,
            named: named,
            file: getFilePath(),
            testName: testName)
        XCTAssertNil(result)
    }

}
