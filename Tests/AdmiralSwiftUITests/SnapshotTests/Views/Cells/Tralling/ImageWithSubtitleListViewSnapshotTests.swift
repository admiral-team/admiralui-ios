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
        Appearance.shared.theme = .default
        let view = createImageWithSubtitleListView()
        checkImageWithSubtitleListView(view: view, named: "DefaultTheme", testName: "ImageWithSubtitleListView")
    }
    
    // MARK: Dark Theme
    
    func testImageWithSubtitleListViewDarkTheme() {
        Appearance.shared.theme = .dark
        let view = createImageWithSubtitleListView()
        checkImageWithSubtitleListView(view: view, named: "DarkTheme", testName: "ImageWithSubtitleListView")
    }

    // MARK: - Scheme Provider

    func testSchemeProvider() {
        Appearance.shared.theme = .default
        var scheme = ImageWithSubtitleListViewScheme(theme: .default)
        scheme.imageTintColor.set(parameter: AColor(color: .systemPink), for: .normal)
        scheme.subtitleLabelTextColor.set(parameter: AColor(color: .systemPink), for: .normal)
        let newSchemeProvider = SchemeProvider<ImageWithSubtitleListViewScheme>(scheme: scheme)

        let view = createImageWithSubtitleListView(schemeProvider: newSchemeProvider)
        checkImageWithSubtitleListView(view: view, named: "SchemeProvider", testName: "ImageWithSubtitleListView")

        Appearance.shared.theme = .dark
        let newView = createImageWithSubtitleListView(schemeProvider: newSchemeProvider)
        checkImageWithSubtitleListView(view: newView, named: "SchemeProvider", testName: "ImageWithSubtitleListView")
    }
    
    func createImageWithSubtitleListView() -> some View {
        let view = ImageWithSubtitleListView(subtitle: "Subtitle", image: Image(uiImage: Asset.Documents.Solid.accountDetailSolid.image)).padding()
        return view
    }

    func createImageWithSubtitleListView(schemeProvider: SchemeProvider<ImageWithSubtitleListViewScheme>) -> some View {
        let view = ImageWithSubtitleListView(
            subtitle: "Subtitle",
            image: Image(uiImage: Asset.Documents.Solid.accountDetailSolid.image),
            renderingMode: .template,
            schemeProvider: schemeProvider
        ).padding()
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
