//
//  UploadImageViewSnapshotTests.swift
//  AdmiralSwiftUITests
//
//  Created on 15.11.2021.
//

import XCTest
import SwiftUI
import SnapshotTesting
import AdmiralTheme
@testable import AdmiralSwiftUI

private struct UploadImageViewWrapper<T: View>: View {
    
    // MARK: - Properties
    let view: T
    
    // MARK: - Layout
    var body: some View {
        view
            .frame(width: 300, height: 200)
    }
    
}

final class UploadImageViewSnapshotTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        Appearance.prepare()
    }
    
    // MARK: Default Theme
    
    func testUploadImageViewLoadingStatusDefaultTheme() {
        Appearance.shared.theme = .default
        let view = createUploadImageView(status: .loading)
        checkUploadImageView(view: view, named: "Loading.DefaultTheme", testName: "UploadImageView")
    }
    
    func testUploadImageViewErrorStatusDefaultTheme() {
        Appearance.shared.theme = .default
        let view = createUploadImageView(status: .error)
        checkUploadImageView(view: view, named: "Error.DefaultTheme", testName: "UploadImageView")
    }
    
    func testUploadImageViewReadStatusDefaultTheme() {
        Appearance.shared.theme = .default
        let view = createUploadImageView(status: .read)
        checkUploadImageView(view: view, named: "Read.DefaultTheme", testName: "UploadImageView")
    }
    
    func testUploadImageViewReceiveStatusDefaultTheme() {
        Appearance.shared.theme = .default
        let view = createUploadImageView(status: .receive)
        checkUploadImageView(view: view, named: "Receive.DefaultTheme", testName: "UploadImageView")
    }
    
    func testUploadImageViewSentStatusDefaultTheme() {
        Appearance.shared.theme = .default
        let view = createUploadImageView(status: .sent)
        checkUploadImageView(view: view, named: "Sent.DefaultTheme", testName: "UploadImageView")
    }
    
    // MARK: Dark Theme

    func testUploadImageViewLoadingStatusDarkTheme() {
        Appearance.shared.theme = .dark
        let view = createUploadImageView(status: .loading)
        checkUploadImageView(view: view, named: "Loading.DarkTheme", testName: "UploadImageView")
    }
    
    func testUploadImageViewErrorStatusDarkTheme() {
        Appearance.shared.theme = .dark
        let view = createUploadImageView(status: .error)
        checkUploadImageView(view: view, named: "Error.DarkTheme", testName: "UploadImageView")
    }
    
    func testUploadImageViewReadStatusDarkTheme() {
        Appearance.shared.theme = .dark
        let view = createUploadImageView(status: .read)
        checkUploadImageView(view: view, named: "Read.DarkTheme", testName: "UploadImageView")
    }
    
    func testUploadImageViewReceiveStatusDarkTheme() {
        Appearance.shared.theme = .dark
        let view = createUploadImageView(status: .receive)
        checkUploadImageView(view: view, named: "Receive.DarkTheme", testName: "UploadImageView")
    }
    
    func testUploadImageViewSentStatusDarkTheme() {
        Appearance.shared.theme = .dark
        let view = createUploadImageView(status: .sent)
        checkUploadImageView(view: view, named: "Sent.DarkTheme", testName: "UploadImageView")
    }
    
    func createUploadImageView(status: ChatStatus) -> some View {
        let view = UploadImageView(
            model: UploadImageModel(
                time: "12:53",
                backgroundImage: Image(uiImage: TestAsset.Chat.photo.image),
                uploadStatus: status),
            direction: .left
        )
        return view
    }
    
}

private extension UploadImageViewSnapshotTests {
    
    func checkUploadImageView<T: View>(view: T, named: String, testName: String, disabled: Bool = false) {
        let uploadImageViewWrapper = UploadImageViewWrapper(view: view)
        let view = UIHostingController(rootView: uploadImageViewWrapper)
        let result = verifySnapshot(
            matching: view,
            as: .image,
            named: named,
            file: getFilePath(),
            testName: testName)
        XCTAssertNil(result)
    }
    
}
