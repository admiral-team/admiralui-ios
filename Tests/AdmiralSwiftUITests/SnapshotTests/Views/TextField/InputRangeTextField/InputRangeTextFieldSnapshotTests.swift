//
//  InputRangeTextFieldSnapshotTests.swift
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

private struct InputRangeTextFieldWrapper<T: View>: View {
    
    // MARK: - Properties
    let view: T
    
    // MARK: - Layout
    var body: some View {
        view
            .frame(width: 800, height: 200)
    }
    
}

final class InputRangeTextFieldSnapshotTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        Appearance.prepare()
    }
    
    // MARK: Default Theme
    
    func testInputRangeTextFieldDefaultTheme() {
        Appearance.shared.theme = .default
        let view = createInputRangeTextField()
        checkInputRangeTextField(view: view, named: "DefaultTheme", testName: "InputRangeTextField")
    }
    
    // MARK: Dark Theme
    
    func testInputRangeTextFieldDarkTheme() {
        Appearance.shared.theme = .dark
        let view = createInputRangeTextField()
        checkInputRangeTextField(view: view, named: "DarkTheme", testName: "InputRangeTextField")
    }
    
    func createInputRangeTextField() -> some View {
        let view = InputRangeTextField(.constant("InputRangeTextField"))
        return view
    }
    
}

private extension InputRangeTextFieldSnapshotTests {
    
    func checkInputRangeTextField<T: View>(view: T, named: String, testName: String, disabled: Bool = false) {
        let inputRangeTextFieldWrapper = InputRangeTextFieldWrapper(view: view)
        let view = UIHostingController(rootView: inputRangeTextFieldWrapper)
        let result = verifySnapshot(
            matching: view,
            as: .image,
            named: named,
            file: getFilePath(),
            testName: testName)
        XCTAssertNil(result)
    }
    
}
