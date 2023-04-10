import XCTest
import SnapshotTesting
import AdmiralCore
import AdmiralTheme
import AdmiralUIResources
@testable import AdmiralUIKit

class TextFieldsSnapshotTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        Appearance.prepare()
    }
    
    // MARK: - Theme
    
    private lazy var theme: AppTheme = {
        let theme = Appearance.shared.theme
        return theme
    }()
    
    // MARK: - TextField
      
    func testTextFieldDefaultCloseState() {
        let view = createTextField(state: .default, text: nil)
        checkView(view: view, named: "Default.Close", testName: "TextField")
    }
    
    func testTextFieldDefaultOpenState() {
        let view = createTextField(state: .default, text: "Text")
        checkView(view: view, named: "Default.Open", testName: "TextField")
    }
    
    func testTextFieldDisabledCloseState() {
        let view = createTextField(state: .disabled, text: nil)
        checkView(view: view, named: "Disabled.Close", testName: "TextField")
    }
    
    func testTextFieldDisabledOpenState() {
        let view = createTextField(state: .disabled, text: "Text")
        checkView(view: view, named: "Disabled.Open", testName: "TextField")
    }
    
    func testTextFieldErrorCloseState() {
        let view = createTextField(state: .error, text: nil)
        checkView(view: view, named: "Error.Close", testName: "TextField")
    }
    
    func testTextFieldErrorOpenState() {
        let view = createTextField(state: .error, text: "Text")
        checkView(view: view, named: "Error.Open", testName: "TextField")
    }
    
    func testTextFieldNormalCloseState() {
        let view = createTextField(state: .normal, text: nil)
        checkView(view: view, named: "Normal.Close", testName: "TextField")
    }
    
    func testTextFieldNormalOpenState() {
        let view = createTextField(state: .normal, text: "Text")
        checkView(view: view, named: "Normal.Open", testName: "TextField")
    }
    
    func testTextFieldReadOnlyCloseState() {
        let view = createTextField(state: .readOnly, text: nil)
        checkView(view: view, named: "ReadOnly.Close", testName: "TextField")
    }
    
    func testTextFieldReadOnlyOpenState() {
        let view = createTextField(state: .readOnly, text: "Text")
        checkView(view: view, named: "ReadOnly.Open", testName: "TextField")
    }
    
    // MARK: - BankCardTextField
      
    func testBankCardTextFieldDefaultCloseState() {
        let view = createBankCardTextField(state: .default, text: nil)
        checkView(view: view, named: "Default.Close", testName: "BankCardTextField")
    }
    
    func testBankCardTextFieldDefaultOpenState() {
        let view = createBankCardTextField(state: .default, text: "Text")
        checkView(view: view, named: "Default.Open", testName: "BankCardTextField")
    }
    
    func testBankCardTextFieldDisabledCloseState() {
        let view = createBankCardTextField(state: .disabled, text: nil)
        checkView(view: view, named: "Disabled.Close", testName: "BankCardTextField")
    }
    
    func testBankCardTextFieldDisabledOpenState() {
        let view = createBankCardTextField(state: .disabled, text: "Text")
        checkView(view: view, named: "Disabled.Open", testName: "BankCardTextField")
    }
    
    func testBankCardTextFieldErrorCloseState() {
        let view = createBankCardTextField(state: .error, text: nil)
        checkView(view: view, named: "Error.Close", testName: "BankCardTextField")
    }
    
    func testBankCardTextFieldErrorOpenState() {
        let view = createBankCardTextField(state: .error, text: "Text")
        checkView(view: view, named: "Error.Open", testName: "BankCardTextField")
    }
    
    func testBankCardTextFieldNormalCloseState() {
        let view = createBankCardTextField(state: .normal, text: nil)
        checkView(view: view, named: "Normal.Close", testName: "BankCardTextField")
    }
    
    func testBankCardTextFieldNormalOpenState() {
        let view = createBankCardTextField(state: .normal, text: "Text")
        checkView(view: view, named: "Normal.Open", testName: "BankCardTextField")
    }
    
    func testBankCardTextFieldReadOnlyCloseState() {
        let view = createBankCardTextField(state: .readOnly, text: nil)
        checkView(view: view, named: "ReadOnly.Close", testName: "BankCardTextField")
    }
    
    func testBankCardTextFieldReadOnlyOpenState() {
        let view = createBankCardTextField(state: .readOnly, text: "Text")
        checkView(view: view, named: "ReadOnly.Open", testName: "BankCardTextField")
    }
    
    // MARK: - DoubleTextField
      
    func testDoubleTextFieldDisabledFixedFirstState() {
        let view = createDoubleTextField(state: .disabled, aligment: .fixedFirst(first: 100.0))
        checkView(view: view, named: "Disabled.FixedFirst", testName: "DoubleTextField")
    }
    
    func testDoubleTextFieldDisabledFixedSecondState() {
        let view = createDoubleTextField(state: .disabled, aligment: .fixedSecond(second: 100.0))
        checkView(view: view, named: "Disabled.FixedSecond", testName: "DoubleTextField")
    }
    
    func testDoubleTextFieldDisabledRatioState() {
        let view = createDoubleTextField(state: .disabled, aligment: .ratio(ration: 2))
        checkView(view: view, named: "Disabled.Ratio", testName: "DoubleTextField")
    }
    
    func testDoubleTextFieldErrorFixedFirstState() {
        let view = createDoubleTextField(state: .error, aligment: .fixedFirst(first: 100.0))
        checkView(view: view, named: "Error.FixedFirst", testName: "DoubleTextField")
    }
    
    func testDoubleTextFieldErrorFixedSecondState() {
        let view = createDoubleTextField(state: .error, aligment: .fixedSecond(second: 100.0))
        checkView(view: view, named: "Error.FixedSecond", testName: "DoubleTextField")
    }
    
    func testDoubleTextFieldErrorRatioState() {
        let view = createDoubleTextField(state: .error, aligment: .ratio(ration: 2))
        checkView(view: view, named: "Error.Ratio", testName: "DoubleTextField")
    }
    
    func testDoubleTextFieldNormalFixedFirstState() {
        let view = createDoubleTextField(state: .normal, aligment: .fixedFirst(first: 100.0))
        checkView(view: view, named: "Normal.FixedFirst", testName: "DoubleTextField")
    }
    
    func testDoubleTextFieldNormalFixedSecondState() {
        let view = createDoubleTextField(state: .normal, aligment: .fixedSecond(second: 100.0))
        checkView(view: view, named: "Normal.FixedSecond", testName: "DoubleTextField")
    }
    
    func testDoubleTextFieldNormalRatioState() {
        let view = createDoubleTextField(state: .normal, aligment: .ratio(ration: 2))
        checkView(view: view, named: "Normal.Ratio", testName: "DoubleTextField")
    }
    
    func testDoubleTextFieldReadOnlyFixedFirstState() {
        let view = createDoubleTextField(state: .readOnly, aligment: .fixedFirst(first: 100.0))
        checkView(view: view, named: "ReadOnly.FixedFirst", testName: "DoubleTextField")
    }
    
    func testDoubleTextFieldReadOnlyFixedSecondState() {
        let view = createDoubleTextField(state: .readOnly, aligment: .fixedSecond(second: 100.0))
        checkView(view: view, named: "ReadOnly.FixedSecond", testName: "DoubleTextField")
    }
    
    func testDoubleTextFieldReadOnlyRatioState() {
        let view = createDoubleTextField(state: .readOnly, aligment: .ratio(ration: 2))
        checkView(view: view, named: "ReadOnly.Ratio", testName: "DoubleTextField")
    }
    
    func testDoubleTextFieldDefaultFixedFirstState() {
        let view = createDoubleTextField(state: .default, aligment: .fixedFirst(first: 100.0))
        checkView(view: view, named: "Default.FixedFirst", testName: "DoubleTextField")
    }
    
    func testDoubleTextFieldDefaultFixedSecondState() {
        let view = createDoubleTextField(state: .default, aligment: .fixedSecond(second: 100.0))
        checkView(view: view, named: "Default.FixedSecond", testName: "DoubleTextField")
    }
    
    func testDoubleTextFieldDefaultRatioState() {
        let view = createDoubleTextField(state: .default, aligment: .ratio(ration: 2))
        checkView(view: view, named: "Default.Ratio", testName: "DoubleTextField")
    }
    
    // MARK: - InputRangeTextField
      
    func testInputRangeTextFieldDisabledCloseState() {
        let view = createInputRangeTextField(state: .disabled, text: nil)
        checkView(view: view, named: "Disabled.Close", testName: "InputRangeTextField")
    }
    
    func testInputRangeTextFieldDisabledOpenState() {
        let view = createInputRangeTextField(state: .disabled, text: "Text")
        checkView(view: view, named: "Disabled.Open", testName: "InputRangeTextField")
    }
    
    func testInputRangeTextFieldErrorCloseState() {
        let view = createInputRangeTextField(state: .error, text: nil)
        checkView(view: view, named: "Error.Close", testName: "InputRangeTextField")
    }
    
    func testInputRangeTextFieldErrorOpenState() {
        let view = createInputRangeTextField(state: .error, text: "Text")
        checkView(view: view, named: "Error.Open", testName: "InputRangeTextField")
    }
    
    func testInputRangeTextFieldNormalCloseState() {
        let view = createInputRangeTextField(state: .normal, text: nil)
        checkView(view: view, named: "Normal.Close", testName: "InputRangeTextField")
    }
    
    func testInputRangeTextFieldNormalOpenState() {
        let view = createInputRangeTextField(state: .normal, text: "Text")
        checkView(view: view, named: "Normal.Open", testName: "InputRangeTextField")
    }
    
    func testInputRangeTextFieldDefaultCloseState() {
        let view = createInputRangeTextField(state: .default, text: nil)
        checkView(view: view, named: "ReadOnly.Close", testName: "InputRangeTextField")
    }
    
    func testInputRangeTextFieldDefaultOpenState() {
        let view = createInputRangeTextField(state: .default, text: "Text")
        checkView(view: view, named: "ReadOnly.Open", testName: "InputRangeTextField")
    }
    
    // MARK: - OTPTextField
    
    func testOTPTextFieldDisabledCloseState() {
        let view = createOTPTextField(state: .disabled, text: nil)
        checkView(view: view, named: "Disabled.Close", testName: "OTPTextField")
    }
    
    func testOTPTextFieldDisabledOpenState() {
        let view = createOTPTextField(state: .disabled, text: "Text")
        checkView(view: view, named: "Disabled.Open", testName: "OTPTextField")
    }
    
    func testOTPTextFieldErrorCloseState() {
        let view = createOTPTextField(state: .error, text: nil)
        checkView(view: view, named: "Error.Close", testName: "OTPTextField")
    }
    
    func testOTPTextFieldErrorOpenState() {
        let view = createOTPTextField(state: .error, text: "Text")
        checkView(view: view, named: "Error.Open", testName: "OTPTextField")
    }
    
    func testOTPTextFieldNormalCloseState() {
        let view = createOTPTextField(state: .normal, text: nil)
        checkView(view: view, named: "Normal.Close", testName: "OTPTextField")
    }
    
    func testOTPTextFieldNormalOpenState() {
        let view = createOTPTextField(state: .normal, text: "Text")
        checkView(view: view, named: "Normal.Open", testName: "OTPTextField")
    }
    
    func testOTPTextFieldReadOnlyCloseState() {
        let view = createOTPTextField(state: .readOnly, text: nil)
        checkView(view: view, named: "ReadOnly.Close", testName: "OTPTextField")
    }
    
    func testOTPTextFieldReadOnlyOpenState() {
        let view = createOTPTextField(state: .readOnly, text: "Text")
        checkView(view: view, named: "ReadOnly.Open", testName: "OTPTextField")
    }
    
    func testOTPTextFieldDefaultCloseState() {
        let view = createOTPTextField(state: .default, text: nil)
        checkView(view: view, named: "Default.Close", testName: "OTPTextField")
    }
    
    func testOTPTextFieldDefaultOpenState() {
        let view = createOTPTextField(state: .default, text: "Text")
        checkView(view: view, named: "Default.Open", testName: "OTPTextField")
    }
    
    // MARK: - TextView
    
    func testTextViewDisabledCloseState() {
        let view = createTextView(state: .disabled, text: nil)
        checkView(view: view, named: "Disabled.Close", testName: "TextView")
    }
    
    func testTextViewDisabledOpenState() {
        let view = createTextView(state: .disabled, text: "Text")
        checkView(view: view, named: "Disabled.Open", testName: "TextView")
    }
    
    func testTextViewErrorCloseState() {
        let view = createTextView(state: .error, text: nil)
        checkView(view: view, named: "Error.Close", testName: "TextView")
    }
    
    func testTextViewErrorOpenState() {
        let view = createTextView(state: .error, text: "Text")
        checkView(view: view, named: "Error.Open", testName: "TextView")
    }
    
    func testTextViewNormalCloseState() {
        let view = createTextView(state: .normal, text: nil)
        checkView(view: view, named: "Normal.Close", testName: "TextView")
    }
    
    func testTextViewNormalOpenState() {
        let view = createTextView(state: .normal, text: "Text")
        checkView(view: view, named: "Normal.Open", testName: "TextView")
    }
    
    func testTextViewReadOnlyCloseState() {
        let view = createTextView(state: .readOnly, text: nil)
        checkView(view: view, named: "ReadOnly.Close", testName: "TextView")
    }
    
    func testTextViewReadOnlyOpenState() {
        let view = createTextView(state: .readOnly, text: "Text")
        checkView(view: view, named: "ReadOnly.Open", testName: "TextView")
    }
    
    func testTextViewDefaultCloseState() {
        let view = createTextView(state: .default, text: nil)
        checkView(view: view, named: "Default.Close", testName: "TextView")
    }
    
    func testTextViewDefaultOpenState() {
        let view = createTextView(state: .default, text: "Text")
        checkView(view: view, named: "Default.Open", testName: "TextView")
    }
    
    // MARK: - Private Methods
    
    private func createBankCardTextField(state: TextInputState, text: String?) -> UIView {
        let textField = BankCardTextField()
        textField.state = state
        textField.text = text
        textField.placeholder = "Placeholder"
        textField.info = "Info"
        textField.frame.size = CGSize(width: 200.0, height: 80.0)
        textField.apply(theme: theme)
        return textField
    }
    
    private func createTextField(state: TextInputState, text: String?) -> UIView {
        let textField = TextField()
        textField.state = state
        textField.text = text
        textField.placeholder = "Placeholder"
        textField.info = "Info"
        textField.frame.size = CGSize(width: 200.0, height: 80.0)
        textField.apply(theme: theme)
        return textField
    }
    
    private func createDoubleTextField(state: TextInputState, aligment: DoubleTextField<TextField, TextField>.Alignment) -> UIView {
        let textField = DoubleTextField(
            firstTextField: createTextField(state: .normal, text: nil) as! TextField,
            secondTextField: createTextField(state: .normal, text: nil) as! TextField,
            alignment: aligment)
        textField.state = state
        textField.info = "Info"
        textField.frame.size = CGSize(width: 300.0, height: 80.0)
        textField.apply(theme: theme)
        return textField
    }
    
    private func createInputRangeTextField(state: TextInputState, text: String?) -> UIView {
        let textField = InputRangeTextField()
        textField.state = state
        textField.text = text
        textField.info = "Info"
        textField.placeholder = "Placeholder"
        textField.value = 10
        textField.minimumValue = 0
        textField.maximumValue = 100
        
        textField.frame.size = CGSize(width: 300.0, height: 80.0)
        textField.apply(theme: theme)
        return textField
    }
    
    private func createOTPTextField(state: TextInputState, text: String?) -> UIView {
        let textField = OTPTextField()
        textField.state = state
        textField.text = text
        textField.info = "Info"
        textField.placeholder = "Placeholder"
        
        textField.frame.size = CGSize(width: 300.0, height: 80.0)
        textField.apply(theme: theme)
        return textField
    }
    
    private func createTextView(state: TextInputState, text: String?) -> UIView {
        let textField = TextView()
        textField.state = state
        textField.text = text
        textField.info = "Info"
        textField.placeholder = "Placeholder"
        
        textField.frame.size = CGSize(width: 300.0, height: 80.0)
        textField.apply(theme: theme)
        return textField
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
