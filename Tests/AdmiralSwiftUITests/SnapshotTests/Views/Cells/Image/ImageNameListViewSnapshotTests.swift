//
//  ImageNameListViewSnapshotTests.swift
//  AdmiralSwiftUITests
//
//  Created on 18.11.2021.
//

import XCTest
import SwiftUI
import SnapshotTesting
import AdmiralTheme
import AdmiralUIResources
@testable import AdmiralSwiftUI

final class ImageNameListViewSnapshotTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        Appearance.prepare()
    }
    
    // MARK: Default Theme
    
    func testImageNameListViewDefaultTheme() {
        Appearance.shared.theme = .default
        let view = createImageNameListView()
        checkImageNameListView(view: view, named: "DefaultTheme", testName: "ImageNameListView")
    }
    
    // MARK: Dark Theme
    
    func testImageNameListViewDarkTheme() {
        Appearance.shared.theme = .dark
        let view = createImageNameListView()
        checkImageNameListView(view: view, named: "ImageNameListViewDarkTheme", testName: "ImageNameListView")
    }
    
    func createImageNameListView() -> some View {
        let view = ImageNameListView(text: "IN")
        return view
    }
    
}

private extension ImageNameListViewSnapshotTests {
    
    func checkImageNameListView<T: View>(view: T, named: String, testName: String, disabled: Bool = false) {
        let view = UIHostingController(rootView: view)
        let result = verifySnapshot(
            matching: view,
            as: .image,
            named: named,
            file: getFilePath(),
            testName: testName)
        XCTAssertNil(result)
    }
    
}
