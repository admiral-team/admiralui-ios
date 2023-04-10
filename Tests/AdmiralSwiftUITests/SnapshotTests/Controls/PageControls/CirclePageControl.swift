//
//  CirclePageControl.swift
//  AdmiralSwiftUITests
//
//  Created on 02.06.2022.
//

import XCTest
import SwiftUI
import SnapshotTesting
import AdmiralCore
import AdmiralTheme
import AdmiralUIResources
@testable import AdmiralSwiftUI

final class CirclePageControlSnapshotTests: XCTestCase {

    override func setUp() {
        super.setUp()
        Appearance.prepare()
    }
    
    // MARK: Default Theme
    
    func testLinerControlAttention() {
        Appearance.shared.theme = .default
        let liner = Button(action: {}, label: {})
            .buttonStyle(CirclePageControlStyle(step: .constant(0), totalPages: 7, style: .default))
        checkCirclePageControllControl(view: liner, named: "Circle", testName: "PageControll")
    }
    
    // MARK: - DarkTheme
    
    func testLinerDarkThemeControlAttention() {
        Appearance.shared.theme = .dark
        let liner = Button(action: {}, label: {})
            .buttonStyle(CirclePageControlStyle(step: .constant(0), totalPages: 7, style: .default))
        checkCirclePageControllControl(view: liner, named: "CircleDarkTheme", testName: "PageControll")
    }

    func testLinerSchemeProvider() {
        Appearance.shared.theme = .default
        var circleScheme = CirclePageControlScheme()
        circleScheme.backgroundColor.set(parameter: AColor(color: .systemPink), for: false, style: .default)
        circleScheme.backgroundColor.set(parameter: AColor(color: .systemPink), for: true, style: .default)
        let newSchemeProvider: SchemeProvider<CirclePageControlScheme> = SchemeProvider<CirclePageControlScheme>(scheme: circleScheme)

        let liner = Button(action: {}, label: {})
            .buttonStyle(CirclePageControlStyle(step: .constant(0), totalPages: 7, style: .default, schemeProvider: newSchemeProvider))
        checkCirclePageControllControl(view: liner, named: "CircleNewSchemeProvider", testName: "PageControll")

        Appearance.shared.theme = .dark
        let newLiner = Button(action: {}, label: {})
            .buttonStyle(CirclePageControlStyle(step: .constant(0), totalPages: 7, style: .default, schemeProvider: newSchemeProvider))
        checkCirclePageControllControl(view: newLiner, named: "CircleNewSchemeProvider", testName: "PageControll")
    }

}

private extension CirclePageControlSnapshotTests {

    func checkCirclePageControllControl<T: View>(view: T, named: String, testName: String, disabled: Bool = false) {
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
