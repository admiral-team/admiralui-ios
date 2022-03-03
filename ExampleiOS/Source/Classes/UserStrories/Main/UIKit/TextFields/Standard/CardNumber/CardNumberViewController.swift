//
//  CardNumberViewController.swift
//  ExampleiOS
//
//  Created on 10.11.2020.
//

import UIKit
import AdmiralUIKit
import AdmiralTheme

final class CardNumberViewController: ScrollViewController {
    
    // MARK: - Private Properties
    
    private var textFields: [TextFieldTextView] = []
    private var bankCardTextField: CardTextField!
    private var previousTextFieldContent: String?
    private var previousSelection: UITextRange?
    
    // MARK: - Initializers
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideOutlineSegment(false)
        configureUI()
    }
    
    override func apply(theme: AppTheme) {
        super.apply(theme: theme)
        [textFields].forEach({ ($0 as? AppThemeCompatible)?.apply(theme: theme) })
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
        let textField = createBankTextFieldView()
        textFields.append(textField)
    }
    
    private func createBankTextFieldView() -> TextFieldTextView {
        let textField = CardTextField()
        textField.textField.text = "1111 2222 3333 4444"
        textField.textField.placeholder = "1111 2222 3333 4444"
        textField.textField.info = "Additional text"
        textField.textField.keyboardType = .numberPad
        textField.textField.delegate = self
        
        bankCardTextField = textField

        let cell = TextFieldTextView(textField: textField, titleText: "", state: .crediCard)
        
        return cell
    }
    
    @objc private func didTap() {
        view.endEditing(true)
    }
    
    @objc private func segmentedValueChanged(_ control: OutlineSliderTabSegmentedControl) {
        guard let state = TextInputState(rawValue: control.selectedSegmentIndex) else { return }
        textFields.forEach({ $0.state = state })
    }
    
}

// MARK: - BankCardFieldDelegate

extension CardNumberViewController: TextFieldInputDelegate {
    
    @objc func textFieldInputDidChange(_ textField: TextFieldInput) {
        var targetCursorPosition = 0
        if let startPosition = textField.selectedTextRange?.start {
            targetCursorPosition = textField.offset(from: textField.beginningOfDocument, to: startPosition)
        }
        
        var cardNumberWithoutSpaces = ""
        if let text = textField.text {
            cardNumberWithoutSpaces = self.removeNonDigits(string: text, andPreserveCursorPosition: &targetCursorPosition)
        }
        
        if cardNumberWithoutSpaces.count > 16 {
            textField.text = previousTextFieldContent
            textField.selectedTextRange = previousSelection
            return
        }
        
        let cardNumberWithSpaces = self.insertSpacesEveryFourDigitsIntoString(string: cardNumberWithoutSpaces, andPreserveCursorPosition: &targetCursorPosition)
        textField.text = cardNumberWithSpaces
        
        if let targetPosition = textField.position(from: textField.beginningOfDocument, offset: targetCursorPosition) {
            textField.selectedTextRange = textField.textRange(from: targetPosition, to: targetPosition)
        }
    }

    func removeNonDigits(string: String, andPreserveCursorPosition cursorPosition: inout Int) -> String {
        var digitsOnlyString = ""
        let originalCursorPosition = cursorPosition
        
        for i in Swift.stride(from: 0, to: string.count, by: 1) {
            let characterToAdd = string[string.index(string.startIndex, offsetBy: i)]
            if characterToAdd >= "0" && characterToAdd <= "9" {
                digitsOnlyString.append(characterToAdd)
            } else if i < originalCursorPosition {
                cursorPosition -= 1
            }
        }
        
        return digitsOnlyString
    }

    func insertSpacesEveryFourDigitsIntoString(string: String, andPreserveCursorPosition cursorPosition: inout Int) -> String {
        var stringWithAddedSpaces = ""
        let cursorPositionInSpacelessString = cursorPosition
        
        for i in Swift.stride(from: 0, to: string.count, by: 1) {
            if i > 0 && (i % 4) == 0 {
                stringWithAddedSpaces.append(contentsOf: " ")
                if i < cursorPositionInSpacelessString {
                    cursorPosition += 1
                }
            }
            let characterToAdd = string[string.index(string.startIndex, offsetBy: i)]
            stringWithAddedSpaces.append(characterToAdd)
        }
        
        return stringWithAddedSpaces
    }
    
    func textFieldInput(_ textField: TextFieldInput, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        previousTextFieldContent = textField.text
        previousSelection = textField.selectedTextRange
        return true
    }
    
}
