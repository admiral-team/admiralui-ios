import XCTest
import SnapshotTesting
import AdmiralCore
import AdmiralTheme
import AdmiralUIResources
@testable import AdmiralUIKit

class TextOperationTest: XCTestCase {

    private enum Constants {
        static let width: CGFloat = LayoutGrid.module * 34
    }

    override func setUp() {
        super.setUp()
        Appearance.prepare()
    }

    // MARK: - Theme

    private lazy var theme: AppTheme = {
        let theme = Appearance.shared.theme
        return theme
    }()

    func testDefaultChatInputDefault() {
        let view = createTextOperationView(chatStatus: nil, direction: .right, style: .default)
        checkView(view: view, named: "Default", testName: "TextOperation")
    }

    func testDefaultChatInputError() {
        let view = createTextOperationView(chatStatus: nil, direction: .right, style: .error)
        checkView(view: view, named: "Error", testName: "TextOperation")
    }

    func testDefaultChatInputSuccess() {
        let view = createTextOperationView(chatStatus: nil, direction: .right, style: .success)
        checkView(view: view, named: "Success", testName: "TextOperation")
    }

    // MARK: - Private Methods

    private func createTextOperationView(
        chatStatus: ChatStatus? = nil,
        direction: ChatDirection,
        style: TextOperationViewStyle,
        chatBubbleTime: String? = "21:21",
        discriptionName: String = "НПО «Ромашка»",
        timeName: String = "13 мая 14:15",
        titleName: String = "+ 35 000 ₽"
    ) -> TextOperationView {
        let textOperationView = TextOperationView()
        textOperationView.chatStatus = chatStatus
        textOperationView.chatDirection = direction
        textOperationView.style = style
        textOperationView.chatBubbleTime = chatBubbleTime
        textOperationView.discriptionName = discriptionName
        textOperationView.timeName = timeName
        textOperationView.titleName = titleName
        textOperationView.frame.size = CGSize(
            width: style == .default || style == .success ? LayoutGrid.module * 29 : Constants.width,
            height: 97
        )
        textOperationView.apply(theme: theme)
        return textOperationView
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
