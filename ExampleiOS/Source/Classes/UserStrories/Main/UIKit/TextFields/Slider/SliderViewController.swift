//
//  SliderViewController.swift
//  ExampleiOS
//
//  Created on 10.11.2020.
//

import AdmiralUIKit
import AdmiralTheme
import UIKit

final class SliderViewController: ScrollViewController {
    
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
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTap))
        tap.cancelsTouchesInView = false
        scrollView.addGestureRecognizer(tap)
        
        configureTextFields()
        
        textFields.forEach() {
            $0.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview($0)
        }
    }
    
    private func configureTextFields() {
        let textFieldSix = createInputRangeTextFieldView(
            name: "Optional label",
            text: "Text",
            placeholder: "Placeholder",
            info: "Additional text",
            changeStateAction: { textField, state in
                textField.state = state
            })

        let doubleFieldSix = createDoubleInputRangeTextFieldView(
            name: "Optional label",
            text: "Text",
            minTextPlaceholder: "placeholder",
            maxTextPlaceholder: "placeholder",
            info: "Additional text",
            changeStateAction: { textField, state in
                textField.state = state
            })
        textFields.append(textFieldSix)
        textFields.append(doubleFieldSix)
    }
    
    @objc func didTap() {
        view.endEditing(true)
    }

    private func createInputRangeTextFieldView(
        name: String? = nil,
        text: String? = nil,
        placeholder: String? = nil,
        info: String? = nil,
        changeStateAction: (( InputRangeTextField, TextInputState) -> Void)? = nil) -> ControlCellView<InputRangeTextField> {
        
        let inputRangeTextField = InputRangeTextField()
        inputRangeTextField.name = name
        inputRangeTextField.placeholder = placeholder
        inputRangeTextField.info = info
        inputRangeTextField.minimumValue = 10
        inputRangeTextField.maximumValue = 1000
        inputRangeTextField.text = String(Int(inputRangeTextField.value))
        inputRangeTextField.keyboardType = .numberPad
        
        let statuses = ["Default", "Error", "Disabled"]
        let cell = ControlCellView<InputRangeTextField>(textField: inputRangeTextField, statuses: statuses)
        
        cell.changeStateAction = { state in
            changeStateAction?(inputRangeTextField, state)
        }
        
        return cell
    }

    private func createDoubleInputRangeTextFieldView(
        name: String? = nil,
        text: String? = nil,
        minTextPlaceholder: String? = nil,
        maxTextPlaceholder: String? = nil,
        info: String? = nil,
        changeStateAction: (( DoubleInputRangeTextField, TextInputState) -> Void)? = nil) -> ControlCellView<DoubleInputRangeTextField> {

        let doubleInputRangeTextField = DoubleInputRangeTextField()
        doubleInputRangeTextField.name = name
        doubleInputRangeTextField.minTextPlaceholder = minTextPlaceholder
        doubleInputRangeTextField.maxTextPlaceholder = maxTextPlaceholder
        doubleInputRangeTextField.info = info
        doubleInputRangeTextField.minimumValue = 10
        doubleInputRangeTextField.maximumValue = 1000
        doubleInputRangeTextField.lowerValue = 100
        doubleInputRangeTextField.upperValue = 500
        doubleInputRangeTextField.minValueText = String(Int(doubleInputRangeTextField.lowerValue))
        doubleInputRangeTextField.maxValueText = String(Int(doubleInputRangeTextField.upperValue))
        doubleInputRangeTextField.keyboardType = .numberPad

        let statuses = ["Default", "Error", "Disabled"]
        let cell = ControlCellView<DoubleInputRangeTextField>(textField: doubleInputRangeTextField, statuses: statuses)

        cell.changeStateAction = { state in
            changeStateAction?(doubleInputRangeTextField, state)
        }

        return cell
    }


}
