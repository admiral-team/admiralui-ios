import XCTest
import SnapshotTesting
import AdmiralCore
import AdmiralTheme
import AdmiralUIResources
@testable import AdmiralUIKit

class InputNumberTest: XCTestCase {

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
        checkView(view: view, named: "Default", testName: "InputNumberTextField")
    }

    func testViewDefaultStateDark() {
        let view = createView(appTheme: .dark)
        checkView(view: view, named: "Dark", testName: "InputNumberTextField")
    }

    func testViewDefaultStateSmeDark() {
        let view = createView(appTheme: .sMEDark)
        checkView(view: view, named: "SME.Dark", testName: "InputNumberTextField")
    }

    func testViewDefaultStateSmeLight() {
        let view = createView(appTheme: .sMELight)
        checkView(view: view, named: "SME.Light", testName: "InputNumberTextField")
    }

    // MARK: - Private Methods

    private func createView(appTheme: AppTheme) -> UIView {
        let inputTextField = InputNumberTextField()
        inputTextField.maximumValue = 0
        inputTextField.maximumValue = 9000000
        inputTextField.value = 0
        inputTextField.titleText = "Optional label"
        inputTextField.textFieldPlaceholder = "0"
        inputTextField.frame.size = CGSize(width: 300, height: LayoutGrid.halfModule * 9)
        inputTextField.apply(theme: appTheme)
        return inputTextField
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
