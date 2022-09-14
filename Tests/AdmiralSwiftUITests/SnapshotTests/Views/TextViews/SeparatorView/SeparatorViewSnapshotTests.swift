//
//  SeparatorViewSnapshotTests.swift
//  AdmiralSwiftUITests
//
//  Created on 12.11.2021.
//

import XCTest
import SwiftUI
import SnapshotTesting
import AdmiralTheme
import AdmiralUIResources
@testable import AdmiralSwiftUI

private struct SeparatorViewWrapper<T: View>: View {
    
    // MARK: - Properties
    let view: T
    
    // MARK: - Layout
    var body: some View {
        view
            .frame(width: 300, height: 30)
    }
    
}

final class SeparatorViewSnapshotTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        Appearance.prepare()
    }
    
    // MARK: Default Theme
    
    func testSeparatorViewEmptyStyleDefaultTheme() {
        Appearance.shared.theme = .default
        let view = createSeparatorView(style: .empty)
        checkSeparatorView(view: view, named: "EmptyStyle.DefaultTheme", testName: "SeparatorView")
    }
    
    func testSeparatorViewLongStyleDefaultTheme() {
        Appearance.shared.theme = .default
        let view = createSeparatorView(style: .long)
        checkSeparatorView(view: view, named: "LongStyle.DefaultTheme", testName: "SeparatorView")
    }
    
    func testSeparatorViewShortStyleDefaultTheme() {
        Appearance.shared.theme = .default
        let view = createSeparatorView(style: .short)
        checkSeparatorView(view: view, named: "ShortStyle.DefaultTheme", testName: "SeparatorView")
    }
    
    // MARK: Dark Theme
    
    func testSeparatorViewEmptyStyleDarkTheme() {
        Appearance.shared.theme = .dark
        let view = createSeparatorView(style: .empty)
        checkSeparatorView(view: view, named: "EmptyStyle.DarkTheme", testName: "SeparatorView")
    }
    
    func testSeparatorViewLongStyleDarkTheme() {
        Appearance.shared.theme = .dark
        let view = createSeparatorView(style: .long)
        checkSeparatorView(view: view, named: "LongStyle.DarkTheme", testName: "SeparatorView")
    }
    
    func testSeparatorViewShortStyleDarkTheme() {
        Appearance.shared.theme = .dark
        let view = createSeparatorView(style: .short)
        checkSeparatorView(view: view, named: "ShortStyle.DarkTheme", testName: "SeparatorView")
    }
    
    func createSeparatorView(style: SeparatorStyle) -> some View {
        let view = SeparatorView(paddingStyle: style)
        return view
    }
    
}

private extension SeparatorViewSnapshotTests {
    
    func checkSeparatorView<T: View>(view: T, named: String, testName: String, disabled: Bool = false) {
        let separatorViewWrapper = SeparatorViewWrapper(view: view)
        let view = UIHostingController(rootView: separatorViewWrapper)
        let result = verifySnapshot(
            matching: view,
            as: .image,
            named: named,
            file: getFilePath(),
            testName: testName)
        XCTAssertNil(result)
    }
    
}
