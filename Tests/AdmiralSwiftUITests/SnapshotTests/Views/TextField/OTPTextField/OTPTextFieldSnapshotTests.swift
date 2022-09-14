//
//  OTPTextFieldSnapshotTests.swift
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

private struct OTPTextFieldWrapper<T: View>: View {
    
    // MARK: - Properties
    let view: T
    
    // MARK: - Layout
    var body: some View {
        view
            .frame(width: 500, height: 300)
    }
    
}

final class OTPTextFieldSnapshotTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        Appearance.prepare()
    }
    
    // MARK: Default Theme
    
    func testOTPTextFieldDefaultTheme() {
        Appearance.shared.theme = .default
        let view = createOTPTextField()
        checkOTPTextField(view: view, named: "DefaultTheme", testName: "OTPTextField")
    }
    
    // MARK: Dark Theme
    
    func testOTPTextFieldDarkTheme() {
        Appearance.shared.theme = .dark
        let view = createOTPTextField()
        checkOTPTextField(view: view, named: "DarkTheme", testName: "OTPTextField")
    }
    
    func createOTPTextField() -> some View {
        @State var text: String? = "Text"
        @State var state: TextInputState = .normal
        let view = OTPTextField(
            value: $text,
            formatter: Formatter(),
            contentType: .numberPad,
            placeholder: "СМС-код",
            state: $state,
            info: .constant("Additional text"))
        return view
    }
    
}

private extension OTPTextFieldSnapshotTests {
    
    func checkOTPTextField<T: View>(view: T, named: String, testName: String, disabled: Bool = false) {
        let oTPTextFieldWrapper = OTPTextFieldWrapper(view: view)
        let view = UIHostingController(rootView: oTPTextFieldWrapper)
        let result = verifySnapshot(
            matching: view,
            as: .image,
            named: named,
            file: getFilePath(),
            testName: testName)
        XCTAssertNil(result)
    }
    
}
