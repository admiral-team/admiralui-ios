import XCTest
import SnapshotTesting
import AdmiralTheme
import AdmiralUIResources
@testable import AdmiralUIKit

class UploadImageGridViewTest: XCTestCase {

    override func setUp() {
        super.setUp()
        Appearance.prepare()
    }

    // MARK: - Theme

    private lazy var theme: AppTheme = {
        let theme = Appearance.shared.theme
        return theme
    }()

    func testUploadImageGrid() {
        let view = createGridView(
            state: .default,
            models:
                Array(repeating: UploadImageItem(
                    image: TestsAsset.Chat.photo.image,
                    style: .default,
                    state: .default
                ), count: 4),
            size: CGSize(width: 238, height: 238)
        )
        checkView(view: view, named: "Default.Four", testName: "UploadImageGridView")
    }

    func testUploadImageGridLoading() {
        let view = createGridView(
            state: .default,
            models: Array(repeating: UploadImageItem(
                image: TestsAsset.Chat.photo.image,
                style: .default,
                state: .loading
            ),count: 4),
            size: CGSize(width: 238, height: 238)
        )
        checkView(view: view, named: "Loading.Four", testName: "UploadImageGridView")
    }

    func testUploadImageGridSix() {
        let view = createGridView(
            state: .default,
            models: Array(repeating: UploadImageItem(
                image: TestsAsset.Chat.photo.image,
                style: .default,
                state: .default
            ), count: 6))
        checkView(view: view, named: "Default.Six", testName: "UploadImageGridView")
    }

    func testUploadImageGridSixLoading() {
        let view = createGridView(
            state: .default,
            models: Array(repeating: UploadImageItem(
                image: TestsAsset.Chat.photo.image,
                style: .default,
                state: .loading
            ), count: 6),
            size: CGSize(width: 238, height: 358)
        )
        checkView(view: view, named: "Loading.Six", testName: "UploadImageGridView")
    }

    func testUploadImageGridSixLoadingError() {
        let view = createGridView(
            state: .error,
            models: Array(repeating: UploadImageItem(
                image: TestsAsset.Chat.photo.image,
                style: .default,
                state: .loading
            ), count: 6),
            size: CGSize(width: 270, height: 360)
        )
        checkView(view: view, named: "Loading.Six.Error", testName: "UploadImageGridView")
    }

    // MARK: - Private Methods

    private func createGridView(
        chatTime: String = "21:21",
        chatStatus: ChatStatus? = nil,
        state: UploadImageGridState,
        models: [UploadImageItem],
        size: CGSize = CGSize(width: 240, height: 360)
    ) -> UploadImageGridView {
        let grid = UploadImageGridView()
        grid.frame.size = size
        grid.models = models
        grid.chatTime = chatTime
        grid.chatStatus = chatStatus
        grid.state = state
        grid.apply(theme: theme)
        return grid
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
