//
//  ParagraphViewSnapshotTests.swift
//  AdmiralSwiftUITests
//
//  Created on 12.11.2021.
//

import XCTest
import SwiftUI
import SnapshotTesting
import AdmiralTheme
import AdmiralImages
@testable import AdmiralSwiftUI

private struct ParagraphViewWrapper<T: View>: View {
    
    // MARK: - Properties
    let view: T
    
    // MARK: - Layout
    var body: some View {
        view
            .frame(width: 200, height: 50)
    }
    
}

final class ParagraphViewSnapshotTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        Appearance.prepare()
    }
    
    // MARK: Default Theme
    
    func test_DefaultTheme() {
        Appearance.shared.theme = .default
        let view = createParagraphView()
        checkParagraphView(view: view, named: "DefaultTheme", testName: "ParagraphView")
    }
    
    // MARK: Dark Theme
    
    func test_DarkTheme() {
        Appearance.shared.theme = .default
        let view = createParagraphView()
        checkParagraphView(view: view, named: "DarkTheme", testName: "ParagraphView")
    }
    
    func createParagraphView() -> some View {
        let view = ParagraphView(title: "ParagraphView", trailingImage: Image(uiImage: AdmiralImages.Asset.Documents.Solid.accountDetailSolid.image))
        return view
    }
    
}

private extension ParagraphViewSnapshotTests {
    
    func checkParagraphView<T: View>(view: T, named: String, testName: String, disabled: Bool = false) {
        let paragraphViewWrapper = ParagraphViewWrapper(view: view)
        let view = UIHostingController(rootView: paragraphViewWrapper)
        let result = verifySnapshot(
            matching: view,
            as: .image,
            named: named,
            file: getFilePath(),
            testName: testName)
        XCTAssertNil(result)
    }
    
}
