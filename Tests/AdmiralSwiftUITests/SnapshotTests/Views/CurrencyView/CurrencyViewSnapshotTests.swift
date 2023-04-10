//
//  CurrencyViewSnapshotTests.swift
//  AdmiralSwiftUITests
//
//  Created on 15.11.2021.
//

import XCTest
import SwiftUI
import SnapshotTesting
import AdmiralCore
import AdmiralTheme
import AdmiralUIResources
@testable import AdmiralSwiftUI

private struct CurrencyViewWrapper<T: View>: View {
    
    // MARK: - Properties
    let view: T
    
    // MARK: - Layout
    var body: some View {
        view
            .frame(width: 300, height: 100)
    }
    
}

final class CurrencyViewSnapshotTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        Appearance.prepare()
    }
    
    // MARK: Default Theme
    
    func testCurrencyViewArrowUpDefaultTheme() {
        Appearance.shared.theme = .default
        let view = createCurrencyView(type: .arrowUp)
        checkCurrencyView(view: view, named: "ArrowUp.DefaultTheme", testName: "CurrencyView")
    }
    
    func testCurrencyViewArrowDownDefaultTheme() {
        Appearance.shared.theme = .default
        let view = createCurrencyView(type: .arrowUp)
        checkCurrencyView(view: view, named: "ArrowDown.DefaultTheme", testName: "CurrencyView")
    }
    
    // MARK: Dark Theme
    
    func testCurrencyViewArrowUpDarkTheme() {
        Appearance.shared.theme = .dark
        let view = createCurrencyView(type: .arrowUp)
        checkCurrencyView(view: view, named: "ArrowUp.DarkTheme", testName: "CurrencyView")
    }
    
    func testCurrencyViewArrowDownDarkTheme() {
        Appearance.shared.theme = .dark
        let view = createCurrencyView(type: .arrowUp)
        checkCurrencyView(view: view, named: "ArrowDown.DarkTheme", testName: "CurrencyView")
    }

    // MARK: - Scheme Provider

    func testSchemeProvider() {
        Appearance.shared.theme = .default
        var scheme = CurrencyViewScheme()
        scheme.textColor = AColor(color: .systemPink)
        scheme.imageTintColor = AColor(color: .systemPink)
        let newSchemeProvider = SchemeProvider<CurrencyViewScheme>(scheme: scheme)

        let view = createCurrencyView(schemeProvider: newSchemeProvider)
        checkCurrencyView(view: view, named: "SchemeProvider", testName: "CurrencyView")

        Appearance.shared.theme = .dark
        let newView = createCurrencyView(schemeProvider: newSchemeProvider)
        checkCurrencyView(view: newView, named: "SchemeProvider", testName: "CurrencyView")
    }
    
    func createCurrencyView(type: CurrencyCellType) -> some View {
        let view = CurrencyView(
            currencyText: "USD",
            buyText: "68,85",
            sellText: "69,45",
            image: nil,
            firstCellType: type,
            secondCellType: type
        )
        return view
    }

    func createCurrencyView(schemeProvider: SchemeProvider<CurrencyViewScheme>) -> some View {
        let view = CurrencyView(
            currencyText: "USD",
            buyText: "68,85",
            sellText: "69,45",
            image: nil,
            firstCellType: .arrowDown,
            secondCellType: .arrowUp,
            schemeProvider: schemeProvider
        )
        return view
    }
    
}

private extension CurrencyViewSnapshotTests {
    
    func checkCurrencyView<T: View>(view: T, named: String, testName: String, disabled: Bool = false) {
        let currencyViewWrapper = CurrencyViewWrapper(view: view)
        let view = UIHostingController(rootView: currencyViewWrapper)
        let result = verifySnapshot(
            matching: view,
            as: .image,
            named: named,
            file: getFilePath(),
            testName: testName)
        XCTAssertNil(result)
    }
    
}
