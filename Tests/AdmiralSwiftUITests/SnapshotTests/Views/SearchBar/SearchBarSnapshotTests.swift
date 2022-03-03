//
//  SearchBarSnapshotTests.swift
//  AdmiralSwiftUITests
//
//  Created on 15.11.2021.
//

import XCTest
import SwiftUI
import SnapshotTesting
import AdmiralTheme
import AdmiralUIResources
@testable import AdmiralSwiftUI

private struct SearchBarWrapper<T: View>: View {
    
    // MARK: - Properties
    let view: T
    
    // MARK: - Layout
    var body: some View {
        view
            .frame(width: 500, height: 80)
    }
    
}

final class SearchBarSnapshotTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        Appearance.prepare()
    }
    
    // MARK: Default Theme
    
    func testSearchBarDefaultTheme() {
        SwiftUIThemeManager.shared.theme = .default
        let view = createSearchBar()
        checkSearchBar(view: view, named: "DefaultTheme", testName: "SearchBar")
    }
    
    // MARK: Dark Theme
    
    func testSearchBarDarkTheme() {
        SwiftUIThemeManager.shared.theme = .dark
        let view = createSearchBar()
        checkSearchBar(view: view, named: "DarkTheme", testName: "SearchBar")
    }
    
    func createSearchBar() -> some View {
        let view = SearchBar(.constant("SearchBar"), placeholder: "Placeholder")
        return view
    }
    
}

private extension SearchBarSnapshotTests {
    
    func checkSearchBar<T: View>(view: T, named: String, testName: String, disabled: Bool = false) {
        let searchBarWrapper = SearchBarWrapper(view: view)
        let view = UIHostingController(rootView: searchBarWrapper)
        let result = verifySnapshot(
            matching: view,
            as: .image,
            named: named,
            file: getFilePath(),
            testName: testName)
        XCTAssertNil(result)
    }
    
}
