import XCTest
import SnapshotTesting
import AdmiralTheme
@testable import AdmiralUIKit

class ChatBubbleStatusViewTest: XCTestCase {

    override func setUp() {
        super.setUp()
        Appearance.prepare()
    }

    // MARK: - Theme

    private lazy var theme: AppTheme = {
        let theme = Appearance.shared.theme
        return theme
    }()

    func testDefaultChatBubbleStatus() {
        let view = createChatBubbleStatusView(direction: .left, time: "21:21", status: nil, backgroundColor: theme.colors.backgroundAdditionalOne.uiColor)
        checkView(view: view, named: "Left", testName: "ChatBubbleStatusView")
    }

    func testDefaultChatBubbleStatusRight() {
        let view = createChatBubbleStatusView(direction: .right, time: "21:21", status: nil, backgroundColor: theme.colors.backgroundAccent.uiColor, size: CGSize(width: 33, height: 16))
        checkView(view: view, named: "Right", testName: "ChatBubbleStatusView")
    }

    // MARK: - Private Methods

    private func createChatBubbleStatusView(
        direction: ChatDirection,
        time: String = "",
        status: ChatStatus?,
        backgroundColor: UIColor,
        size: CGSize = CGSize(width: 33, height: 16)
    ) -> ChatBubbleStatusView {
        let chatBubbleStatus = ChatBubbleStatusView()
        chatBubbleStatus.chatDirection = direction
        chatBubbleStatus.timeTitle = time
        chatBubbleStatus.chatStatus = status
        chatBubbleStatus.backgroundColor = backgroundColor
        chatBubbleStatus.layer.cornerRadius = LayoutGrid.module
        chatBubbleStatus.frame.size = size
        chatBubbleStatus.apply(theme: theme)
        return chatBubbleStatus
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
