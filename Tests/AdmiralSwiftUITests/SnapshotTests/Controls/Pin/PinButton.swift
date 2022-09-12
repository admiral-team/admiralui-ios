//
//  PinButton.swift
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
            .frame(width: 50, height: 50)
            .disabled(disabled)
    }

}

final class PinButtonSnapshotTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        Appearance.prepare()
    }
    
    // MARK: Default Theme

    func testSeveralPinButton() {
        Appearance.shared.theme = .default
        let pinButton =  Button(action: {}, label: {})
            .buttonStyle(PinButtonStyle(image: AssetSymbol.Category.Outline.acuringModern.image, isSelected: .constant(false)))
        checkPinButton(view: pinButton, named: "default", testName: "PinButton")
    }

    func testSeveralPinButtonDisabled() {
        Appearance.shared.theme = .default
        let pinButton = Button(action: {}, label: {})
            .buttonStyle(PinButtonStyle(image: AssetSymbol.Category.Outline.acuringModern.image, isSelected: .constant(true)))
        checkPinButton(view: pinButton, named: "default", testName: "PinButtonDisabled", disabled: true)
    }
    
    // MARK: Dark Theme
    
    func testSeveralPinButtonDarkTheme() {
        Appearance.shared.theme = .dark
        let pinButton =  Button(action: {}, label: {})
            .buttonStyle(PinButtonStyle(image: AssetSymbol.Category.Outline.acuringModern.image, isSelected: .constant(false)))
        checkPinButton(view: pinButton, named: "defaultDarkTheme", testName: "PinButton")
    }

    func testSeveralPinButtonDisabledDarkTheme() {
        Appearance.shared.theme = .dark
        let pinButton = Button(action: {}, label: {})
            .buttonStyle(PinButtonStyle(image: AssetSymbol.Category.Outline.acuringModern.image, isSelected: .constant(true)))
        checkPinButton(view: pinButton, named: "defaultDarkTheme", testName: "PinButtonDisabled", disabled: true)
    }

    func testPinProviderSchemeProvider() {
        SwiftUIThemeManager.shared.theme = .default
        var pinButtonScheme = PinButtonScheme()
        pinButtonScheme.backgroundColor = AColor(color: .systemPink)
        pinButtonScheme.selectedbackgroundColor = AColor(color: .systemPink)
        let newSchemeProvider: SchemeProvider<PinButtonScheme> = SchemeProvider<PinButtonScheme>(scheme: pinButtonScheme)

        let pinButton = Button(
            action: {},
            label: {}
        ).buttonStyle(
            PinButtonStyle(
                image: AssetSymbol.Category.Outline.acuringModern.image,
                isSelected: .constant(true),
                schemeProvider: newSchemeProvider
            )
        )
        checkPinButton(view: pinButton, named: "NewSchemeProvider", testName: "PinButton")

        SwiftUIThemeManager.shared.theme = .dark
        let newPinButton = Button(
            action: {},
            label: {}
        ).buttonStyle(
            PinButtonStyle(
                image: AssetSymbol.Category.Outline.acuringModern.image,
                isSelected: .constant(true),
                schemeProvider: newSchemeProvider
            )
        )
        checkPinButton(view: newPinButton, named: "NewSchemeProvider", testName: "PinButton")
    }

}

private extension PinButtonSnapshotTests {

    func checkPinButton<T: View>(view: T, named: String, testName: String, disabled: Bool = false) {
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
