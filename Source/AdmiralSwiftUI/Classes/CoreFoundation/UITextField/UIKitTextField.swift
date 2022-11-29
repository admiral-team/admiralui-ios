//
//  NewUIKitTextField.swift
//  AdmiralSwiftUI
//
//  Created on 17.12.2021.
//

import SwiftUI

@available(iOS 14.0.0, *)
struct UIKitTextField: UIViewRepresentable {

    // MARK: - Coordinator

    class Coordinator: NSObject, UITextFieldDelegate {
        
        var textInput: Binding<String?>
        var formatter: Formatter?
        var onSubmit: (() -> Void)?
        var onCursorPosition: ((Int, Int, String) -> (Int))?
        
        private var previousCursorPosition: Int?

        init(
            text: Binding<String?>,
            formatter: Formatter?,
            onSubmit: (() -> Void)?,
            onCursorPosition: ((Int, Int, String) -> (Int))?
        ) {
            self.textInput = text
            self.formatter = formatter
            self.onSubmit = onSubmit
            self.onCursorPosition = onCursorPosition
        }

        func textFieldShouldReturn(_: UITextField) -> Bool {
            if let onSubmit = onSubmit { onSubmit() }

            return true
        }
        
        @objc func textFieldDidChange(_ textField: UITextField) {
            guard let formatter = formatter else {
                self.textInput.wrappedValue = textField.text
                return
            }
            
            let updatedText = textField.text ?? ""
            
            var targetCursorPosition = 0
            if let startPosition = textField.selectedTextRange?.start {
                targetCursorPosition = textField.offset(from: textField.beginningOfDocument, to: startPosition)
            }
            let selectedRange = textField.selectedTextRange
            
            var formattedStringContainer: AnyObject?
            var errorDescription: NSString?
            formatter.getObjectValue(&formattedStringContainer, for: updatedText, errorDescription: &errorDescription)
            
            if let formattedStringContainer = formattedStringContainer {
                textField.text = String(describing: formattedStringContainer)
                self.textInput.wrappedValue = String(describing: formattedStringContainer)
            }

            if let offset = onCursorPosition?(previousCursorPosition ?? 0, targetCursorPosition, updatedText),
               let newPosition = textField.position(from: textField.beginningOfDocument, offset: offset) {
                textField.selectedTextRange = textField.textRange(from: newPosition, to: newPosition)
            } else {
                textField.selectedTextRange = selectedRange
            }
        }
        
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            if let selectedRange = textField.selectedTextRange {
                previousCursorPosition = textField.offset(from: textField.beginningOfDocument, to: selectedRange.start)
            }
            return true
        }
        
    }

    // MARK: - Internal Properties

    var text: Binding<String?>
    var isResponder: Binding<Bool>? = nil
    var isFirstResponder: Bool?

    var placeholder: String?
    var isSecured: Bool = false
    var formatter: Formatter?

    var keyboard: UIKeyboardType = .default
    var returnKeyType: UIReturnKeyType = .default
    var autocapitalizationType: UITextAutocapitalizationType = .none
    var autocorrectionType: UITextAutocorrectionType = .no
    var textContentType: UITextContentType? = nil
    var canPerformActionPaste: Bool = true

    var font: UIFont?
    var textColor: UIColor = .black
    var placeholderColor: UIColor = .gray
    var textAlignment: NSTextAlignment = .left
    var tintColor: UIColor = .blue

    var onSubmit: (() -> Void)?
    var onCursorPosition: ((Int, Int, String) -> (Int))?
    var updateWidth: Binding<CGFloat>? = nil
    var accessibilityIdentifier: String?

    // MARK: - Initializer

    init(
        text: Binding<String?>,
        isResponder: Binding<Bool>? = nil,
        isFirstResponder: Bool? = nil,
        placeholder: String? = nil,
        isSecured: Bool = false,
        formatter: Formatter? = nil,
        keyboard: UIKeyboardType = .default,
        returnKeyType: UIReturnKeyType = .default,
        autocapitalizationType: UITextAutocapitalizationType = .none,
        autocorrectionType: UITextAutocorrectionType = .no,
        textContentType: UITextContentType? = nil,
        canPerformActionPaste: Bool = true,
        textColor: UIColor = .black,
        placeholderColor: UIColor = .gray,
        tintColor: UIColor = .blue,
        textAlignment: NSTextAlignment = .left,
        font: UIFont? = nil,
        onSubmit: (() -> Void)? = nil,
        onCursorPosition: ((Int, Int, String) -> (Int))? = nil,
        updateWidth: Binding<CGFloat>? = nil,
        accessibilityIdentifier: String? = nil)
    {
        self.text = text
        self.isResponder = isResponder
        self.isFirstResponder = isFirstResponder
        self.placeholder = placeholder
        self.isSecured = isSecured
        self.formatter = formatter
        self.keyboard = keyboard
        self.returnKeyType = returnKeyType
        self.autocapitalizationType = autocapitalizationType
        self.autocorrectionType = autocorrectionType
        self.textContentType = textContentType
        self.canPerformActionPaste = canPerformActionPaste
        self.textColor = textColor
        self.placeholderColor = placeholderColor
        self.tintColor = tintColor
        self.textAlignment = textAlignment
        self.font = font
        self.onSubmit = onSubmit
        self.onCursorPosition = onCursorPosition
        self.updateWidth = updateWidth
        self.accessibilityIdentifier = accessibilityIdentifier
    }

    // MARK: - Internal Properties

    func makeUIView(context: UIViewRepresentableContext<UIKitTextField>) -> ResponderUITextField {
        let textField = ResponderUITextField(frame: .zero)
        textField.accessibilityIdentifier = accessibilityIdentifier
        textField.setContentHuggingPriority(.defaultHigh, for: .vertical)
        textField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        textField.delegate = context.coordinator

        textField.addTarget(context.coordinator, action: #selector(context.coordinator.textFieldDidChange), for: .editingChanged)
        
        if context.environment.isEnabled {
            DispatchQueue.main.async {
                if isResponder?.wrappedValue ?? false {
                    textField.becomeFirstResponder()
                }
            }
        }
        
        return textField
    }

    func makeCoordinator() -> UIKitTextField.Coordinator {
        Coordinator(
            text: text,
            formatter: formatter,
            onSubmit: onSubmit,
            onCursorPosition: onCursorPosition
        )
    }

    func updateUIView(_ uiView: ResponderUITextField, context: Context) {
        context.coordinator.textInput = text
        uiView.isFirstResponderBinding = isResponder
        
        updateTextField(uiView)
        
        updateResponderChain: do {
            DispatchQueue.main.async {
                if let isFocused = isResponder, uiView.window != nil {
                    if isFocused.wrappedValue && !uiView.isFirstResponder {
                        uiView.becomeFirstResponder()
                    } else if !isFocused.wrappedValue && uiView.isFirstResponder {
                        uiView.resignFirstResponder()
                    }
                } else if let isFirstResponder = isFirstResponder, uiView.window != nil {
                    if isFirstResponder && !uiView.isFirstResponder, context.environment.isEnabled {
                        uiView.becomeFirstResponder()
                    } else if !isFirstResponder && uiView.isFirstResponder {
                        uiView.resignFirstResponder()
                    }
                }
            }
        }

        updateSizes(uiView: uiView)
    }

    private func updateSizes(uiView: UITextField) {
        DispatchQueue.main.async {
            self.updateWidth?.wrappedValue = uiView.intrinsicContentSize.width
        }
    }
    
    private func updateTextField(_ textFieldView: UITextField) {
        let selectedRange = textFieldView.selectedTextRange
        let updateSelectedTextRange = (textFieldView.text?.count ?? 0) == (text.wrappedValue?.count ?? 0)
        textFieldView.text = text.wrappedValue
        textFieldView.isSecureTextEntry = isSecured
        textFieldView.autocapitalizationType = autocapitalizationType
        textFieldView.autocorrectionType = autocorrectionType
        textFieldView.keyboardType = keyboard
        textFieldView.returnKeyType = returnKeyType
        textFieldView.textColor = textColor
        textFieldView.font = font
        textFieldView.textAlignment = textAlignment
        textFieldView.tintColor = tintColor
        textFieldView.isAccessibilityElement = accessibilityIdentifier != nil ? true : false
        textFieldView.accessibilityIdentifier = accessibilityIdentifier
        textFieldView.textContentType = textContentType
        (textFieldView as? ResponderUITextField)?.canPerformActionPaste = canPerformActionPaste
        if placeholder != nil {
            textFieldView.attributedPlaceholder = NSAttributedString(
                string: placeholder!,
                attributes: [NSAttributedString.Key.foregroundColor: placeholderColor]
            )
        }
        if updateSelectedTextRange {
            textFieldView.selectedTextRange = selectedRange
        }
    }

}
