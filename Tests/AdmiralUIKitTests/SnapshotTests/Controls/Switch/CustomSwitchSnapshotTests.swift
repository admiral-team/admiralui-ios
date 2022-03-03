import XCTest
import SnapshotTesting
import AdmiralTheme
import AdmiralUIResources
@testable import AdmiralUIKit

class CustomSwitchSnapshotTests: XCTestCase {
    
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
      
    func testCustomSwitchDefaultState() {
        let customSwitch = createCustomSwitch(isSelected: false, isEnabled: true)
        checkControl(control: customSwitch, named: "Default", testName: "CustomSwitch")
    }
    
    func testCustomSwitchDisabledState() {
        let customSwitch = createCustomSwitch(isSelected: false, isEnabled: false)
        checkControl(control: customSwitch, named: "Disabled", testName: "CustomSwitch")
    }
    
    func testCustomSwitchSelectedState() {
        let customSwitch = createCustomSwitch(isSelected: true, isEnabled: true)
        checkControl(control: customSwitch, named: "Selected", testName: "CustomSwitch")
    }
    
    func testCustomSwitchSelectedDisabledState() {
        let customSwitch = createCustomSwitch(isSelected: true, isEnabled: false)
        checkControl(control: customSwitch, named: "SelectedDisabled", testName: "CustomSwitch")
    }
    
    // MARK: - Private Methods
    
    private func createCustomSwitch(isSelected: Bool, isEnabled: Bool) -> UIControl {
        let customSwitch = CustomSwitch()
        customSwitch.isOn = isSelected
        customSwitch.isEnabled = isEnabled
        customSwitch.apply(theme: theme)
        return customSwitch
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

