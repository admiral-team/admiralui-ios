import XCTest
import SnapshotTesting
import AdmiralTheme
import AdmiralUIResources
@testable import AdmiralUIKit

class InputNumberSnapshotTests: XCTestCase {
    
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
      
    func testInputNumberDefaultState() {
        let inputNumber = createInputNumber(isEnabled: true)
        checkControl(control: inputNumber, named: "Default", testName: "InputNumber")
    }
    
    func testInputNumberDisabledState() {
        let inputNumber = createInputNumber(isEnabled: false)
        checkControl(control: inputNumber, named: "Disabled", testName: "InputNumber")
    }
    
    // MARK: - Private Methods
    
    private func createInputNumber(isEnabled: Bool) -> UIControl {
        let inputNumber = InputNumber(frame: CGRect(origin: .zero, size: CGSize(width: 120.0, height: 44.0)))
        inputNumber.minimumValue = 0
        inputNumber.maximumValue = 10
        inputNumber.value = 5
        inputNumber.isEnabled = isEnabled
        inputNumber.apply(theme: theme)
        return inputNumber
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
