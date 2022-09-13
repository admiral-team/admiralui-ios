//
//  ActionBarControlViewSnapshotTests.swift
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

private struct ActionBarControlViewWrapper<T: View>: View {
    
    // MARK: - Properties
    let view: T
    
    // MARK: - Layout
    var body: some View {
        view
            .frame(width: 50, height: 50)
    }
    
}

final class ActionBarControlViewSnapshotTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        Appearance.prepare()
    }
    
    // MARK: Default Theme
    
    func testActionBarControlViewDefaultTheme() {
        SwiftUIThemeManager.shared.theme = .default
        let view = createActionBarControlView()
        checkActionBarControlView(view: view, named: "DefaultTheme", testName: "ActionBarControlView")
    }
    
    // MARK: Dark Theme
    
    func testActionBarControlViewDarkTheme() {
        SwiftUIThemeManager.shared.theme = .dark
        let view = createActionBarControlView()
        checkActionBarControlView(view: view, named: "DarkTheme", testName: "ActionBarControlView")
    }

    
    func createActionBarControlView() -> some View {
        let view = ActionBarControlView(
            image: Image(uiImage: Asset.Category.Outline.addCommentOutline.image),
            imageStyle: .accent,
            schemeProvider: .constant(scheme: ActionBarControlScheme(theme: SwiftUIThemeManager.shared.theme)),
            tapActionBar: {}
        )
        return view
    }
    
}

private extension ActionBarControlViewSnapshotTests {
    
    func checkActionBarControlView<T: View>(view: T, named: String, testName: String, disabled: Bool = false) {
        let actionBarControlViewWrapper = ActionBarControlViewWrapper(view: view)
        let view = UIHostingController(rootView: actionBarControlViewWrapper)
        let result = verifySnapshot(
            matching: view,
            as: .image,
            named: named,
            file: getFilePath(),
            testName: testName)
        XCTAssertNil(result)
    }
    
}
