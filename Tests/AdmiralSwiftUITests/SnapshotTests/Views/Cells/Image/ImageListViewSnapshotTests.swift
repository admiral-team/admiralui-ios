//
//  ImageListViewSnapshotTests.swift
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

final class ImageListViewSnapshotTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        Appearance.prepare()
    }
    
    // MARK: Default Theme
    
    func testImageListViewDefaultTheme() {
        SwiftUIThemeManager.shared.theme = .default
        let view = createImageListView()
        checkImageListView(view: view, named: "DefaultTheme", testName: "ImageListView")
    }
    
    // MARK: Dark Theme
    
    func testImageListViewDarkTheme() {
        SwiftUIThemeManager.shared.theme = .dark
        let view = createImageListView()
        checkImageListView(view: view, named: "DarkTheme", testName: "ImageListView")
    }
    
    func createImageListView() -> some View {
        let view = ImageListView (image: Image(uiImage: Asset.Finance.Solid.cardSolid.image))
        return view
    }
    
}

private extension ImageListViewSnapshotTests {
    
    func checkImageListView<T: View>(view: T, named: String, testName: String, disabled: Bool = false) {
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
