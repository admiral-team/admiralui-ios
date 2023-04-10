import XCTest
import SnapshotTesting
import AdmiralCore
import AdmiralTheme
import AdmiralUIResources
@testable import AdmiralUIKit

class CodeInputControlSnapshotTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        Appearance.prepare()
    }
    
    // MARK: - Theme
    
    private lazy var theme: AppTheme = {
        let theme = Appearance.shared.theme
        return theme
    }()
    
    // MARK: - CustomSwitch
      
    func testCodeInputDefaultState() {
        let codeInput = createPinCodeInput(status: .normal)
        checkControl(control: codeInput, named: "Default", testName: "PinCodeInput")
    }
    
    func testCodeInputErrorState() {
        let codeInput = createPinCodeInput(status: .error)
        checkControl(control: codeInput, named: "Error", testName: "PinCodeInput")
    }
    
    func testCodeInputSuccessState() {
        let codeInput = createPinCodeInput(status: .success)
        checkControl(control: codeInput, named: "Success", testName: "PinCodeInput")
    }
    
    // MARK: - Private Methods
    
    private func createPinCodeInput(status: CodeInputControl.Status) -> UIControl {
        let codeInput = PinCodeInput(
            frame: CGRect(
                origin: .zero,
                size: CGSize(width: 160.0, height: 32.0)))
        codeInput.status = status
        codeInput.apply(theme: theme)
        return codeInput
    }
    
    private func checkControl(control: UIControl, named: String, testName: String) {
        let result = verifySnapshot(
            matching: control,
            as: .image,
            named: named,
            file: getFilePath(),
            testName: testName)
        XCTAssertNil(result)
    }

}
