//
//  DoubleTextFieldViewController.swift
//  ExampleiOS
//
//  Created on 10.11.2020.
//

import UIKit
import AdmiralUIKit

final class DoubleTextFieldViewController: ScrollViewController {
    
    // MARK: - Private Properties
    
    private var textFields: [UIView] = []
    
    // MARK: - Initializers
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideOutlineSegment(false)
        configureUI()
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
        outlineSegmentControl.setTitles(["Default", "Read Only", "Error", "Disabled"])
        outlineSegmentControl.selectedSegmentIndex = 0
        outlineSegmentControl.addTarget(self, action: #selector(segmentedValueChanged), for: .valueChanged)
    }
    
    private func configureTextFields() {
        let textField1 = createDoubleTextFieldView(title: "50/50", ratio: .ratio(ration: 1))
        textFields.append(textField1)
        
        let textField2 = createDoubleTextFieldView(title: "70/30", ratio: .fixedSecond(second: view.frame.width * 0.3))
        textFields.append(textField2)
    }

    private func createDoubleTextFieldView(title: String, ratio: DoubleTextField<TextField, TextField>.Alignment) -> TextFieldTextView {
        let firstTextField = TextField()
        firstTextField.name = "Optional label"
        firstTextField.text = "Text"
        firstTextField.placeholder = "Placeholder"
        firstTextField.info = "Additional text"
        firstTextField.inputTextAccessibilityId = "FirstTextFieldInput"
        firstTextField.accessibilityIdentifier = "FirstTextField"

        let secondTextField = TextField()
        secondTextField.name = "Optional label"
        secondTextField.text = "Text"
        secondTextField.placeholder = "Placeholder"
        secondTextField.info = "Additional text"
        secondTextField.inputTextAccessibilityId = "SecondTextFieldInput"
        secondTextField.accessibilityIdentifier = "SecondTextField"
        
        let textField = DoubleTextField(
            firstTextField: firstTextField,
            secondTextField: secondTextField,
            alignment: ratio)
        
        let cell = TextFieldTextView(textField: textField, titleText: title)
        
        return cell
    }
    
    @objc private func didTap() {
        view.endEditing(true)
    }
    
    @objc private func segmentedValueChanged(_ control: OutlineSliderTabSegmentedControl) {
        var state: TextInputState = .normal
        switch control.selectedSegmentIndex {
        case 0:
            state = .normal
        case 1:
            state = .readOnly
        case 2:
            state = .error
        case 3:
            state = .disabled
        default:
            break
        }
        textFields.forEach({ ($0 as? TextFieldTextView)?.state = state })
    }
    
}
