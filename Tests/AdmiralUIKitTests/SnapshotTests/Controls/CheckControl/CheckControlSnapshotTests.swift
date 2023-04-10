import XCTest
import SnapshotTesting
import AdmiralCore
import AdmiralTheme
import AdmiralUIResources
@testable import AdmiralUIKit

class CheckControlSnapshotTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        Appearance.prepare()
    }
    
    // MARK: - Theme
    
    private lazy var theme: AppTheme = {
        let theme = Appearance.shared.theme
        return theme
    }()
    
    // MARK: - CheckBox
      
    func testCheckBoxDefaultState() {
        let checkBox = createCheckBox(isSelected: false, checkState: .normal)
        checkControl(control: checkBox, named: "Default", testName: "CheckBox")
    }
    
    func testCheckBoxSelectedState() {
        let checkBox = createCheckBox(isSelected: true, checkState: .normal)
        checkControl(control: checkBox, named: "Selected", testName: "CheckBox")
    }
    
    func testCheckBoxErrorState() {
        let checkBox = createCheckBox(isSelected: false, checkState: .error)
        checkControl(control: checkBox, named: "Error", testName: "CheckBox")
    }
    
    func testCheckBoxErrorSelectedState() {
        let checkBox = createCheckBox(isSelected: true, checkState: .error)
        checkControl(control: checkBox, named: "ErrorSelected", testName: "CheckBox")
    }
    
    // MARK: - Radio Control
    
    func testRadioControlDefaultState() {
        let radioControl = createRadioControl(isSelected: false, checkState: .normal)
        checkControl(control: radioControl, named: "Default", testName: "RadioControl")
    }
    
    func testRadioControlSelectedState() {
        let radioControl = createRadioControl(isSelected: true, checkState: .normal)
        checkControl(control: radioControl, named: "Selected", testName: "RadioControl")
    }
    
    func testRadioControlErrorState() {
        let radioControl = createRadioControl(isSelected: false, checkState: .error)
        checkControl(control: radioControl, named: "Error", testName: "RadioControl")
    }
    
    func testRadioControlErrorSelectedState() {
        let radioControl = createRadioControl(isSelected: true, checkState: .error)
        checkControl(control: radioControl, named: "ErrorSelected", testName: "RadioControl")
    }
    
    // MARK: - CheckTextControl
    
    func testCheckTextControlRadioDefaultState() {
        let radioControl = createRadioControl(isSelected: false, checkState: .normal)
        let control = createCheckTextControl(control: radioControl as! CheckControl, text: "Text")
        checkControl(control: control, named: "Default", testName: "CheckTextControl.RadioControl")
    }
    
    func testCheckTextControlRadioSelectedState() {
        let radioControl = createRadioControl(isSelected: true, checkState: .normal)
        let control = createCheckTextControl(control: radioControl as! CheckControl, text: "Text")
        checkControl(control: control, named: "Selected", testName: "CheckTextControl.RadioControl")
    }
    
    func testCheckTextControlRadioErrorState() {
        let radioControl = createRadioControl(isSelected: false, checkState: .error)
        let control = createCheckTextControl(control: radioControl as! CheckControl, text: "Text")
        checkControl(control: control, named: "Error", testName: "CheckTextControl.RadioControl")
    }
    
    func testCheckTextControlErrorRadioSelectedState() {
        let radioControl = createRadioControl(isSelected: true, checkState: .error)
        let control = createCheckTextControl(control: radioControl as! CheckControl, text: "Text")
        checkControl(control: control, named: "ErrorSelected", testName: "CheckTextControl.RadioControl")
    }
    
    func testCheckTextControlDefaultState() {
        let radioControl = createCheckBox(isSelected: false, checkState: .normal)
        let control = createCheckTextControl(control: radioControl as! CheckControl, text: "Text")
        checkControl(control: control, named: "Default", testName: "CheckTextControl.CheckBox")
    }
    
    func testCheckTextControlSelectedState() {
        let radioControl = createCheckBox(isSelected: true, checkState: .normal)
        let control = createCheckTextControl(control: radioControl as! CheckControl, text: "Text")
        checkControl(control: control, named: "Selected", testName: "CheckTextControl.CheckBox")
    }
    
    func testCheckTextControlErrorState() {
        let checkBox = createCheckBox(isSelected: false, checkState: .error)
        let control = createCheckTextControl(control: checkBox as! CheckControl, text: "Text")
        checkControl(control: control, named: "Error", testName: "CheckTextControl.CheckBox")
    }
    
    func testCheckTextControlErrorSelectedState() {
        let checkBox = createCheckBox(isSelected: true, checkState: .error)
        let control = createCheckTextControl(control: checkBox as! CheckControl, text: "Text")
        checkControl(control: control, named: "ErrorSelected", testName: "CheckTextControl.CheckBox")
    }
    
    // MARK: - Private Methods
    
    private func createCheckBox(isSelected: Bool, checkState: CheckControlState) -> UIControl {
        let checkBox = CheckBox(
            frame: CGRect(
                origin: .zero,
                size: CGSize(
                    width: LayoutGrid.tripleModule,
                    height: LayoutGrid.tripleModule)))
        checkBox.checkState = checkState
        checkBox.isSelected = isSelected
        checkBox.apply(theme: theme)
        return checkBox
    }
    
    private func createRadioControl(isSelected: Bool, checkState: CheckControlState) -> UIControl {
        let radioControl = RadioControl(
            frame: CGRect(
                origin: .zero,
                size: CGSize(
                    width: LayoutGrid.tripleModule,
                    height: LayoutGrid.tripleModule)))
        radioControl.checkState = checkState
        radioControl.isSelected = isSelected
        radioControl.apply(theme: theme)
        return radioControl
    }
    
    private func createCheckTextControl<T: CheckControl>(control: T, text: String) -> CheckTextControl<T> {
        let control = CheckTextControl<T>(checkControl: control)
        control.frame.size = CGSize(width: 60.0, height: LayoutGrid.tripleModule)
        control.text = text
        control.apply(theme: theme)
        return control
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
