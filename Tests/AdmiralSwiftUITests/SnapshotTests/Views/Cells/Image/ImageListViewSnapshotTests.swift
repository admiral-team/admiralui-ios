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
import AdmiralImages
@testable import AdmiralSwiftUI

final class ImageListViewSnapshotTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        Appearance.prepare()
    }
    
    // MARK: Default Theme
    
    func testImageListViewDefaultTheme() {
        Appearance.shared.theme = .default
        let view = createImageListView()
        checkImageListView(view: view, named: "DefaultTheme", testName: "ImageListView")
    }
    
    // MARK: Dark Theme
    
    func testImageListViewDarkTheme() {
        Appearance.shared.theme = .dark
        let view = createImageListView()
        checkImageListView(view: view, named: "DarkTheme", testName: "ImageListView")
    }

    // MARK: - Scheme Provider

    func testSchemeProvider() {
        Appearance.shared.theme = .default
        var scheme = ImageListViewScheme()
        scheme.imageTintColor.set(parameter: AColor(color: .systemPink), for: .normal, style: .primary)
        let newSchemeProvider = SchemeProvider<ImageListViewScheme>(scheme: scheme)

        let view = createImageListView(schemeProvider: newSchemeProvider)
        checkImageListView(view: view, named: "SchemeProvider", testName: "ImageListView")

        Appearance.shared.theme = .dark
        let newView = createImageListView(schemeProvider: newSchemeProvider)
        checkImageListView(view: newView, named: "SchemeProvider", testName: "ImageListView")
    }
    
    func createImageListView() -> some View {
        let view = ImageListView (image: Image(uiImage: AdmiralImages.Asset.Finance.Solid.cardSolid.image))
        return view
    }

    func createImageListView(schemeProvider: SchemeProvider<ImageListViewScheme>) -> some View {
        let view = ImageListView(
            image: Image(uiImage: AdmiralImages.Asset.Finance.Solid.cardSolid.image),
            renderingMode: .template,
            schemeProvider: schemeProvider
        )
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
