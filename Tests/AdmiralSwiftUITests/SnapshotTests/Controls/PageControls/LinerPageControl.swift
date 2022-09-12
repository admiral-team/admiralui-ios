//
//  LinerPageControl.swift
//  AdmiralUI
//
//  Created on 02.06.2022.
//

import XCTest
import SwiftUI
import SnapshotTesting
import AdmiralTheme
import AdmiralUIResources
@testable import AdmiralSwiftUI

final class LinerPageControlSnapshotTests: XCTestCase {

    override func setUp() {
        super.setUp()
        Appearance.prepare()
    }
    
    // MARK: Default Theme
    
    func testLinerControlAttention() {
        SwiftUIThemeManager.shared.theme = .default
        let liner = LinerPageControll(currentPage: .constant(0), numberOfPages: 6)
        checkLinerPageControllControl(view: liner, named: "Liner", testName: "PageControll")
    }
    
    // MARK: - DarkTheme
    
    func testLinerDarkThemeControlAttention() {
        SwiftUIThemeManager.shared.theme = .dark
        let liner = LinerPageControll(currentPage: .constant(0), numberOfPages: 6)
        checkLinerPageControllControl(view: liner, named: "LinerDarkTheme", testName: "PageControll")
    }

    func testLinerSchemeManualProvider() {
        SwiftUIThemeManager.shared.theme = .default
        var pageControlViewScheme = PageControlViewScheme()
        pageControlViewScheme.backgroundColor.set(parameter: AColor(color: .systemPink), for: .normal)
        pageControlViewScheme.backgroundColor.set(parameter: AColor(color: .red), for: .selected)
        let newSchemeProvider = ManualSchemeProvider<PageControlViewScheme>(scheme: pageControlViewScheme)

        var liner = LinerPageControll(currentPage: .constant(0), numberOfPages: 6, schemeProvider: newSchemeProvider)
        checkLinerPageControllControl(view: liner, named: "LinerNewProvider", testName: "PageControll")

        SwiftUIThemeManager.shared.theme = .dark
        var newLiner = LinerPageControll(currentPage: .constant(0), numberOfPages: 6, schemeProvider: newSchemeProvider)
        checkLinerPageControllControl(view: newLiner, named: "LinerNewProvider", testName: "PageControll")

        SwiftUIThemeManager.shared.theme = .default

        var newPageControlViewScheme = PageControlViewScheme()
        newPageControlViewScheme.backgroundColor.set(parameter: AColor(color: .black), for: .normal)
        newPageControlViewScheme.backgroundColor.set(parameter: AColor(color: .darkGray), for: .selected)
        newSchemeProvider.update(scheme: newPageControlViewScheme)

        liner = LinerPageControll(currentPage: .constant(0), numberOfPages: 6, schemeProvider: newSchemeProvider)
        checkLinerPageControllControl(view: liner, named: "LinerNewSchemeProvider", testName: "PageControll")

        SwiftUIThemeManager.shared.theme = .dark
        newLiner = LinerPageControll(currentPage: .constant(0), numberOfPages: 6, schemeProvider: newSchemeProvider)
        checkLinerPageControllControl(view: newLiner, named: "LinerNewSchemeProvider", testName: "PageControll")
    }

}

private extension LinerPageControlSnapshotTests {

    func checkLinerPageControllControl<T: View>(view: T, named: String, testName: String, disabled: Bool = false) {
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
