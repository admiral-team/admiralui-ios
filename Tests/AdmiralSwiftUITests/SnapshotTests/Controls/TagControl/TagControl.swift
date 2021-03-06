//
//  TagControl.swift
//  AdmiralUIResources
//
//  Created on 26.10.2021.
//

import XCTest
import SwiftUI
import SnapshotTesting
import AdmiralTheme
import AdmiralUIResources
@testable import AdmiralSwiftUI

final class TagControlSnapshotTests: XCTestCase {

    override func setUp() {
        super.setUp()
        Appearance.prepare()
    }
    
    // MARK: Default Theme
    
    func testTagControlAttention() {
        SwiftUIThemeManager.shared.theme = .default
        let tagControl = TagControl(title: "Title",
                                    tagStyle: .attention,
                                    leadingView: { Button(action: {}, label: {
            Image(uiImage: Asset.Category.Outline.bankOutline.image)
        }) },
                                    trailingView: {
            Button(action: {}, label: {
                Image(uiImage: Asset.Category.Outline.bankOutline.image)
            }) }) {

            }
        checkTagControl(view: tagControl, named: "Attention", testName: "TagControl")
    }

    func testTagControlSuccess() {
        SwiftUIThemeManager.shared.theme = .default
        let tagControl = TagControl(title: "Title",
                                    tagStyle: .success,
                                    leadingView: { Button(action: {}, label: {
            Image(uiImage: Asset.Category.Outline.bankOutline.image)
        }) },
                                    trailingView: {
            Button(action: {}, label: {
                Image(uiImage: Asset.Category.Outline.bankOutline.image)
            }) }) {

            }
        checkTagControl(view: tagControl, named: "Success", testName: "TagControl")
    }

    func testTagControlAdditional() {
        SwiftUIThemeManager.shared.theme = .default
        let tagControl = TagControl(title: "Title",
                                    tagStyle: .additional,
                                    leadingView: { Button(action: {}, label: {
            Image(uiImage: Asset.Category.Outline.bankOutline.image)
        }) },
                                    trailingView: {
            Button(action: {}, label: {
                Image(uiImage: Asset.Category.Outline.bankOutline.image)
            }) }) {

            }
        checkTagControl(view: tagControl, named: "Additional", testName: "TagControl")
    }


    func testTagControlDefault() {
        SwiftUIThemeManager.shared.theme = .default
        let tagControl = TagControl(title: "Title",
                                    tagStyle: .default,
                                    leadingView: { Button(action: {}, label: {
            Image(uiImage: Asset.Category.Outline.bankOutline.image)
        }) },
                                    trailingView: {
            Button(action: {}, label: {
                Image(uiImage: Asset.Category.Outline.bankOutline.image)
            }) }) {

            }
        checkTagControl(view: tagControl, named: "default", testName: "TagControl")
    }
    
    // MARK: - DarkTheme
    
    func testTagControlAttentionDarkTheme() {
        SwiftUIThemeManager.shared.theme = .dark
        let tagControl = TagControl(title: "Title",
                                    tagStyle: .attention,
                                    leadingView: { Button(action: {}, label: {
            Image(uiImage: Asset.Category.Outline.bankOutline.image)
        }) },
                                    trailingView: {
            Button(action: {}, label: {
                Image(uiImage: Asset.Category.Outline.bankOutline.image)
            }) }) {

            }
        checkTagControl(view: tagControl, named: "AttentionDarkTheme", testName: "TagControl")
    }

    func testTagControlSuccessDarkTheme() {
        SwiftUIThemeManager.shared.theme = .dark
        let tagControl = TagControl(title: "Title",
                                    tagStyle: .success,
                                    leadingView: { Button(action: {}, label: {
            Image(uiImage: Asset.Category.Outline.bankOutline.image)
        }) },
                                    trailingView: {
            Button(action: {}, label: {
                Image(uiImage: Asset.Category.Outline.bankOutline.image)
            }) }) {

            }
        checkTagControl(view: tagControl, named: "SuccessDarkTheme", testName: "TagControl")
    }

    func testTagControlAdditionalDarkTheme() {
        SwiftUIThemeManager.shared.theme = .dark
        let tagControl = TagControl(title: "Title",
                                    tagStyle: .additional,
                                    leadingView: { Button(action: {}, label: {
            Image(uiImage: Asset.Category.Outline.bankOutline.image)
        }) },
                                    trailingView: {
            Button(action: {}, label: {
                Image(uiImage: Asset.Category.Outline.bankOutline.image)
            }) }) {

            }
        checkTagControl(view: tagControl, named: "AdditionalDarkTheme", testName: "TagControl")
    }


    func testTagControlDefaultDarkTheme() {
        SwiftUIThemeManager.shared.theme = .dark
        let tagControl = TagControl(title: "Title",
                                    tagStyle: .default,
                                    leadingView: { Button(action: {}, label: {
            Image(uiImage: Asset.Category.Outline.bankOutline.image)
        }) },
                                    trailingView: {
            Button(action: {}, label: {
                Image(uiImage: Asset.Category.Outline.bankOutline.image)
            }) }) {

            }
        checkTagControl(view: tagControl, named: "defaultDarkTheme", testName: "TagControl")
    }

}

private extension TagControlSnapshotTests {

    func checkTagControl<T: View>(view: T, named: String, testName: String, disabled: Bool = false) {
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
