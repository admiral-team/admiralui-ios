//
//  CodeInputControl.swift
//  AdmiralUIResources
//
//  Created on 25.10.2021.
//

import XCTest
import SwiftUI
import SnapshotTesting
import AdmiralTheme
@testable import AdmiralSwiftUI

private struct CodeInputControlButtonWrapper<T: View>: View {

    // MARK: - Properties
    let view: T

    // MARK: - Layout
    var body: some View {
        view
            .frame(width: 250, height: 60, alignment: .bottomTrailing)
    }

}

final class CodeInputControlSnapshotTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        Appearance.prepare()
    }
    
    // MARK: Default Theme

    func testCodeInputControlNormal() {
        Appearance.shared.theme = .default
        let codeInputControl = CodeInputControl(text: .constant("CodeInputControl"), itemsCount: 4, status: .normal)
        checkCodeInputControl(view: codeInputControl, named: "Normal", testName: "CodeInputControl")
    }

    func testCodeInputControlError() {
        Appearance.shared.theme = .default
        let codeInputControl = CodeInputControl(text: .constant("CodeInputControl"), itemsCount: 4, status: .error)
        checkCodeInputControl(view: codeInputControl, named: "Error", testName: "CodeInputControl")
    }

    func testCodeInputControlSuccess() {
        Appearance.shared.theme = .default
        let codeInputControl = CodeInputControl(text: .constant("CodeInputControl"), itemsCount: 4, status: .success)
        checkCodeInputControl(view: codeInputControl, named: "Success", testName: "CodeInputControl")
    }
    
    // MARK: Dark Theme
    
    func testCodeInputControlNormalDarkTheme() {
        Appearance.shared.theme = .dark
        let codeInputControl = CodeInputControl(text: .constant("CodeInputControl"), itemsCount: 4, status: .normal)
        checkCodeInputControl(view: codeInputControl, named: "NormalDarkTheme", testName: "CodeInputControl")
    }

    func testCodeInputControlErrorDarkTheme() {
        Appearance.shared.theme = .dark
        let codeInputControl = CodeInputControl(text: .constant("CodeInputControl"), itemsCount: 4, status: .error)
        checkCodeInputControl(view: codeInputControl, named: "ErrorDarkTheme", testName: "CodeInputControl")
    }

    func testCodeInputControlSuccessDarkTheme() {
        Appearance.shared.theme = .dark
        let codeInputControl = CodeInputControl(text: .constant("CodeInputControl"), itemsCount: 4, status: .success)
        checkCodeInputControl(view: codeInputControl, named: "SuccessDarkTheme", testName: "CodeInputControl")
    }

    func testCodeInputControlSchemeProvider() {
        Appearance.shared.theme = .default
        var scheme = CodeInputControlScheme()
        scheme.defaultColor = AColor(color: .systemPink)
        scheme.activeColor = AColor(color: .systemPink)
        scheme.successColor = AColor(color: .systemPink)
        let newSchemeProvider = SchemeProvider<CodeInputControlScheme>(scheme: scheme)

        let codeInputControl = CodeInputControl(
            text: .constant("CodeInputControl"),
            itemsCount: 4,
            status: .normal,
            schemeProvider: newSchemeProvider
        )
        checkCodeInputControl(view: codeInputControl, named: "SchemeProvider", testName: "CodeInputControl")

        Appearance.shared.theme = .dark
        let newCodeInputControl = CodeInputControl(
            text: .constant("CodeInputControl"),
            itemsCount: 4,
            status: .normal,
            schemeProvider: newSchemeProvider
        )
        checkCodeInputControl(view: newCodeInputControl, named: "SchemeProvider", testName: "CodeInputControl")
    }

}

private extension CodeInputControlSnapshotTests {

    func checkCodeInputControl<T: View>(view: T, named: String, testName: String) {
        let codeInputControlButtonWrapper = CodeInputControlButtonWrapper(view: view)
        let view = UIHostingController(rootView: codeInputControlButtonWrapper)
        let result = verifySnapshot(
            matching: view,
            as: .image,
            named: named,
            file: getFilePath(),
            testName: testName)
        XCTAssertNil(result)
    }

}
