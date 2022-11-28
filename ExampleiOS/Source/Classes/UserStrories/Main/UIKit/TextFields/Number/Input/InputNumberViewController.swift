//
//  InputNumberViewController.swift
//  ExampleiOS
//
//  Created by on 24.10.2022.
//  
//
import UIKit
import AdmiralUIKit
import AdmiralTheme

final class InputNumberViewController: ScrollViewController {

    var textFields: [UIView] = []

    // MARK: - Initializers

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    override func apply(theme: AppTheme) {
        super.apply(theme: theme)
        textFields.forEach({ ($0 as? AppThemeCompatible)?.apply(theme: theme) })
    }

    // MARK: - Private Methods

    private func configureUI() {
        configureTextFields()

        textFields.forEach() {
            $0.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview($0)
        }
    }

    private func configureTextFields() {
        let textFieldSix = createInputNumberTextFieldView()
        textFields.append(textFieldSix)
    }

    private func createInputNumberTextFieldView()-> ControlCellView<InputNumberTextField> {
        let inputTextField = InputNumberTextField()
        inputTextField.maximumValue = 0
        inputTextField.maximumValue = 9000000
        inputTextField.value = 0
        inputTextField.titleText = "Optional label"
        inputTextField.textFieldPlaceholder = "0"
        inputTextField.accessibilityIdentifier = "InputNumberTextField"
        inputTextField.plusButtonAccessibilityId = "InputNumberTextFieldPlusButton"
        inputTextField.minusButtonAccessibilityId = "InputNumberTextFieldMinusButton"
        inputTextField.textFieldAccessibilityId = "InputNumberTextFieldInput"

        let statuses = ["Default", "Disabled"]
        let cell = ControlCellView<InputNumberTextField>(textField: inputTextField, statuses: statuses)

        cell.changeStateAction = { state in
            switch state {
            case .normal:
                inputTextField.isEnabled = true
            default:
                inputTextField.isEnabled = false
            }
        }

        return cell
    }
}
