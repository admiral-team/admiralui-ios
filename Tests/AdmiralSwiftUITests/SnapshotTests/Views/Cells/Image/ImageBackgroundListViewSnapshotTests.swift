//
//  ImageBackgroundListViewSnapshotTests.swift
//  AdmiralSwiftUITests
//
//  Created on 18.11.2021.
//

import XCTest
import SwiftUI
import SnapshotTesting
import AdmiralCore
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

    // MARK: - Scheme Provider

    func testSchemeProvider() {
        Appearance.shared.theme = .default
        var scheme = ImageBackgroundListViewScheme()
        scheme.backgroundImageViewColor.set(parameter: AColor(color: .systemPink), for: .normal)
        let newSchemeProvider = SchemeProvider<ImageBackgroundListViewScheme>(scheme: scheme)

        let view = createImageBackgroundListView(schemeProvider: newSchemeProvider)
        checkImageBackgroundListView(view: view, named: "SchemeProvider", testName: "ImageBackgroundListView")

        Appearance.shared.theme = .dark
        let newView = createImageBackgroundListView(schemeProvider: newSchemeProvider)
        checkImageBackgroundListView(view: newView, named: "SchemeProvider", testName: "ImageBackgroundListView")
    }
    
    func createImageBackgroundListView() -> some View {
        let view = ImageBackgroundListView(image: Image(uiImage: Asset.Finance.Solid.debitCardSolid.image))
        return view
    }

    func createImageBackgroundListView(schemeProvider: SchemeProvider<ImageBackgroundListViewScheme>) -> some View {
        let view = ImageBackgroundListView(
            image: Image(uiImage: Asset.Finance.Solid.debitCardSolid.image),
            schemeProvider: schemeProvider
        )
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
