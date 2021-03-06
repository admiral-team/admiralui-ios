//
//  ChatBubbleStatusViewSnapshotTests.swift
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

private struct ChatBubbleStatusViewWrapper<T: View>: View {
    
    // MARK: - Properties
    let view: T
    
    // MARK: - Layout
    var body: some View {
        view
            .frame(width: 80, height: 50)
    }
    
}

final class ChatBubbleStatusViewSnapshotTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        Appearance.prepare()
    }
    
    // MARK: Default Theme & Left
    
    func testChatBubbleViewSentDefaultTheme() {
        SwiftUIThemeManager.shared.theme = .default
        let view = createChatBubbleStatusView(status: .none)
        checkChatBubbleStatusView(view: view, named: "Sent.DefaultTheme.Left", testName: "ChatBubbleStatusView")
    }
    
    func testChatBubbleViewReciveDefaultTheme() {
        SwiftUIThemeManager.shared.theme = .default
        let view = createChatBubbleStatusView(status: .none)
        checkChatBubbleStatusView(view: view, named: "Recive.DefaultTheme.Left", testName: "ChatBubbleStatusView")
    }
    
    func testChatBubbleViewReadDefaultTheme() {
        SwiftUIThemeManager.shared.theme = .default
        let view = createChatBubbleStatusView(status: .none)
        checkChatBubbleStatusView(view: view, named: "Read.DefaultTheme.Left", testName: "ChatBubbleStatusView")
    }
    
    func testChatBubbleViewLoadingDefaultTheme() {
        SwiftUIThemeManager.shared.theme = .default
        let view = createChatBubbleStatusView(status: .none)
        checkChatBubbleStatusView(view: view, named: "Loading.DefaultTheme.Left", testName: "ChatBubbleStatusView")
    }

    // MARK: Default Theme & Right

    func testChatBubbleViewSentDefaultThemeRight() {
        SwiftUIThemeManager.shared.theme = .default
        let view = createChatBubbleStatusViewRight(status: .sent)
        checkChatBubbleStatusView(view: view, named: "Sent.DefaultTheme.Right", testName: "ChatBubbleStatusView")
    }

    func testChatBubbleViewReciveDefaultThemeRight() {
        SwiftUIThemeManager.shared.theme = .default
        let view = createChatBubbleStatusViewRight(status: .receive)
        checkChatBubbleStatusView(view: view, named: "Recive.DefaultTheme.Right", testName: "ChatBubbleStatusView")
    }

    func testChatBubbleViewReadDefaultThemeRight() {
        SwiftUIThemeManager.shared.theme = .default
        let view = createChatBubbleStatusViewRight(status: .read)
        checkChatBubbleStatusView(view: view, named: "Read.DefaultTheme.Right", testName: "ChatBubbleStatusView")
    }

    func testChatBubbleViewLoadingDefaultThemeRight() {
        SwiftUIThemeManager.shared.theme = .default
        let view = createChatBubbleStatusViewRight(status: .loading)
        checkChatBubbleStatusView(view: view, named: "Loading.DefaultTheme.Right", testName: "ChatBubbleStatusView")
    }

    
    // MARK: Dark Theme & Left
    
    func testChatBubbleViewSentDarkTheme() {
        SwiftUIThemeManager.shared.theme = .dark
        let view = createChatBubbleStatusView(status: .none)
        checkChatBubbleStatusView(view: view, named: "Sent.DarkTheme.Left", testName: "ChatBubbleStatusView")
    }
    
    func testChatBubbleViewReciveDarkTheme() {
        SwiftUIThemeManager.shared.theme = .dark
        let view = createChatBubbleStatusView(status: .none)
        checkChatBubbleStatusView(view: view, named: "Recive.DarkTheme.Left", testName: "ChatBubbleStatusView")
    }
    
    func testChatBubbleViewReadDarkTheme() {
        SwiftUIThemeManager.shared.theme = .dark
        let view = createChatBubbleStatusView(status: .none)
        checkChatBubbleStatusView(view: view, named: "Read.DarkTheme.Left", testName: "ChatBubbleStatusView")
    }
    
    func testChatBubbleViewLoadingDarkTheme() {
        SwiftUIThemeManager.shared.theme = .dark
        let view = createChatBubbleStatusView(status: .none)
        checkChatBubbleStatusView(view: view, named: "Loading.DarkTheme.Left", testName: "ChatBubbleStatusView")
    }

    // MARK: Dark Theme & Right

    func testChatBubbleViewSentDarkThemeRight() {
        SwiftUIThemeManager.shared.theme = .dark
        let view = createChatBubbleStatusViewRight(status: .sent)
        checkChatBubbleStatusView(view: view, named: "Sent.DarkTheme.Right", testName: "ChatBubbleStatusView")
    }

    func testChatBubbleViewReciveDarkThemeRight() {
        SwiftUIThemeManager.shared.theme = .dark
        let view = createChatBubbleStatusViewRight(status: .receive)
        checkChatBubbleStatusView(view: view, named: "Recive.DarkTheme.Right", testName: "ChatBubbleStatusView")
    }

    func testChatBubbleViewReadDarkThemeRight() {
        SwiftUIThemeManager.shared.theme = .dark
        let view = createChatBubbleStatusViewRight(status: .read)
        checkChatBubbleStatusView(view: view, named: "Read.DarkTheme.Right", testName: "ChatBubbleStatusView")
    }

    func testChatBubbleViewLoadingDarkThemeRight() {
        SwiftUIThemeManager.shared.theme = .dark
        let view = createChatBubbleStatusViewRight(status: .loading)
        checkChatBubbleStatusView(view: view, named: "Loading.DarkTheme.Right", testName: "ChatBubbleStatusView")
    }

    func createChatBubbleStatusView(status: ChatStatus) -> some View {
        let view = ChatBubbleStatusView(time: "12:53", status: status, direction: .left)
        return view
    }

    func createChatBubbleStatusViewRight(status: ChatStatus) -> some View {
        let view = ChatBubbleStatusView(time: "12:53", status: status, direction: .right)
        return view
    }

}

private extension ChatBubbleStatusViewSnapshotTests {
    
    func checkChatBubbleStatusView<T: View>(view: T, named: String, testName: String, disabled: Bool = false) {
        let chatBubbleStatusViewWrapper = ChatBubbleStatusViewWrapper(view: view)
        let view = UIHostingController(rootView: chatBubbleStatusViewWrapper)
        let result = verifySnapshot(
            matching: view,
            as: .image,
            named: named,
            file: getFilePath(),
            testName: testName)
        XCTAssertNil(result)
    }
    
}
