//
//  ToastViewSnapshotTests.swift
//  AdmiralSwiftUITests
//
//  Created on 15.11.2021.
//

import XCTest
import SwiftUI
import SnapshotTesting
import AdmiralCore
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

    // MARK: - Scheme Provider

    func testSchemeProvider() {
        Appearance.shared.theme = .default
        var scheme = ToastViewScheme()
        scheme.imageTintColor.set(parameter: AColor(color: .systemPink), isEnabled: true, type: .info)
        scheme.buttonScheme.textColor.set(parameter: AColor(color: .systemPink), for: .normal)
        scheme.titleTextColor.set(parameter: AColor(color: .systemPink), isEnabled: true, type: .default)
        let newSchemeProvider = SchemeProvider<ToastViewScheme>(scheme: scheme)

        let view = createToastView(schemeProvider: newSchemeProvider)
        checkToastView(view: view, named: "SchemeProvider", testName: "ToastView")

        Appearance.shared.theme = .dark
        let newView = createToastView(schemeProvider: newSchemeProvider)
        checkToastView(view: newView, named: "SchemeProvider", testName: "ToastView")
    }

    func testSchemeTimerProvider() {
        Appearance.shared.theme = .default
        var scheme = ToastViewScheme()
        scheme.countDownViewScheme.clockViewScheme.textColor = AColor(color: .systemPink)
        scheme.countDownViewScheme.progressBarScheme.tintColor = AColor(color: .systemPink)
        scheme.titleTextColor.set(parameter: AColor(color: .systemPink), isEnabled: true, type: .default)
        let newSchemeProvider = SchemeProvider<ToastViewScheme>(scheme: scheme)

        let view = createTimerToastView(schemeProvider: newSchemeProvider)
        checkToastView(view: view, named: "Timer.SchemeProvider", testName: "ToastView")

        Appearance.shared.theme = .dark
        let newView = createTimerToastView(schemeProvider: newSchemeProvider)
        checkToastView(view: newView, named: "Timer.SchemeProvider", testName: "ToastView")
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

    func createToastView(schemeProvider: SchemeProvider<ToastViewScheme>) -> some View {
        let view = ToastView(
            title: "At break point",
            linkText: "Link Text",
            linkAction: {},
            imageType: .info,
            imageColorType: .info,
            schemeProvider: schemeProvider,
            closeAction: {},
            type: .default
        )
        return view
    }

    func createTimerToastView(schemeProvider: SchemeProvider<ToastViewScheme>) -> some View {
        let view = ToastView(
            title: "At break point",
            timerDuration: 1,
            schemeProvider: schemeProvider,
            closeAction: {},
            closeView: { AnyView(EmptyView()) },
            type: .default
        )
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
