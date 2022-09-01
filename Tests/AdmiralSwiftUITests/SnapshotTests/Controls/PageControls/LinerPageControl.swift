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
        Appearance.shared.theme = .default
        let liner = LinerPageControll(currentPage: .constant(0), numberOfPages: 6)
        checkLinerPageControllControl(view: liner, named: "Liner", testName: "PageControll")
    }
    
    // MARK: - DarkTheme
    
    func testLinerDarkThemeControlAttention() {
        Appearance.shared.theme = .dark
        let liner = LinerPageControll(currentPage: .constant(0), numberOfPages: 6)
        checkLinerPageControllControl(view: liner, named: "LinerDarkTheme", testName: "PageControll")
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
