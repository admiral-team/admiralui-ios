//
//  ImageNameListViewSnapshotTests.swift
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

    // MARK: - Scheme Provider

    func testSchemeProvider() {
        Appearance.shared.theme = .default
        var scheme = ImageNameListViewScheme()
        scheme.backgroundNameViewColor.set(parameter: AColor(color: .systemPink), for: .normal)
        let newSchemeProvider = SchemeProvider<ImageNameListViewScheme>(scheme: scheme)

        let view = createImageNameListView(schemeProvider: newSchemeProvider)
        checkImageNameListView(view: view, named: "SchemeProvider", testName: "ImageNameListView")

        Appearance.shared.theme = .dark
        let newView = createImageNameListView(schemeProvider: newSchemeProvider)
        checkImageNameListView(view: newView, named: "SchemeProvider", testName: "ImageNameListView")
    }
    
    func createImageNameListView() -> some View {
        let view = ImageNameListView(text: "IN")
        return view
    }

    func createImageNameListView(schemeProvider: SchemeProvider<ImageNameListViewScheme>) -> some View {
        let view = ImageNameListView(
            text: "IN",
            schemeProvider: schemeProvider
        )
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
