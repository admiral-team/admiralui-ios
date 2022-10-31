//
//  InputNumberDefaultViewController.swift
//  ExampleiOS
//
//  Created by on 24.10.2022.
//  
//

import UIKit
import AdmiralUIKit
import AdmiralTheme

final class InputNumberDefaultViewController: ScrollViewController {

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

    private func createInputNumberTextFieldView()-> ControlCellView<InputNumber> {
        let inputTextField = InputNumber()
        inputTextField.text = "Optional label"
        inputTextField.value = 1
        inputTextField.minimumValue = 0
        inputTextField.maximumValue = 20000

        let statuses = ["Default", "Disabled"]
        let cell = ControlCellView<InputNumber>(textField: inputTextField, statuses: statuses)

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
