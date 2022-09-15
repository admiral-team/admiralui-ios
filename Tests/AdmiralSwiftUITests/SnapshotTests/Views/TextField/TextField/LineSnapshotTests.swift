//
//  LineSnapshotTests.swift
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

private struct LineWrapper<T: View>: View {
    
    // MARK: - Properties
    let view: T
    
    // MARK: - Layout
    var body: some View {
        view
            .frame(width: 500, height: 100)
    }
    
}

final class LineSnapshotTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        Appearance.prepare()
    }
    
    // MARK: Default Theme
    
    func testLineDefaultTheme() {
        Appearance.shared.theme = .default
        let view = createLine()
        checkLine(view: view, named: "DefaultTheme", testName: "Line")
    }
    
    // MARK: Dark Theme
    
    func testLineDarkTheme() {
        Appearance.shared.theme = .dark
        let view = createLine()
        checkLine(view: view, named: "DarkTheme", testName: "Line")
    }
    
    func createLine() -> some View {
        let view = Line()
        return view
    }
    
}

private extension LineSnapshotTests {
    
    func checkLine<T: View>(view: T, named: String, testName: String, disabled: Bool = false) {
        let lineWrapper = LineWrapper(view: view)
        let view = UIHostingController(rootView: lineWrapper)
        let result = verifySnapshot(
            matching: view,
            as: .image,
            named: named,
            file: getFilePath(),
            testName: testName)
        XCTAssertNil(result)
    }
    
}
