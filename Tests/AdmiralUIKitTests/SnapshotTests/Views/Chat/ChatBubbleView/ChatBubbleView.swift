import XCTest
import SnapshotTesting
import AdmiralTheme
import AdmiralUIResources
@testable import AdmiralUIKit

class ChatBubbleViewTest: XCTestCase {

    override func setUp() {
        super.setUp()
        Appearance.prepare()
    }

    // MARK: - Theme

    private lazy var theme: AppTheme = {
        let theme = Appearance.shared.theme
        return theme
    }()

    func testDefaultChatBubble() {
        let view = createChatBubbleView(
            state: .default,
            direction: .right
        )
        checkView(view: view, named: "Default", testName: "ChatBubbleView")
    }

    func testDefaultChatBubbleError() {
        let view = createChatBubbleView(
            state: .error,
            direction: .right,
            frame: CGSize(width: 180, height: 72)
        )
        checkView(view: view, named: "Error", testName: "ChatBubbleView")
    }

    func testDefaultChatBubbleLeft() {
        let view = createChatBubbleView(
            state: .default,
            direction: .left,
            frame: CGSize(width: 139, height: 72)
        )
        checkView(view: view, named: "Left", testName: "ChatBubbleView")
    }

    func testDefaultChatBubbleErrorLeft() {
        let view = createChatBubbleView(
            state: .error,
            direction: .left,
            frame: CGSize(width: 139, height: 72)
        )
        checkView(view: view, named: "ErrorLeft", testName: "ChatBubbleView")
    }

    func testDefaultChatBubbleWithName() {
        let view = createChatBubbleView(
            state: .default,
            name: "Антон",
            direction: .left,
            frame: CGSize(width: 139, height: 90)
        )
        checkView(view: view, named: "Named", testName: "ChatBubbleView")
    }

    // MARK: - Private Methods

    private func createChatBubbleView(
        status: ChatStatus? = nil,
        state: ChatBubbleState,
        messageText: String = "ChatBubbleView",
        timeTitle: String = "21:22",
        name: String = "",
        direction: ChatDirection = .right,
        frame: CGSize = CGSize(width: 139, height: 72)
    ) -> ChatBubbleView {
        let chatBubble = ChatBubbleView()
        chatBubble.chatStatus = status
        chatBubble.state = state
        chatBubble.messageText = messageText
        chatBubble.timeTitle = timeTitle
        chatBubble.name = name
        chatBubble.chatDirection = direction
        chatBubble.frame.size = frame
        chatBubble.apply(theme: theme)
        return chatBubble
    }

    private func checkView(view: UIView, named: String, testName: String) {
        let result = verifySnapshot(
            matching: UIView(),
            as: .image,
            named: named,
            file: getFilePath(),
            testName: testName)
        XCTAssertNil(result)
    }

}
