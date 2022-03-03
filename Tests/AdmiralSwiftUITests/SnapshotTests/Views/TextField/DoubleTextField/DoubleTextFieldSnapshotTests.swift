//
//  DoubleTextFieldSnapshotTests.swift
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

private struct DoubleTextFieldWrapper<T: View>: View {
    
    // MARK: - Properties
    let view: T
    
    // MARK: - Layout
    var body: some View {
        view
            .frame(width: 500, height: 300)
    }
    
}

final class DoubleTextFieldSnapshotTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        Appearance.prepare()
    }
    
    // MARK: Default Theme
    
    func testDoubleTextFieldDefaultTheme() {
        SwiftUIThemeManager.shared.theme = .default
        let view = createDoubleTextField()
        checkDoubleTextField(view: view, named: "DefaultTheme", testName: "DoubleTextField")
    }
    
    // MARK: Dark Theme
    
    func testDoubleTextFieldDarkTheme() {
        SwiftUIThemeManager.shared.theme = .dark
        let view = createDoubleTextField()
        checkDoubleTextField(view: view, named: "DarkTheme", testName: "DoubleTextField")
    }
    
    func createDoubleTextField() -> some View {
        @State var text: String? = "text"
        @State var textSecond: String? = "textSecond"
        let view = DoubleTextField(
            firstTextField: StandardTextField($text, placeholder: "P1", name: "Optional Label", state: .constant(.normal)),
            secondTextField: StandardTextField($textSecond, placeholder: "P2", name: "Optional Label", state: .constant(.normal)),
            alignment: .ratio(ration: 0.7),
            info: "Info",
            infoNumberOfLines: 1,
            state: .constant(.normal))
            .padding(16.0)
            .previewLayout(PreviewLayout.sizeThatFits)
        return view
    }
    
}

private extension DoubleTextFieldSnapshotTests {
    
    func checkDoubleTextField<T: View>(view: T, named: String, testName: String, disabled: Bool = false) {
        let doubleTextFieldWrapper = DoubleTextFieldWrapper(view: view)
        let view = UIHostingController(rootView: doubleTextFieldWrapper)
        let result = verifySnapshot(
            matching: view,
            as: .image,
            named: named,
            file: getFilePath(),
            testName: testName)
        XCTAssertNil(result)
    }
    
}
