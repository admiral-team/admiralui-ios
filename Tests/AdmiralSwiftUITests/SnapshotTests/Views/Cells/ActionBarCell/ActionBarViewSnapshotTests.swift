//
//  ActionBarViewSnapshotTests.swift
//  AdmiralSwiftUITests
//
//  Created on 19.11.2021.
//

import XCTest
import SwiftUI
import SnapshotTesting
import AdmiralTheme
import AdmiralImages
@testable import AdmiralSwiftUI

private struct ActionBarViewWrapper<T: View>: View {
    
    // MARK: - Properties

    let view: T

    let style: ActionBarViewStyle

    private var size: CGSize {
        style == .default ? CGSize(width: 180, height: 80) : CGSize(width: 90 * 3, height: (LayoutGrid.halfModule * 18))
    }

    // MARK: - Layout

    var body: some View {
        view
            .frame(width: size.width, height: size.height)
    }
    
}

final class ActionBarViewSnapshotTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        Appearance.prepare()
    }
    
    // MARK: Default Theme
    
    func testActionBarViewDefaultTheme() {
        Appearance.shared.theme = .default
        let view = createActionBarView()
        checkActionBarView(view: view, named: "DefaultTheme", testName: "ActionBarView")
    }
    
    // MARK: Dark Theme
    
    func testActionBarViewDarkTheme() {
        Appearance.shared.theme = .dark
        let view = createActionBarView()
        checkActionBarView(view: view, named: "DarkTheme", testName: "ActionBarView")
    }

    func testActionBarSecondaryDefaultTheme() {
        Appearance.shared.theme = .default
        let view = createActionBarViewSecondary()
        checkActionBarView(view: view, named: "DefaultTheme", testName: "ActionBarViewSecondary", style: .secondary)
    }

    func testActionBarSecondaryDarkTheme() {
        Appearance.shared.theme = .dark
        let view = createActionBarViewSecondary()
        checkActionBarView(view: view, named: "DarkTheme", testName: "ActionBarViewSecondary", style: .secondary)
    }

    // MARK: - Scheme Providers

    func testActionBarSchemeProvider() {
        Appearance.shared.theme = .default
        var scheme = ActionBarViewScheme(theme: .default)
        var actionBarConrolScheme = ActionBarControlScheme(theme: .default)
        actionBarConrolScheme.actionBarControl.imageTintColor.set(parameter: AColor(color: .systemPink), style: .accent)
        scheme.actionBarConrolScheme = actionBarConrolScheme
        let newSchemeProvider = SchemeProvider<ActionBarViewScheme>(scheme: scheme)

        let view = createActionBarView(schemeProvider: newSchemeProvider)
        checkActionBarView(view: view, named: "SchemeProvider", testName: "ActionBarView")

        Appearance.shared.theme = .dark
        let newView = createActionBarView(schemeProvider: newSchemeProvider)
        checkActionBarView(view: newView, named: "SchemeProvider", testName: "ActionBarView")
    }

    func testActionBarSchemeSecondaryProvider() {
        Appearance.shared.theme = .default
        var scheme = ActionBarViewScheme(theme: .default)
        var actionBarConrolScheme = ActionBarControlSchemeSecondary(theme: .default)
        actionBarConrolScheme.actionBarControl.backgroundColor.set(parameter: AColor(color: .systemPink), style: .accent, control: .normal)
        scheme.actionBarControlSchemeTwo = actionBarConrolScheme
        let newSchemeProvider = SchemeProvider<ActionBarViewScheme>(scheme: scheme)

        let view = createActionBarViewSecondary(schemeProvider: newSchemeProvider)
        checkActionBarView(view: view, named: "SchemeProvider", testName: "ActionBarViewSecondary", style: .secondary)

        Appearance.shared.theme = .dark
        let newView = createActionBarViewSecondary(schemeProvider: newSchemeProvider)
        checkActionBarView(view: newView, named: "SchemeProvider", testName: "ActionBarViewSecondary", style: .secondary)
    }


    func createActionBarViewSecondary() -> some View {
        let view = ActionBarView(actions: [
            ActionItemBarAction(
                image: Image(uiImage: Asset.Category.Outline.acceptOutline.image),
                imageStyle: .attention,
                style: .secondary,
                text: "Secondary",
                handler: {}
            ),
            ActionItemBarAction(
                image: Image(uiImage: Asset.Category.Outline.acceptOutline.image),
                imageStyle: .accent,
                style: .secondary,
                text: "Secondary",
                handler: {}
            ),
            ActionItemBarAction(
                image: Image(uiImage: Asset.Category.Outline.acceptOutline.image),
                imageStyle: .error,
                style: .secondary,
                text: "Secondary",
                handler: {}
            )
        ], style: .secondary)
        return view
    }

    func createActionBarView() -> some View {
        let view = ActionBarView(
            actions: [
                ActionItemBarAction(
                    image: Image(uiImage: Asset.Category.Outline.acceptOutline.image),
                    imageStyle: .accent,
                    handler: {}
                ),
                ActionItemBarAction(
                    image: Image(uiImage: Asset.Category.Outline.acceptOutline.image),
                    imageStyle: .accent,
                    handler: {}
                ),
                ActionItemBarAction(
                    image: Image(uiImage: Asset.Category.Outline.acceptOutline.image),
                    imageStyle: .accent,
                    handler: {}
                )
            ],
            style: .default
        )
        return view
    }

    func createActionBarView(schemeProvider: SchemeProvider<ActionBarViewScheme>) -> some View {
        let view = ActionBarView(
            actions: [
                ActionItemBarAction(
                    image: Image(uiImage: Asset.Category.Outline.acceptOutline.image),
                    imageStyle: .accent,
                    handler: {}
                ),
                ActionItemBarAction(
                    image: Image(uiImage: Asset.Category.Outline.acceptOutline.image),
                    imageStyle: .accent,
                    handler: {}
                ),
                ActionItemBarAction(
                    image: Image(uiImage: Asset.Category.Outline.acceptOutline.image),
                    imageStyle: .accent,
                    handler: {}
                )
            ],
            style: .default,
            schemeProvider: schemeProvider
        )
        return view
    }

    func createActionBarViewSecondary(schemeProvider: SchemeProvider<ActionBarViewScheme>) -> some View {
        let view = ActionBarView(
            actions: [
                ActionItemBarAction(
                    image: Image(uiImage: Asset.Category.Outline.acceptOutline.image),
                    imageStyle: .attention,
                    style: .secondary,
                    text: "Secondary",
                    handler: {}
                ),
                ActionItemBarAction(
                    image: Image(uiImage: Asset.Category.Outline.acceptOutline.image),
                    imageStyle: .accent,
                    style: .secondary,
                    text: "Secondary",
                    handler: {}
                ),
                ActionItemBarAction(
                    image: Image(uiImage: Asset.Category.Outline.acceptOutline.image),
                    imageStyle: .error,
                    style: .secondary,
                    text: "Secondary",
                    handler: {}
                )
            ],
            style: .secondary,
            schemeProvider: schemeProvider
        )
        return view
    }
    
}

private extension ActionBarViewSnapshotTests {
    
    func checkActionBarView<T: View>(
        view: T,
        named: String,
        testName: String,
        disabled: Bool = false,
        style: ActionBarViewStyle = .default
    ) {
        let actionBarViewWrapper = ActionBarViewWrapper(view: view, style: style)
        let view = UIHostingController(rootView: actionBarViewWrapper)
        let result = verifySnapshot(
            matching: view,
            as: .image,
            named: named,
            file: getFilePath(),
            testName: testName)
        XCTAssertNil(result)
    }
    
}
