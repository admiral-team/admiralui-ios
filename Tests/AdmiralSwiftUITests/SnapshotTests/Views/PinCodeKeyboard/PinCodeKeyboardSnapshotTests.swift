//
//  PinCodeKeyboardSnapshotTests.swift
//  AdmiralSwiftUITests
//
//  Created on 15.11.2021.
//

import XCTest
import SwiftUI
import SnapshotTesting
import AdmiralTheme
import AdmiralImages
@testable import AdmiralSwiftUI

private struct PinCodeKeyboardWrapper<T: View>: View {
    
    // MARK: - Properties
    let view: T
    
    // MARK: - Layout
    var body: some View {
        view
            .frame(width: 500, height: 350)
    }
    
}

final class PinCodeKeyboardSnapshotTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        Appearance.prepare()
    }
    
    // MARK: Default Theme
    
    func testPinCodeKeyboardDefaultTheme() {
        Appearance.shared.theme = .default
        let view = createPinCodeKeyboard()
        checkPinCodeKeyboard(view: view, named: "DefaultTheme", testName: "PinCodeKeyboard")
    }
    
    // MARK: Dark Theme
    
    func testPinCodeKeyboardDarkTheme() {
        Appearance.shared.theme = .dark
        let view = createPinCodeKeyboard()
        checkPinCodeKeyboard(view: view, named: "DarkTheme", testName: "PinCodeKeyboard")
    }

    // MARK: - Scheme Provider

    func testSchemeProvider() {
        Appearance.shared.theme = .default
        var scheme = PinCodeKeyboardScheme(theme: .default)
        scheme.pinCodeNumberViewScheme.textColor = AColor(color: .systemPink)
        scheme.pinCodeTextViewScheme.textColor = AColor(color: .systemPink)
        let newSchemeProvider = SchemeProvider<PinCodeKeyboardScheme>(scheme: scheme)

        let customSwitch = createPinCodeKeyboard(schemeProvider: newSchemeProvider)
        checkPinCodeKeyboard(view: customSwitch, named: "SchemeProvider", testName: "PinCodeKeyboard")

        Appearance.shared.theme = .dark
        let newCustomSwitch = createPinCodeKeyboard(schemeProvider: newSchemeProvider)
        checkPinCodeKeyboard(view: newCustomSwitch, named: "SchemeProvider", testName: "PinCodeKeyboard")
    }
    
    func createPinCodeKeyboard() -> some View {
        let view = PinCodeKeyboard(
            leftButtonTitle: "Title",
            rightButtonImage: Image(uiImage: AdmiralImages.Asset.Category.Solid.burnSolid.image),
            didTapNumber: {_ in },
            didTapLeftButton: {},
            didTapRightButton: {})
        return view
    }

    func createPinCodeKeyboard(schemeProvider: SchemeProvider<PinCodeKeyboardScheme>) -> some View {
        let view = PinCodeKeyboard(
            leftButtonTitle: "Title",
            rightButtonImage: Image(uiImage: AdmiralImages.Asset.Category.Solid.burnSolid.image),
            schemeProvider: schemeProvider,
            didTapNumber: {_ in },
            didTapLeftButton: {},
            didTapRightButton: {})
        return view
    }
    
}

private extension PinCodeKeyboardSnapshotTests {
    
    func checkPinCodeKeyboard<T: View>(view: T, named: String, testName: String, disabled: Bool = false) {
        let pinCodeKeyboardWrapper = PinCodeKeyboardWrapper(view: view)
        let view = UIHostingController(rootView: pinCodeKeyboardWrapper)
        let result = verifySnapshot(
            matching: view,
            as: .image,
            named: named,
            file: getFilePath(),
            testName: testName)
        XCTAssertNil(result)
    }
    
}
