//
//  SubtitleWithImageListViewSnapshotTests.swift
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

private struct SubtitleWithImageListViewWrapper<T: View>: View {
    
    // MARK: - Properties
    let view: T
    
    // MARK: - Layout
    var body: some View {
        view
            .frame(width: 200, height: 50)
    }
    
}

final class SubtitleWithImageListViewSnapshotTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        Appearance.prepare()
    }
    
    // MARK: Default Theme
    
    func testSubtitleWithImageListViewDefaultTheme() {
        Appearance.shared.theme = .default
        let view = createSubtitleWithImageListView()
        checkSubtitleWithImageListView(view: view, named: "DefaultTheme", testName: "SubtitleWithImageListView")
    }
    
    // MARK: Dark Theme
    
    func testSubtitleWithImageListViewDarkTheme() {
        Appearance.shared.theme = .dark
        let view = createSubtitleWithImageListView()
        checkSubtitleWithImageListView(view: view, named: "DarkTheme", testName: "SubtitleWithImageListView")
    }
    
    func createSubtitleWithImageListView() -> some View {
        let view = SubtitleWithImageListView(subtitle: "Subtitle", image: Image(uiImage: Asset.Finance.Solid.debitCardSolid.image))
        return view
    }
    
}

private extension SubtitleWithImageListViewSnapshotTests {
    
    func checkSubtitleWithImageListView<T: View>(view: T, named: String, testName: String, disabled: Bool = false) {
        let subtitleWithImageListViewWrapper = SubtitleWithImageListViewWrapper(view: view)
        let view = UIHostingController(rootView: subtitleWithImageListViewWrapper)
        let result = verifySnapshot(
            matching: view,
            as: .image,
            named: named,
            file: getFilePath(),
            testName: testName)
        XCTAssertNil(result)
    }
    
}
