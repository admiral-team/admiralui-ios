//
//  FeedbackInputControlSnapshotTests.swift
//  AdmiralSwiftUITests
//
//  Created on 16.11.2021.
//

import XCTest
import SwiftUI
import SnapshotTesting
import AdmiralCore
import AdmiralTheme
import AdmiralUIResources
@testable import AdmiralSwiftUI

final class FeedbackInputControlSnapshotTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        Appearance.prepare()
    }
    
    // MARK: Default Theme
    
    func testFeedbackInputControlDefaultTheme() {
        Appearance.shared.theme = .default
        let view = createFeedbackInputControl()
        checkFeedbackInputControl(view: view, named: "DefaultTheme", testName: "FeedbackInputControl")
    }
    
    // MARK: Dark Theme
    
    func testFeedbackInputControlDarkTheme() {
        Appearance.shared.theme = .dark
        let view = createFeedbackInputControl()
        checkFeedbackInputControl(view: view, named: "DarkTheme", testName: "FeedbackInputControl")
    }

    // MARK: - Scheme Provider

    func testSchemeProvider() {
        Appearance.shared.theme = .default
        var scheme = FeedbackInputControlScheme()
        scheme.selectedColor.set(parameter: AColor(color: .systemPink), for: .normal)
        let newSchemeProvider = SchemeProvider<FeedbackInputControlScheme>(scheme: scheme)

        let view = createFeedbackInputControl(schemeProvider: newSchemeProvider)
        checkFeedbackInputControl(view: view, named: "SchemeProvider", testName: "FeedbackInputControl")

        Appearance.shared.theme = .dark
        let newView = createFeedbackInputControl(schemeProvider: newSchemeProvider)
        checkFeedbackInputControl(view: newView, named: "SchemeProvider", testName: "FeedbackInputControl")
    }
    
    func createFeedbackInputControl() -> some View {
        let view = FeedbackInputControl(
            cursorPosition: .constant(100),
            itemsCount: 10)
            .frame(width: 200, height: 100, alignment: .bottom)
        return view
    }

    func createFeedbackInputControl(schemeProvider: SchemeProvider<FeedbackInputControlScheme>) -> some View {
        let view = FeedbackInputControl(
            cursorPosition: .constant(100),
            itemsCount: 10,
            schemeProvider: schemeProvider
        ).frame(width: 200, height: 100, alignment: .bottom)
        return view
    }
    
}

private extension FeedbackInputControlSnapshotTests {
    
    func checkFeedbackInputControl<T: View>(view: T, named: String, testName: String, disabled: Bool = false) {
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
