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
import AdmiralUIResources
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
        SwiftUIThemeManager.shared.theme = .default
        let view = createPinCodeKeyboard()
        checkPinCodeKeyboard(view: view, named: "DefaultTheme", testName: "PinCodeKeyboard")
    }
    
    // MARK: Dark Theme
    
    func testPinCodeKeyboardDarkTheme() {
        SwiftUIThemeManager.shared.theme = .dark
        let view = createPinCodeKeyboard()
        checkPinCodeKeyboard(view: view, named: "DarkTheme", testName: "PinCodeKeyboard")
    }
    
    func createPinCodeKeyboard() -> some View {
        let view = PinCodeKeyboard(
            leftButtonTitle: "Title",
            rightButtonImage: Image(uiImage: Asset.Category.Solid.burnSolid.image),
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
