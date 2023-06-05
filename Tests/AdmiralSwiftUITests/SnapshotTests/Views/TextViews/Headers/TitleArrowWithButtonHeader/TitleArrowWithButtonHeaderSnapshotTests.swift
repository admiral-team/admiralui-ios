//
//  TitleArrowWithButtonHeaderSnapshotTests.swift
//  AdmiralSwiftUITests
//
//  Created on 12.11.2021.
//

import XCTest
import SwiftUI
import SnapshotTesting
import AdmiralTheme
@testable import AdmiralSwiftUI

private struct TitleArrowWithButtonHeaderWrapper<T: View>: View {
    
    // MARK: - Properties
    let view: T
    
    // MARK: - Layout
    var body: some View {
        view
            .frame(width: 500, height: 150)
    }
    
}

final class TitleArrowWithButtonHeaderSnapshotTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        Appearance.prepare()
    }
    
    // MARK: Default Theme
    
    func testTitleArrowWithButtonHeaderDefaultTheme() {
        Appearance.shared.theme = .default
        let view = createTitleArrowWithButtonHeader()
        checkTitleArrowWithButtonHeader(view: view, named: "DefaultTheme", testName: "TitleArrowWithButtonHeader")
    }
    
    // MARK: Dark Theme
    
    func testTitleArrowWithButtonHeaderDarkTheme() {
        Appearance.shared.theme = .default
        let view = createTitleArrowWithButtonHeader()
        checkTitleArrowWithButtonHeader(view: view, named: "DarkTheme", testName: "TitleArrowWithButtonHeader")
    }
    
    func createTitleArrowWithButtonHeader() -> some View {
        let view = TitleArrowWithButtonHeader(title: "TitleArrowWithButtonHeader", buttonTitle: "Button", buttonAction: {})
        return view
    }
    
}

private extension TitleArrowWithButtonHeaderSnapshotTests {
    
    func checkTitleArrowWithButtonHeader<T: View>(view: T, named: String, testName: String, disabled: Bool = false) {
        let titleArrowWithButtonHeaderWrapper = TitleArrowWithButtonHeaderWrapper(view: view)
        let view = UIHostingController(rootView: titleArrowWithButtonHeaderWrapper)
        let result = verifySnapshot(
            matching: view,
            as: .image,
            named: named,
            file: getFilePath(),
            testName: testName)
        XCTAssertNil(result)
    }
    
}
