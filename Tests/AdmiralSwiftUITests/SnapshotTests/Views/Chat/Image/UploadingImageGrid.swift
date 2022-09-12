//
//  UploadingImageGroupViewSnapshotTests.swift
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

final class UploadingImageGroupViewSnapshotTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        Appearance.prepare()
    }
    
    // MARK: Default Theme
    
    func testUploadingImageGroupViewSentDefaultTheme() {
        SwiftUIThemeManager.shared.theme = .default
        let view = createUploadingImageGroupView(status: .sent)
        checkUploadingImageGroupView(view: view, named: "Sent.DefaultTheme", testName: "UploadingImageGroupView")
    }
    
    func testUploadingImageGroupViewLoadingDefaultTheme() {
        SwiftUIThemeManager.shared.theme = .default
        let view = createUploadingImageGroupView(status: .loading)
        checkUploadingImageGroupView(view: view, named: "Loading.DefaultTheme", testName: "UploadingImageGroupView")
    }
    
    func testUploadingImageGroupViewReadDefaultTheme() {
        SwiftUIThemeManager.shared.theme = .default
        let view = createUploadingImageGroupView(status: .read)
        checkUploadingImageGroupView(view: view, named: "Read.DefaultTheme", testName: "UploadingImageGroupView")
    }
    
    func testUploadingImageGroupViewReceiveDefaultTheme() {
        SwiftUIThemeManager.shared.theme = .default
        let view = createUploadingImageGroupView(status: .receive)
        checkUploadingImageGroupView(view: view, named: "Receive.DefaultTheme", testName: "UploadingImageGroupView")
    }
    
    func testUploadingImageGroupViewErrorDefaultTheme() {
        SwiftUIThemeManager.shared.theme = .default
        let view = createUploadingImageGroupView(status: .error)
        checkUploadingImageGroupView(view: view, named: "Error.DefaultTheme", testName: "UploadingImageGroupView")
    }
    
    // MARK: Dark Theme
    
    func testUploadingImageGroupViewSentDarkTheme() {
        SwiftUIThemeManager.shared.theme = .dark
        let view = createUploadingImageGroupView(status: .sent)
        checkUploadingImageGroupView(view: view, named: "Sent.DarkTheme", testName: "UploadingImageGroupView")
    }
    
    func testUploadingImageGroupViewLoadingDarkTheme() {
        SwiftUIThemeManager.shared.theme = .default
        let view = createUploadingImageGroupView(status: .loading)
        checkUploadingImageGroupView(view: view, named: "Loading.DarkTheme", testName: "UploadingImageGroupView")
    }
    
    func testUploadingImageGroupViewReadDarkTheme() {
        SwiftUIThemeManager.shared.theme = .dark
        let view = createUploadingImageGroupView(status: .read)
        checkUploadingImageGroupView(view: view, named: "Read.DarkTheme", testName: "UploadingImageGroupView")
    }
    
    func testUploadingImageGroupViewReceiveDarkTheme() {
        SwiftUIThemeManager.shared.theme = .dark
        let view = createUploadingImageGroupView(status: .receive)
        checkUploadingImageGroupView(view: view, named: "Receive.DarkTheme", testName: "UploadingImageGroupView")
    }
    
    func testUploadingImageGroupViewErrorDarkTheme() {
        SwiftUIThemeManager.shared.theme = .dark
        let view = createUploadingImageGroupView(status: .error)
        checkUploadingImageGroupView(view: view, named: "Error.DarkTheme", testName: "UploadingImageGroupView")
    }

    // MARK: - SchemeProvider

    func testLeftChatBubbleSchemeProvider() {
        SwiftUIThemeManager.shared.theme = .dark
        var scheme = UploadImageViewScheme(theme: .default)
        scheme.textColor = AColor(color: .systemPink)
        let newSchemeProvider = SchemeProvider<UploadImageViewScheme>(scheme: scheme)

        let view = createUploadingImageGroupView(status: .sent, schemeProvider: newSchemeProvider)
        checkUploadingImageGroupView(view: view, named: "NewSchemeProvider", testName: "UploadingImageGroupView")

        SwiftUIThemeManager.shared.theme = .default
        let newView = createUploadingImageGroupView(status: .sent, schemeProvider: newSchemeProvider)
        checkUploadingImageGroupView(view: newView, named: "NewSchemeProvider", testName: "UploadingImageGroupView")
    }
    
    func createUploadingImageGroupView(status: ChatStatus) -> some View {
        UploadingImageGrid(
            models: [UploadImageModel(
                isLoading: false,
                time: "12:52",
                backgroundImage: Image(uiImage: TestAsset.Chat.photo.image),
                uploadStatus: status
            )], direction: .right
        )
        .frame(width: 300, height: 200)
    }

    func createUploadingImageGroupView(status: ChatStatus, schemeProvider: SchemeProvider<UploadImageViewScheme>) -> some View {
        UploadingImageGrid(
            models: [UploadImageModel(
                isLoading: false,
                time: "12:52",
                backgroundImage: Image(uiImage: PrivateAsset.Custom.Chat.photo.image),
                uploadStatus: status
            )],
            direction: .right,
            schemeProvider: schemeProvider
        )
        .frame(width: 300, height: 200)
    }
    
}

private extension UploadingImageGroupViewSnapshotTests {
    
    func checkUploadingImageGroupView<T: View>(view: T, named: String, testName: String, disabled: Bool = false) {
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
