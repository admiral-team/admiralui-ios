import XCTest
import SnapshotTesting
import AdmiralTheme
import AdmiralUIResources
@testable import AdmiralUIKit

class UploadDocumentViewTest: XCTestCase {

    override func setUp() {
        super.setUp()
        Appearance.prepare()
    }

    // MARK: - Theme

    private lazy var theme: AppTheme = {
        let theme = Appearance.shared.theme
        return theme
    }()

    func testDocumentLeftDefault() {
        let view = createDocumentView(style: .default, trackStyle: .accent, direction: .left, chatStatus: nil, state: .description)
        checkView(view: view, named: "DefaultLeft", testName: "UploadDocumentView")
    }

    func testDocumentLeftLoading() {
        let view = createDocumentView(style: .default, trackStyle: .accent, direction: .left, chatStatus: nil, state: .loading)
        checkView(view: view, named: "LoadingLeft", testName: "UploadDocumentView")
    }

    func testDocumentRightDefault() {
        let view = createDocumentView(style: .accent, trackStyle: .default, direction: .right, chatStatus: nil, state: .description)
        checkView(view: view, named: "DefaultRight", testName: "UploadDocumentView")
    }

    func testDocumentRightLoading() {
        let view = createDocumentView(style: .accent, trackStyle: .default, direction: .right, chatStatus: nil, state: .loading)
        checkView(view: view, named: "LoadingRight", testName: "UploadDocumentView")
    }

    // MARK: - Private Methods

    private func createDocumentView(
        style: ProgressViewStyle,
        trackStyle: ProgressViewStyle,
        direction: ChatDirection,
        chatStatus: ChatStatus?,
        state: UploadDocumentState,
        chatTime: String = "14:52",
        fileName: String = "File 7.pdf",
        fileSize: String = "65.6 МБ"
    ) -> UploadDocumentView {
        let document = UploadDocumentView()
        document.trackProgressStyle = trackStyle
        document.direction = direction
        document.chatStatus = chatStatus
        document.state = state
        document.chatTime = chatTime
        document.fileName = fileName
        document.fileSize = fileSize
        document.progressCircleStyle = style
        document.frame.size = CGSize(width: 234, height: 80)
        document.apply(theme: theme)
        return document
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
