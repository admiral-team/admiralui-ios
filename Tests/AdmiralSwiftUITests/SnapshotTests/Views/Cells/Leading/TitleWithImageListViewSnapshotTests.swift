//
//  TitleWithImageListViewSnapshotTests.swift
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

private struct TitleWithImageListViewWrapper<T: View>: View {
    
    // MARK: - Properties
    let view: T
    
    // MARK: - Layout
    var body: some View {
        view
            .frame(width: 300, height: 100)
    }
    
}

final class TitleWithImageListViewSnapshotTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        Appearance.prepare()
    }
    
    // MARK: Default Theme
    
    func testTitleWithImageListViewDefaultTheme() {
        Appearance.shared.theme = .default
        let view = createTitleWithImageListView()
        checkTitleWithImageListView(view: view, named: "DefaultTheme", testName: "TitleWithImageListView")
    }
    
    // MARK: Dark Theme
    
    func testTitleWithImageListViewDarkTheme() {
        Appearance.shared.theme = .dark
        let view = createTitleWithImageListView()
        checkTitleWithImageListView(view: view, named: "DarkTheme", testName: "TitleWithImageListView")
    }
    
    func createTitleWithImageListView() -> some View {
        let view = TitleWithImageListView(
            title: "Курсы валют",
            image: Image(uiImage: Asset.Service.Solid.dragSolid.image))
        return view
    }
    
}

private extension TitleWithImageListViewSnapshotTests {
    
    func checkTitleWithImageListView<T: View>(view: T, named: String, testName: String, disabled: Bool = false) {
        let titleWithImageListViewWrapper = TitleWithImageListViewWrapper(view: view)
        let view = UIHostingController(rootView: titleWithImageListViewWrapper)
        let result = verifySnapshot(
            matching: view,
            as: .image,
            named: named,
            file: getFilePath(),
            testName: testName)
        XCTAssertNil(result)
    }
    
}
