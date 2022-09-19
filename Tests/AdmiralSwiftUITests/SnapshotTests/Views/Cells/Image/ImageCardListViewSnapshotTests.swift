//
//  ImageCardListViewSnapshotTests.swift
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

final class ImageCardListViewSnapshotTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        Appearance.prepare()
    }
    
    // MARK: Default Theme
    
    func testImageCardListViewDefaultTheme() {
        Appearance.shared.theme = .default
        let view = createImageCardListView()
        checkImageCardListView(view: view, named: "DefaultTheme", testName: "ImageCardListView")
    }
    
    // MARK: Dark Theme
    
    func testImageCardListViewDarkTheme() {
        Appearance.shared.theme = .default
        let view = createImageCardListView()
        checkImageCardListView(view: view, named: "DarkTheme", testName: "ImageCardListView")
    }
    
    func createImageCardListView() -> some View {
        let view = ImageCardListView (cardImage: Image(uiImage: Asset.Finance.Solid.cardSolid.image))
        return view
    }
    
}

private extension ImageCardListViewSnapshotTests {
    
    func checkImageCardListView<T: View>(view: T, named: String, testName: String, disabled: Bool = false) {
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
