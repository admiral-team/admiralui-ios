import XCTest
import SnapshotTesting
import AdmiralTheme
@testable import AdmiralUIKit

class ErrorViewSnapshotTest: XCTestCase {

    // MARK: - Constants

    private enum Constants {
        static let text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
        static let buttonTitle = "Хорошо"
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

    // MARK: - View

    func testViewDefaultState() {
        let view = createView(appTheme: .default)
        checkView(view: view, named: "Default", testName: "ErrorView")
    }

    func testViewDefaultStateDark() {
        let view = createView(appTheme: .dark)
        checkView(view: view, named: "Dark", testName: "ErrorView")
    }

    func testViewDefaultStateSmeDark() {
        let view = createView(appTheme: .sMEDark)
        checkView(view: view, named: "SME.Dark", testName: "ErrorView")
    }

    func testViewDefaultStateSmeLight() {
        let view = createView(appTheme: .sMELight)
        checkView(view: view, named: "SME.Light", testName: "ErrorView")
    }

    // MARK: - Private Methods

    private func createView(appTheme: AppTheme) -> UIView {
        let errorView = ErrorView()
        errorView.text = Constants.text
        errorView.buttonTitle = Constants.buttonTitle
        errorView.frame.size = CGSize(width: 300, height: 300)
        errorView.apply(theme: appTheme)
        return errorView
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
