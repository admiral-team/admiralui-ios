//
//  ChatInputSnapshotTests.swift
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

private struct ChatInputWrapper<T: View>: View {
    
    // MARK: - Properties
    let view: T
    
    // MARK: - Layout
    var body: some View {
        view
            .frame(width: 500, height: 150)
    }
    
}

final class ChatInputSnapshotTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        Appearance.prepare()
    }
    
    // MARK: Default Theme
    
    func testChatInputDefaultTheme() {
        Appearance.shared.theme = .default
        let view = createChatInput()
        checkChatInput(view: view, named: "DefaultTheme", testName: "ChatInput")
    }
    
    // MARK: Dark Theme
    
    func testChatInputDarkTheme() {
        Appearance.shared.theme = .dark
        let view = createChatInput()
        checkChatInput(view: view, named: "DarkTheme", testName: "ChatInput")
    }
    
    func createChatInput() -> some View {
        let view = ChatInput(
            .constant("ChatInput"),
            contentType: .default,
            returnKeyType: .emergencyCall,
            autocapitalizationType: .none,
            autocorrectionType: .default,
            placeholder: "Введите сообщение",
            isShowFileButton: true
        )
        return view
    }
    
}

private extension ChatInputSnapshotTests {
    
    func checkChatInput<T: View>(view: T, named: String, testName: String, disabled: Bool = false) {
        let chatInputWrapper = ChatInputWrapper(view: view)
        let view = UIHostingController(rootView: chatInputWrapper)
        let result = verifySnapshot(
            matching: view,
            as: .image,
            named: named,
            file: getFilePath(),
            testName: testName)
        XCTAssertNil(result)
    }
    
}
