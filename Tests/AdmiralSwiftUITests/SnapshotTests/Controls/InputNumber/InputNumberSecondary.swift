//
//  InputNumberSecondary.swift
//  AdmiralSwiftUITests
//
//  Created by on 13.10.2022.
//  
//
import XCTest
import SwiftUI
import SnapshotTesting
import AdmiralTheme
import AdmiralUIResources
@testable import AdmiralSwiftUI

final class InputNumberSecondarySnapshotTests: XCTestCase {

    override func setUp() {
        super.setUp()
        Appearance.prepare()
    }

    // MARK: Default Theme

    func testInputNumber() {
        Appearance.shared.theme = .default
        let view = createInputNumber()
        checkInputNumber(view: view, named: "default", testName: "InputNumberSecondary")
    }

    // MARK: Dark Theme

    func testInputNumberDarkTheme() {
        Appearance.shared.theme = .dark
        let view = createInputNumber()
        checkInputNumber(view: view, named: "defaultDarkTheme", testName: "InputNumberSecondary")
    }

    func createInputNumber() -> some View {
        let inputNumber = InputNumber(
            titleText: .constant("InputNumber"),
            value: .constant(5.0),
            minimumValue: .constant(0.0),
            maximumValue: .constant(10.0),
            stepValue: .constant(1.0),
            style: .secondary
        ).frame(width: 300, height: 60, alignment: .center)
        return inputNumber
    }

    func testInputNumberSchemeProvider() {
        Appearance.shared.theme = .default

        let scheme = InputNumberScheme()
        scheme.buttonScheme.backgroundColor.set(parameter: AColor(color: .systemPink), for: .normal, style: .secondary)
        let newSchemeProvider: SchemeProvider<InputNumberScheme> = SchemeProvider<InputNumberScheme>(scheme: scheme)

        let inputNumber = InputNumber(
            titleText: .constant("InputNumber"),
            value: .constant(5.0),
            minimumValue: .constant(0.0),
            maximumValue: .constant(10.0),
            stepValue: .constant(1.0),
            style: .secondary,
            schemeProvider: newSchemeProvider
        ).frame(width: 300, height: 60, alignment: .center)
        checkInputNumber(view: inputNumber, named: "SchemeProvider", testName: "InputNumberSecondary")

        Appearance.shared.theme = .dark
        let newInputNumber = InputNumber(
            titleText: .constant("InputNumber"),
            value: .constant(5.0),
            minimumValue: .constant(0.0),
            maximumValue: .constant(10.0),
            stepValue: .constant(1.0),
            style: .secondary,
            schemeProvider: newSchemeProvider
        ).frame(width: 300, height: 60, alignment: .center)
        checkInputNumber(view: newInputNumber, named: "SchemeProvider", testName: "InputNumberSecondary")
    }

}

private extension InputNumberSecondarySnapshotTests {

    func checkInputNumber<T: View>(view: T, named: String, testName: String) {
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
