//
//  ChatBubbleView.swift
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

private struct ChatBubbleViewWrapper<T: View>: View {
    
    // MARK: - Properties
    let view: T
    
    // MARK: - Layout
    var body: some View {
        view
            .frame(width: 300, height: 110)
    }
    
}

final class ChatBubbleViewSnapshotTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        Appearance.prepare()
    }
    
    // MARK: Left ChatBubble Default Theme
    
    func testLeftChatBubbleViewSentDefaultTheme() {
        Appearance.shared.theme = .default
        let view = createLeftChatBubbleView(status: .none)
        checkChatBubbleView(view: view, named: "Left.Sent.DefaultTheme", testName: "ChatBubbleView")
    }
    
    func testLeftChatBubbleViewReciveDefaultTheme() {
        Appearance.shared.theme = .default
        let view = createLeftChatBubbleView(status: .none)
        checkChatBubbleView(view: view, named: "Left.Recive.DefaultTheme", testName: "ChatBubbleView")
    }
    
    func testLeftChatBubbleViewReadDefaultTheme() {
        Appearance.shared.theme = .default
        let view = createLeftChatBubbleView(status: .none)
        checkChatBubbleView(view: view, named: "Left.Read.DefaultTheme", testName: "ChatBubbleView")
    }
    
    func testLeftChatBubbleViewLoadingDefaultTheme() {
        Appearance.shared.theme = .default
        let view = createLeftChatBubbleView(status: .none)
        checkChatBubbleView(view: view, named: "Left.Loading.DefaultTheme", testName: "ChatBubbleView")
    }
    
    func testLeftChatBubbleViewErrorDefaultTheme() {
        Appearance.shared.theme = .default
        let view = createLeftChatBubbleView(status: .none)
        checkChatBubbleView(view: view, named: "Left.Error.DefaultTheme", testName: "ChatBubbleView")
    }
    
    // MARK: Left ChatBubble Dark Theme
    
    func tesLefttChatBubbleViewSentDarkTheme() {
        Appearance.shared.theme = .dark
        let view = createLeftChatBubbleView(status: .none)
        checkChatBubbleView(view: view, named: "Left.Sent.DarkTheme", testName: "ChatBubbleView")
    }
    
    func tesLefttChatBubbleViewReciveDarkTheme() {
        Appearance.shared.theme = .dark
        let view = createLeftChatBubbleView(status: .none)
        checkChatBubbleView(view: view, named: "Left.Recive.DarkTheme", testName: "ChatBubbleView")
    }
    
    func testLeftChatBubbleViewReadDarkTheme() {
        Appearance.shared.theme = .dark
        let view = createLeftChatBubbleView(status: .none)
        checkChatBubbleView(view: view, named: "Left.Read.DarkTheme", testName: "ChatBubbleView")
    }
    
    func testLeftChatBubbleViewLoadingDarkTheme() {
        Appearance.shared.theme = .dark
        let view = createLeftChatBubbleView(status: .none)
        checkChatBubbleView(view: view, named: "Left.Loading.DarkTheme", testName: "ChatBubbleView")
    }
    
    func testLeftChatBubbleViewErrorDarkTheme() {
        Appearance.shared.theme = .dark
        let view = createLeftChatBubbleView(status: .none)
        checkChatBubbleView(view: view, named: "Left.Error.DarkTheme", testName: "ChatBubbleView")
    }
    
    // MARK: Right ChatBubble Default Theme
    
    func testRightChatBubbleViewSentDefaultTheme() {
        Appearance.shared.theme = .default
        let view = createRightChatBubbleView(status: .sent)
        checkChatBubbleView(view: view, named: "Right.Sent.DefaultTheme", testName: "ChatBubbleView")
    }
    
    func testRightChatBubbleViewReciveDefaultTheme() {
        Appearance.shared.theme = .default
        let view = createRightChatBubbleView(status: .receive)
        checkChatBubbleView(view: view, named: "Right.Recive.DefaultTheme", testName: "ChatBubbleView")
    }
    
    func testRightChatBubbleViewReadDefaultTheme() {
        Appearance.shared.theme = .default
        let view = createRightChatBubbleView(status: .read)
        checkChatBubbleView(view: view, named: "Right.Read.DefaultTheme", testName: "ChatBubbleView")
    }
    
    func testRightChatBubbleViewLoadingDefaultTheme() {
        Appearance.shared.theme = .default
        let view = createRightChatBubbleView(status: .loading)
        checkChatBubbleView(view: view, named: "Right.Loading.DefaultTheme", testName: "ChatBubbleView")
    }
    
    func testRightChatBubbleViewErrorDefaultTheme() {
        Appearance.shared.theme = .default
        let view = createRightChatBubbleView(status: .error)
        checkChatBubbleView(view: view, named: "Right.Error.DefaultTheme", testName: "ChatBubbleView")
    }
    
    // MARK: Right ChatBubble Dark Theme
    
    func tesRightChatBubbleViewSentDarkTheme() {
        Appearance.shared.theme = .dark
        let view = createRightChatBubbleView(status: .sent)
        checkChatBubbleView(view: view, named: "Right.Sent.DarkTheme", testName: "ChatBubbleView")
    }
    
    func tesRightChatBubbleViewReciveDarkTheme() {
        Appearance.shared.theme = .dark
        let view = createRightChatBubbleView(status: .receive)
        checkChatBubbleView(view: view, named: "Right.Recive.DarkTheme", testName: "ChatBubbleView")
    }
    
    func testRightChatBubbleViewReadDarkTheme() {
        Appearance.shared.theme = .dark
        let view = createRightChatBubbleView(status: .read)
        checkChatBubbleView(view: view, named: "Right.Read.DarkTheme", testName: "ChatBubbleView")
    }
    
    func testRightChatBubbleViewLoadingDarkTheme() {
        Appearance.shared.theme = .dark
        let view = createRightChatBubbleView(status: .loading)
        checkChatBubbleView(view: view, named: "Right.Loading.DarkTheme", testName: "ChatBubbleView")
    }
    
    func testRightChatBubbleViewErrorDarkTheme() {
        Appearance.shared.theme = .dark
        let view = createRightChatBubbleView(status: .error)
        checkChatBubbleView(view: view, named: "Right.Error.DarkTheme", testName: "ChatBubbleView")
    }

    // MARK: - SchemeProvider

    func testLeftChatBubbleSchemeProvider() {
        Appearance.shared.theme = .dark
        var scheme = ChatBubbleViewScheme(theme: .default)
        scheme.backgroundColor.set(parameter: AColor(color: .systemPink), style: .left)
        let newSchemeProvider = SchemeProvider<ChatBubbleViewScheme>(scheme: scheme)

        let view = createLeftChatBubbleView(status: .none, schemeProvider: newSchemeProvider)
        checkChatBubbleView(view: view, named: "NewSchemeProvider", testName: "ChatBubbleView")

        Appearance.shared.theme = .default
        let newView = createLeftChatBubbleView(status: .none, schemeProvider: newSchemeProvider)
        checkChatBubbleView(view: newView, named: "NewSchemeProvider", testName: "ChatBubbleView")
    }

    func testRightChatBubbleSchemeProvider() {
        Appearance.shared.theme = .dark
        var scheme = ChatBubbleViewScheme(theme: .default)
        scheme.backgroundColor.set(parameter: AColor(color: .systemPink), style: .right)
        let newSchemeProvider = SchemeProvider<ChatBubbleViewScheme>(scheme: scheme)

        let view = createRightChatBubbleView(status: .none, schemeProvider: newSchemeProvider)
        checkChatBubbleView(view: view, named: "Right.NewSchemeProvider", testName: "ChatBubbleView")

        Appearance.shared.theme = .default
        let newView = createRightChatBubbleView(status: .none, schemeProvider: newSchemeProvider)
        checkChatBubbleView(view: newView, named: "Right.NewSchemeProvider", testName: "ChatBubbleView")
    }
    
    func createLeftChatBubbleView(status: ChatStatus) -> some View {
        let view = ChatBubbleView(
            text: "ChatBubbleView",
            direction: .left,
            time: "12:53",
            status: status,
            name: "ChatBubble",
            maxWidth: 200.0)
            .padding()
        return view
    }

    func createLeftChatBubbleView(status: ChatStatus, schemeProvider: SchemeProvider<ChatBubbleViewScheme>) -> some View {
        let view = ChatBubbleView(
            text: "ChatBubbleView",
            direction: .left,
            time: "12:53",
            status: status,
            name: "ChatBubble",
            maxWidth: 200.0,
            schemeProvider: schemeProvider
        )
            .padding()
        return view
    }
    
    func createRightChatBubbleView(status: ChatStatus) -> some View {
        let view = ChatBubbleView(
            text: "ChatBubbleView",
            direction: .right,
            time: "12:53",
            status: status,
            name: "ChatBubble",
            maxWidth: 200.0)
            .padding()
        return view
    }

    func createRightChatBubbleView(status: ChatStatus, schemeProvider: SchemeProvider<ChatBubbleViewScheme>) -> some View {
        let view = ChatBubbleView(
            text: "ChatBubbleView",
            direction: .right,
            time: "12:53",
            status: status,
            name: "ChatBubble",
            maxWidth: 200.0,
            schemeProvider: schemeProvider
        )
            .padding()
        return view
    }
    
}

private extension ChatBubbleViewSnapshotTests {
    
    func checkChatBubbleView<T: View>(view: T, named: String, testName: String, disabled: Bool = false) {
        let сhatBubbleViewWrapper = ChatBubbleViewWrapper(view: view)
        let view = UIHostingController(rootView: сhatBubbleViewWrapper)
        let result = verifySnapshot(
            matching: view,
            as: .image,
            named: named,
            file: getFilePath(),
            testName: testName)
        XCTAssertNil(result)
    }
    
}
