//
//  SMSCodeViewController.swift
//  ExampleiOS
//
//  Created on 10.11.2020.
//

import UIKit
import AdmiralUIKit

final class SMSCodeViewController: ScrollViewController {
    
    var textFields: [UIView] = []
    
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
        
        outlineSegmentControl.setTitles(["Default", "Error", "Disabled"])
        outlineSegmentControl.selectedSegmentIndex = 0
        outlineSegmentControl.addTarget(self, action: #selector(segmentedValueChanged), for: .valueChanged)
    }
    
    private func configureTextFields() {
        let textFieldFour = createSmsTextFieldView()
        textFields.append(textFieldFour)
    }
    
    @objc private func didTap() {
        view.endEditing(true)
    }
    
    private func createSmsTextFieldView() -> TextFieldTextView {
        let textField = OTPTextField()
        textField.placeholder = "СМС-код"
        textField.info = "Additional text"
        textField.keyboardType = .numberPad
        
        let cell = TextFieldTextView(textField: textField, titleText: "")
        
        return cell
    }
    
    @objc private func segmentedValueChanged(_ control: OutlineSliderTabSegmentedControl) {
        guard let state = TextInputState(rawValue: control.selectedSegmentIndex) else {
             return
         }
        
        textFields.forEach({ ($0 as? TextFieldTextView)?.state = state })
    }
   
}
