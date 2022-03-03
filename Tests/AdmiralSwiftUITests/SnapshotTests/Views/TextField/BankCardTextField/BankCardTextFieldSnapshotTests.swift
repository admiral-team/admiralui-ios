//
//  BankCardTextFieldSnapshotTests.swift
//  AdmiralSwiftUITests
//
//  Created on 16.11.2021.
//

import XCTest
import SwiftUI
import SnapshotTesting
import AdmiralTheme
import AdmiralUIResources
@testable import AdmiralSwiftUI

private struct BankCardTextFieldWrapper<T: View>: View {
    
    // MARK: - Properties
    let view: T
    
    // MARK: - Layout
    var body: some View {
        view
            .frame(width: 500, height: 300)
    }
    
}

final class BankCardTextFieldSnapshotTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        Appearance.prepare()
    }
    
    // MARK: Default Theme
    
    func testBankCardTextFieldDefaultTheme() {
        SwiftUIThemeManager.shared.theme = .default
        let view = createBankCardTextField()
        checkBankCardTextField(view: view, named: "DefaultTheme", testName: "BankCardTextField")
    }
    
    // MARK: Dark Theme
    
    func testBankCardTextFieldDarkTheme() {
        SwiftUIThemeManager.shared.theme = .dark
        let view = createBankCardTextField()
        checkBankCardTextField(view: view, named: "DarkTheme", testName: "BankCardTextField")
    }
    
    func createBankCardTextField() -> some View {
        @State var text: String? = "1111 2222 3333 4444"
        @State var state: TextInputState = .normal
        let view = BankCardTextField(
            value: $text,
            formatter: Formatter(),
            state: $state,
            contentType: .numberPad,
            placeholder: "1111 2222 3333 4444",
            info: .constant("Info"))

        return view
    }
    
}

private extension BankCardTextFieldSnapshotTests {
    
    func checkBankCardTextField<T: View>(view: T, named: String, testName: String, disabled: Bool = false) {
        let bankCardTextFieldWrapper = BankCardTextFieldWrapper(view: view)
        let view = UIHostingController(rootView: bankCardTextFieldWrapper)
        let result = verifySnapshot(
            matching: view,
            as: .image,
            named: named,
            file: getFilePath(),
            testName: testName)
        XCTAssertNil(result)
    }
    
}
