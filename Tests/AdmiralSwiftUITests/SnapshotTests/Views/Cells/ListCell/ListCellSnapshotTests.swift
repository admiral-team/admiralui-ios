//
//  ListCellSnapshotTests.swift
//  AdmiralSwiftUITests
//
//  Created on 19.11.2021.
//

import XCTest
import SwiftUI
import SnapshotTesting
import AdmiralTheme
import AdmiralUIResources
@testable import AdmiralSwiftUI

private struct ListCellWrapper<T: View>: View {
    
    // MARK: - Properties
    let view: T
    
    // MARK: - Layout
    var body: some View {
        view
            .frame(width: 300, height: 100)
    }
    
}

final class ListCellSnapshotTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        Appearance.prepare()
    }
    
    // MARK: Default Theme
    
    func testListCellDefaultTheme() {
        SwiftUIThemeManager.shared.theme = .default
        let view = createListCell()
        checkListCell(view: view, named: "ListCellDefaultTheme", testName: "ListCell")
    }
    
    // MARK: Dark Theme
    
    func testListCellDarkTheme() {
        SwiftUIThemeManager.shared.theme = .dark
        let view = createListCell()
        checkListCell(view: view, named: "ListCellDarkTheme", testName: "ListCell")
    }
    
    func createListCell() -> some View {
        let view = ListCell(
            leadingView: { ImageCardListView(cardImage: Image(uiImage: Asset.Finance.Solid.cashSolid.image)) },
            centerView: { TitleListView(title: "Title") },
            trailingView: { DatePercentListView(date: "Date", percent: "Text") },
            isSelected: .constant(true))
        return view
    }
    
}

private extension ListCellSnapshotTests {
    
    func checkListCell<T: View>(view: T, named: String, testName: String, disabled: Bool = false) {
        let listCellWrapper = ListCellWrapper(view: view)
        let view = UIHostingController(rootView: listCellWrapper)
        let result = verifySnapshot(
            matching: view,
            as: .image,
            named: named,
            file: getFilePath(),
            testName: testName)
        XCTAssertNil(result)
    }
    
}
