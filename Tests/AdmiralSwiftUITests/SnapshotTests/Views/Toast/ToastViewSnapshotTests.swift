//
//  ToastViewSnapshotTests.swift
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

private struct ToastViewWrapper<T: View>: View {
    
    // MARK: - Properties
    let view: T
    
    // MARK: - Layout
    var body: some View {
        view
            .frame(width: 500, height: 200)
    }
    
}

final class ToastViewSnapshotTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        Appearance.prepare()
    }
    
    // MARK: Default Theme
    
    func testToastViewDefaultTheme() {
        Appearance.shared.theme = .default
        let view = createToastView()
        checkToastView(view: view, named: "DefaultTheme", testName: "ToastView")
    }
    
    // MARK: Dark Theme

    func testToastViewDarkTheme() {
        Appearance.shared.theme = .dark
        let view = createToastView()
        checkToastView(view: view, named: "DarkTheme", testName: "ToastView")
    }
    
    func createToastView() -> some View {
        let view = ToastView(
            title: "At break point",
            linkText: "Link Text",
            linkAction: {},
            imageType: .info,
            imageColorType: .info,
            closeAction: {},
            type: .default)
        return view
    }
    
}

private extension ToastViewSnapshotTests {
    
    func checkToastView<T: View>(view: T, named: String, testName: String, disabled: Bool = false) {
        let toastViewWrapper = ToastViewWrapper(view: view)
        let view = UIHostingController(rootView: toastViewWrapper)
        let result = verifySnapshot(
            matching: view,
            as: .image,
            named: named,
            file: getFilePath(),
            testName: testName)
        XCTAssertNil(result)
    }
    
}
