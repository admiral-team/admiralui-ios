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
import AdmiralImages
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

    // MARK: - Scheme Provider

    func testSchemeProvider() {
        Appearance.shared.theme = .default
        var scheme = LeadingCardListViewScheme()
        scheme.imageTintColor.set(parameter: AColor(color: .systemPink), for: .normal)
        let newSchemeProvider = SchemeProvider<LeadingCardListViewScheme>(scheme: scheme)

        let view = createImageCardListView(schemeProvider: newSchemeProvider)
        checkImageCardListView(view: view, named: "SchemeProvider", testName: "ImageCardListView")

        Appearance.shared.theme = .dark
        let newView = createImageCardListView(schemeProvider: newSchemeProvider)
        checkImageCardListView(view: newView, named: "SchemeProvider", testName: "ImageCardListView")
    }
    
    func createImageCardListView() -> some View {
        let view = LeadingCardListView (cardImage: Image(uiImage: AdmiralImages.Asset.Finance.Solid.cardSolid.image))
        return view
    }

    func createImageCardListView(schemeProvider: SchemeProvider<LeadingCardListViewScheme>) -> some View {
        let view = LeadingCardListView(
            cardImage: Image(uiImage: AdmiralImages.Asset.Finance.Solid.cardSolid.image),
            renderingMode: .template,
            schemeProvider: schemeProvider
        )
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
