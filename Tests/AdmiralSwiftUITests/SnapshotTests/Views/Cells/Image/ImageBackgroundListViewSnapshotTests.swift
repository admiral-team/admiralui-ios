//
//  ImageBackgroundListViewSnapshotTests.swift
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

final class ImageBackgroundListViewSnapshotTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        Appearance.prepare()
    }
    
    // MARK: Default Theme
    
    func testImageBackgroundListViewDefaultTheme() {
        Appearance.shared.theme = .default
        let view = createImageBackgroundListView()
        checkImageBackgroundListView(view: view, named: "DefaultTheme", testName: "ImageBackgroundListView")
    }
    
    // MARK: Dark Theme

    func testImageBackgroundListViewDarkTheme() {
        Appearance.shared.theme = .dark
        let view = createImageBackgroundListView()
        checkImageBackgroundListView(view: view, named: "DarkTheme", testName: "ImageBackgroundListView")
    }
    
    func createImageBackgroundListView() -> some View {
        let view = ImageBackgroundListView(image: Image(uiImage: Asset.Finance.Solid.debitCardSolid.image))
        return view
    }
    
}

private extension ImageBackgroundListViewSnapshotTests {
    
    func checkImageBackgroundListView<T: View>(view: T, named: String, testName: String, disabled: Bool = false) {
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
