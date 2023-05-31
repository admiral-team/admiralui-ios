//
//  DropDownHeaderSnapshotTests.swift
//  AdmiralSwiftUITests
//
//  Created on 12.11.2021.
//

import XCTest
import SwiftUI
import SnapshotTesting
import AdmiralTheme
@testable import AdmiralSwiftUI

private struct DropDownHeaderWrapper<T: View>: View {
    
    // MARK: - Properties
    let view: T
    
    // MARK: - Layout
    var body: some View {
        view
            .frame(width: 500, height: 150)
    }
    
}

final class DropDownHeaderSnapshotTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        Appearance.prepare()
    }
    
    // MARK: Default Theme
    
    func testDropDownHeaderDownTypeDefaultTheme() {
        Appearance.shared.theme = .default
        let view = createDropDownHeader(type: .down)
        checkDropDownHeader(view: view, named: "DropDownHeaderDownType.DefaultTheme", testName: "DropDownHeader")
    }
    
    func testDropDownHeaderUpTypeDefaultTheme() {
        Appearance.shared.theme = .default
        let view = createDropDownHeader(type: .up)
        checkDropDownHeader(view: view, named: "DropDownHeaderUpType.DefaultTheme", testName: "DropDownHeader")
    }
    
    // MARK: Dark Theme
    
    func testDropDownHeaderDownTypeDarkTheme() {
        Appearance.shared.theme = .dark
        let view = createDropDownHeader(type: .down)
        checkDropDownHeader(view: view, named: "DropDownHeaderDownType.DarkTheme", testName: "DropDownHeader")
    }
    
    func testDropDownHeaderUpTypeDarkTheme() {
        Appearance.shared.theme = .dark
        let view = createDropDownHeader(type: .up)
        checkDropDownHeader(view: view, named: "DropDownHeaderUpType.DarkTheme", testName: "DropDownHeader")
    }
    
    func createDropDownHeader(type: DropDownHeaderType) -> some View {
        let view = DropDownHeader(title: "DropDownHeader", dropDownHeaderType: type)
        return view
    }
    
}

private extension DropDownHeaderSnapshotTests {
    
    func checkDropDownHeader<T: View>(view: T, named: String, testName: String, disabled: Bool = false) {
        let dropDownHeaderWrapper = DropDownHeaderWrapper(view: view)
        let view = UIHostingController(rootView: dropDownHeaderWrapper)
        let result = verifySnapshot(
            matching: view,
            as: .image,
            named: named,
            file: getFilePath(),
            testName: testName)
        XCTAssertNil(result)
    }
    
}
