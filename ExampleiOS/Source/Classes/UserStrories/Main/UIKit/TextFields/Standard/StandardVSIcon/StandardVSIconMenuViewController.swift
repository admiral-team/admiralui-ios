//
//  StandardVSIconMenuViewController.swift
//  ExampleiOS
//
//  Created on 10.11.2020.
//

import AdmiralUIKit
import AdmiralTheme
import UIKit

final class StandardVSIconMenuViewController: ScrollViewController {
    
    // MARK: - Private Properties
    
    private var textFields: [UIView] = []
    private let binder = KeyboardBinder()
    
    // MARK: - Initializers
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideOutlineSegment(false)
        configureUI()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        binder.bindToKeyboardNotifications()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        binder.unbindFromKeyboardNotifications()
    }
    
    // MARK: - AnyAppThemable
    
    override func apply(theme: AppTheme) {
        super.apply(theme: theme)
        textFields.forEach({
            ($0 as? AppThemeCompatible)?.apply(theme: theme)
        })
    }
    
    // MARK: - Private Methods
    
    private func configureUI() {
        binder.bindable = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTap))
        tap.cancelsTouchesInView = false
        scrollView.addGestureRecognizer(tap)
        
        configureTextFields()
        
        textFields.forEach() {
            $0.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview($0)
        }
        
        outlineSegmentControl.setTitles(["Default", "Error", "Disabled", "Read Only"])
        outlineSegmentControl.selectedSegmentIndex = 0
        outlineSegmentControl.addTarget(self, action: #selector(segmentedValueChanged), for: .valueChanged)
    }
    
    private func configureTextFields() {
        let textFieldOne = createTextFieldView()
        textFields.append(textFieldOne)
        
        let textFieldTwo = createSecureTextFieldView()
        textFields.append(textFieldTwo)
        
        let textFieldThree = createTextView()
        textFields.append(textFieldThree)
    }
    
    private func createTextFieldView() -> TextFieldTextView {
        let textField = TextField()
        textField.name = "Optional label"
        textField.text = "Text"
        textField.placeholder = "Placeholder"
        textField.info = "Additional text"
        
        let cell = TextFieldTextView(
            textField: textField,
            titleText: "Basic")

        return cell
    }
    
    private func createSecureTextFieldView() -> TextFieldTextView {
        let secureTextField = SecureTextField()
        secureTextField.textField.name = "Optional label"
        secureTextField.textField.text = "Text"
        secureTextField.textField.placeholder = "Placeholder"
        secureTextField.textField.info = "Additional text"
        
        let cell = TextFieldTextView(
            textField: secureTextField,
            titleText: "Masked")
        
        return cell
    }
    
    private func createTextView() -> TextFieldTextView {
        let textView = TextView()
        textView.name = "Optional label"
        textView.text = "Text"
        textView.placeholder = "Placeholder"
        textView.info = "Additional text"
        
        let cell = TextFieldTextView(
            textField: textView,
            titleText: "Text View")
        
        return cell
    }
    
    @objc private func didTap() {
        view.endEditing(true)
    }
    
    @objc private func segmentedValueChanged(_ control: OutlineSliderTabSegmentedControl) {
        guard let state = TextInputState(rawValue: control.selectedSegmentIndex) else {
             return
         }
        
        textFields.forEach({ ($0 as? TextFieldTextView)?.state = state })
    }
    
}

// MARK: - KeyboardBindable

extension StandardVSIconMenuViewController: KeyboardBindable {
    
    func keyboardFrameWillShow(info: KeyboardInfo) {
        scrollView.contentInset.bottom = info.frame.height
    }
    
    func keyboardFrameWillHide(info: KeyboardInfo) {
        scrollView.contentInset.bottom = 0
    }
    
}
