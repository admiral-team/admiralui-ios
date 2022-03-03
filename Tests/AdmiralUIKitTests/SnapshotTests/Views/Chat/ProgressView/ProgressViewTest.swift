import XCTest
import SnapshotTesting
import AdmiralTheme
import AdmiralUIResources
@testable import AdmiralUIKit

class ProgressViewTest: XCTestCase {

    override func setUp() {
        super.setUp()
        Appearance.prepare()
    }

    // MARK: - Theme

    private lazy var theme: AppTheme = {
        let theme = Appearance.shared.theme
        return theme
    }()

    func testProgressDefault() {
        let progress = createProgressView(style: .default, trackStyle: .accent, image: PrivateAsset.Custom.Cell.arrowDown.image, isAnimating: false)
        checkView(view: progress, named: "Default", testName: "ProgressView")
    }

    func testProgressClear() {
        let progress = createProgressView(style: .default, trackStyle: .accent, image: Asset.Service.Outline.closeOutline.image, isAnimating: true)
        checkView(view: progress, named: "Default.Clear", testName: "ProgressView")
    }

    func testProgressLoading() {
        let progress = createProgressView(style: .default, trackStyle: .accent, image: PrivateAsset.Custom.Cell.arrowDown.image, isAnimating: true)
        checkView(view: progress, named: "Loading", testName: "ProgressView")
    }

    func testProgressAccent() {
        let progress = createProgressView(style: .accent, trackStyle: .default, image: PrivateAsset.Custom.Cell.arrowDown.image, isAnimating: false)
        checkView(view: progress, named: "Accent", testName: "ProgressView")
    }

    func testProgressAccentLoading() {
        let progress = createProgressView(style: .accent, trackStyle: .default, image: PrivateAsset.Custom.Cell.arrowDown.image, isAnimating: true)
        checkView(view: progress, named: "AccentLoading", testName: "ProgressView")
    }

    // MARK: - Private Methods

    private func createProgressView(
        style: ProgressViewStyle,
        trackStyle: ProgressViewStyle,
        image: UIImage,
        isAnimating: Bool
    ) -> ProgressView {
        let progress = ProgressView()
        progress.style = style
        progress.image = image
        progress.trackProgressStyle = trackStyle
        progress.isAnimating = isAnimating
        progress.frame.size = CGSize(width: 45, height: 45)
        progress.apply(theme: theme)
        return progress
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
