import XCTest
import SnapshotTesting
import AdmiralTheme
@testable import AdmiralUIKit

class ChatInputTest: XCTestCase {

    override func setUp() {
        super.setUp()
        Appearance.prepare()
    }

    // MARK: - Theme

    private lazy var theme: AppTheme = {
        let theme = Appearance.shared.theme
        return theme
    }()

    func testDefaultChatInput() {
        let view = createChatInputView(state: .default, actionState: .attachFiles, isSendButtonDisabled: false, placeholder: "Placeholder")
        checkView(view: view, named: "Default", testName: "ChatInput")
    }

    func testDefaultChatInputDisabled() {
        let view = createChatInputView(state: .disabled, actionState: .deleteVoiceRecord, isSendButtonDisabled: true, placeholder: "Placeholder")
        checkView(view: view, named: "Disabled", testName: "ChatInput")
    }

    // MARK: - Private Methods

    private func createChatInputView(
        state: TextInputState,
        actionState: ChatInputMessageAction,
        isSendButtonDisabled: Bool,
        placeholder: String,
        isSelected: Bool = false
    ) -> ChatInputView {
        let chatInput = ChatInputView()
        chatInput.state = state
        chatInput.actionState = actionState
        chatInput.isSendButtonDisabled = isSendButtonDisabled
        chatInput.placeholder = placeholder
        chatInput.isSelected = isSelected
        chatInput.frame.size = CGSize(width: 230, height: 41)
        chatInput.apply(theme: theme)
        return chatInput
    }

    private func checkView(view: UIView, named: String, testName: String) {
        let result = verifySnapshot(
            matching: view,
            as: .image,
            named: named,
            file: getFilePath(),
            testName: testName)
        XCTAssertNil(result)
    }

}
