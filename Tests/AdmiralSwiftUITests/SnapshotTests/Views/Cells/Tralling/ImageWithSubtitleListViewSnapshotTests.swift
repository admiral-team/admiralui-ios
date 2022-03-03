//
//  ImageWithSubtitleListViewSnapshotTests.swift
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

private struct ImageWithSubtitleListViewWrapper<T: View>: View {
    
    // MARK: - Properties
    let view: T
    
    // MARK: - Layout
    var body: some View {
        view
            .frame(width: 200, height: 50)
    }
    
}

final class ImageWithSubtitleListViewSnapshotTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        Appearance.prepare()
    }
    
    // MARK: Default Theme
    
    func testImageWithSubtitleListViewDefaultTheme() {
        SwiftUIThemeManager.shared.theme = .default
        let view = createImageWithSubtitleListView()
        checkImageWithSubtitleListView(view: view, named: "DefaultTheme", testName: "ImageWithSubtitleListView")
    }
    
    // MARK: Dark Theme
    
    func testImageWithSubtitleListViewDarkTheme() {
        SwiftUIThemeManager.shared.theme = .dark
        let view = createImageWithSubtitleListView()
        checkImageWithSubtitleListView(view: view, named: "DarkTheme", testName: "ImageWithSubtitleListView")
    }
    
    func createImageWithSubtitleListView() -> some View {
        let view = ImageWithSubtitleListView(subtitle: "Subtitle", image: Image(uiImage: Asset.Documents.Solid.accountDetailSolid.image)).padding()
        return view
    }
    
}

private extension ImageWithSubtitleListViewSnapshotTests {
    
    func checkImageWithSubtitleListView<T: View>(view: T, named: String, testName: String, disabled: Bool = false) {
        let imageWithSubtitleListViewWrapper = ImageWithSubtitleListViewWrapper(view: view)
        let view = UIHostingController(rootView: imageWithSubtitleListViewWrapper)
        let result = verifySnapshot(
            matching: view,
            as: .image,
            named: named,
            file: getFilePath(),
            testName: testName)
        XCTAssertNil(result)
    }
    
}
