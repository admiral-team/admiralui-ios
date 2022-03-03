//
//  NewUIKitTextView.swift
//  AdmiralSwiftUI
//
//  Created on 17.12.2021.
//

import SwiftUI

@available(iOS 14.0.0, *)
struct UIKitTextView: UIViewRepresentable {

    // MARK: - Coordinator

    class Coordinator: NSObject, UITextViewDelegate {
        
        enum Constants {
            static let returnText = "\n"
        }
        
        var textInput: Binding<String?>
        var formatter: Formatter?
        var onSubmit: (() -> Void)?
        var shouldChangeText: ((String?) -> (Bool))?
        var onCursorPosition: ((Int, Int, String) -> (Int))?
        
        private var previousCursorPosition: Int?

        init(
            text: Binding<String?>,
            formatter: Formatter?,
            onSubmit: (() -> Void)?,
            shouldChangeText: ((String?) -> (Bool))?,
            onCursorPosition: ((Int, Int, String) -> (Int))?
        ) {
            self.textInput = text
            self.formatter = formatter
            self.onSubmit = onSubmit
            self.shouldChangeText = shouldChangeText
            self.onCursorPosition = onCursorPosition
        }

        func textViewDidChange(_ textView: UITextView) {
            // WORKAROUND: Work for solve problem "Modifying state during view update, this will cause undefined behavior."
            DispatchQueue.main.async {
                self.updateTextWithFormatter(textView: textView)
            }
        }

        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            if let selectedRange = textView.selectedTextRange {
                previousCursorPosition = textView.offset(from: textView.beginningOfDocument, to: selectedRange.start)
            }
            
            if text == Constants.returnText, let onSubmit = self.onSubmit {
                onSubmit()
                return false
            }
            
            if let str = textView.text, let textRange = Range(range, in: str) {
                let updatedText = str.replacingCharacters(in: textRange, with: text)
                
                if let shouldChangeText = self.shouldChangeText {
                    return shouldChangeText(updatedText)
                }
            }
            
            return true
        }
        
        // MARK: - Private Methods
        
        private func updateTextWithFormatter(textView: UITextView) {
            guard let formatter = formatter else {
                textInput.wrappedValue = textView.text
                return
            }
            
            let updatedText = textView.text ?? ""
            
            var formattedStringContainer: AnyObject?
            var errorDescription: NSString?
            formatter.getObjectValue(&formattedStringContainer, for: updatedText, errorDescription: &errorDescription)
            
            var targetCursorPosition = 0
            if let startPosition = textView.selectedTextRange?.start {
                targetCursorPosition = textView.offset(from: textView.beginningOfDocument, to: startPosition)
            }
            let selectedRange = textView.selectedTextRange
            
            if let formattedStringContainer = formattedStringContainer {
                textInput.wrappedValue = String(describing: formattedStringContainer)
            }
            
            if let offset = onCursorPosition?(previousCursorPosition ?? 0, targetCursorPosition, updatedText),
               let newPosition = textView.position(from: textView.beginningOfDocument, offset: offset) {
                textView.selectedTextRange = textView.textRange(from: newPosition, to: newPosition)
            } else {
                textView.selectedTextRange = selectedRange
            }
        }
    }

    // MARK: - Internal Properties

    var text: Binding<String?>
    var isResponder: Binding<Bool>?
    var isFirstResponder: Bool?

    var formatter: Formatter?
    var shouldChangeText: ((String?) -> (Bool))?

    var fixWidth: CGFloat?
    var updateHeight: Binding<CGFloat>

    var fixHeight: CGFloat?
    var maxWidth: CGFloat?
    var maxHeight: CGFloat?
    var updateWidth: Binding<CGFloat>

    var isEnabled: Bool = true
    var isScrollEnabled: Bool = false

    var keyboard: UIKeyboardType = .default
    var returnKeyType: UIReturnKeyType = .default
    var autocapitalizationType: UITextAutocapitalizationType = .none
    var autocorrectionType: UITextAutocorrectionType = .yes

    var font: UIFont?
    var textColor: UIColor = .black
    var tintColor: UIColor = .blue

    var textAlignment: NSTextAlignment = .left

    var onSubmit: (() -> Void)?
    var onCursorPosition: ((Int, Int, String) -> (Int))?
    var accessibilityIdentifier: String?
    
    var horizontalPadding: CGFloat = 0.0

    // MARK: - Private Properties

    private var heightConstraint: NSLayoutConstraint?
    private var widthConstraint: NSLayoutConstraint?

    private let textView = UITextView(frame: .zero)
    private let minimumTextViewSize: CGFloat = 30.0

    // MARK: - Initializer

    init(
        text: Binding<String?>,
        isResponder: Binding<Bool>? = nil,
        isFirstResponder: Bool? = nil,
        formatter: Formatter? = nil,
        shouldChangeText: ((String?) -> (Bool))? = nil,
        fixWidth: CGFloat,
        maxHeight: CGFloat? = nil,
        updateHeight: Binding<CGFloat> = .constant(0.0),
        isEnabled: Bool = true,
        isScrollEnabled: Bool = false,
        keyboard: UIKeyboardType = .default,
        returnKeyType: UIReturnKeyType = .default,
        autocapitalizationType: UITextAutocapitalizationType = .none,
        autocorrectionType: UITextAutocorrectionType = .yes,
        textColor: UIColor = .black,
        tintColor: UIColor = .blue,
        font: UIFont? = nil,
        textAlignment: NSTextAlignment = .left,
        onSubmit: (() -> Void)? = nil,
        onCursorPosition: ((Int, Int, String) -> (Int))? = nil,
        accessibilityIdentifier: String? = nil,
        horizontalPadding: CGFloat = 0.0
    ) {
        self.text = text
        self.formatter = formatter
        self.maxHeight = maxHeight
        self.shouldChangeText = shouldChangeText
        self.isResponder = isResponder
        self.isFirstResponder = isFirstResponder
        self.updateHeight = updateHeight
        self.updateWidth = .constant(0.0)
        self.fixWidth = fixWidth
        self.isEnabled = isEnabled
        self.isScrollEnabled = isScrollEnabled
        self.keyboard = keyboard
        self.returnKeyType = returnKeyType
        self.autocapitalizationType = autocapitalizationType
        self.autocorrectionType = autocorrectionType
        self.textColor = textColor
        self.tintColor = tintColor
        self.textAlignment = textAlignment
        self.font = font
        self.onSubmit = onSubmit
        self.onCursorPosition = onCursorPosition
        self.accessibilityIdentifier = accessibilityIdentifier
        self.horizontalPadding = horizontalPadding
    }
    
    init(
        text: Binding<String?>,
        isResponder: Binding<Bool>? = nil,
        isFirstResponder: Bool? = nil,
        formatter: Formatter? = nil,
        shouldChangeText: ((String?) -> (Bool))? = nil,
        fixHeight: CGFloat,
        maxWidth: CGFloat,
        updateWidth: Binding<CGFloat> = .constant(0.0),
        isEnabled: Bool = true,
        isScrollEnabled: Bool = false,
        keyboard: UIKeyboardType = .default,
        returnKeyType: UIReturnKeyType = .default,
        autocapitalizationType: UITextAutocapitalizationType = .none,
        autocorrectionType: UITextAutocorrectionType = .yes,
        textColor: UIColor = .black,
        tintColor: UIColor = .blue,
        font: UIFont? = nil,
        textAlignment: NSTextAlignment = .left,
        onSubmit: (() -> Void)? = nil,
        onCursorPosition: ((Int, Int, String) -> (Int))? = nil,
        accessibilityIdentifier: String? = nil,
        horizontalPadding: CGFloat = 0.0
    ) {
        self.text = text
        self.formatter = formatter
        self.shouldChangeText = shouldChangeText
        self.isResponder = isResponder
        self.isFirstResponder = isFirstResponder
        self.updateHeight = .constant(0.0)
        self.updateWidth = updateWidth
        self.fixHeight = fixHeight
        self.maxWidth = maxWidth
        self.isEnabled = isEnabled
        self.isScrollEnabled = isScrollEnabled
        self.keyboard = keyboard
        self.returnKeyType = returnKeyType
        self.autocapitalizationType = autocapitalizationType
        self.autocorrectionType = autocorrectionType
        self.textColor = textColor
        self.tintColor = tintColor
        self.font = font
        self.textAlignment = textAlignment
        self.onSubmit = onSubmit
        self.onCursorPosition = onCursorPosition
        self.accessibilityIdentifier = accessibilityIdentifier
        self.horizontalPadding = horizontalPadding
    }

    // MARK: - Internal Properties

    func makeUIView(context: UIViewRepresentableContext<UIKitTextView>) -> ResponderUITextView {
        let textView = ResponderUITextView(frame: .zero)
        textView.accessibilityIdentifier = accessibilityIdentifier
        textView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        textView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        textView.delegate = context.coordinator
        setConstraints(textView: textView)
        
        if context.environment.isEnabled {
            DispatchQueue.main.async {
                if isResponder?.wrappedValue ?? false {
                    textView.becomeFirstResponder()
                }
            }
        }
        
        return textView
    }

    func makeCoordinator() -> UIKitTextView.Coordinator {
        Coordinator(
            text: text,
            formatter: formatter,
            onSubmit: onSubmit,
            shouldChangeText: shouldChangeText,
            onCursorPosition: onCursorPosition
        )
    }

    func updateUIView(_ uiView: ResponderUITextView, context: Context) {
        uiView.isFirstResponderBinding = isResponder
        updateIfNeeded(textView: uiView)
        
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
    
    func updateTextField(_ textView: UITextView) {
        let isUpdateSelectedTextRange = textView.text != (text.wrappedValue ?? "")
        DispatchQueue.main.async {
            let selectedRange = textView.selectedTextRange
            textView.isEditable = isEnabled
            textView.isScrollEnabled = isScrollEnabled
            textView.text = text.wrappedValue
            textView.autocapitalizationType = autocapitalizationType
            textView.autocorrectionType = autocorrectionType
            textView.keyboardType = keyboard
            textView.returnKeyType = returnKeyType
            textView.textColor = textColor
            textView.font = font
            textView.tintColor = tintColor
            textView.isAccessibilityElement = accessibilityIdentifier != nil ? true : false
            textView.accessibilityIdentifier = accessibilityIdentifier
            textView.textAlignment = textAlignment
            textView.backgroundColor = .clear
            if isUpdateSelectedTextRange, textView.isFirstResponder {
                textView.selectedTextRange = selectedRange
            }
        }
    }
    
    // MARK: - Private Methods

    private func updateIfNeeded(textView: UITextView) {
        guard
            textView.textColor != textColor ||
                textView.font != font ||
                textView.tintColor != tintColor ||
                textView.isEditable != isEnabled ||
                textView.isScrollEnabled != isScrollEnabled ||
                textView.text != (text.wrappedValue ?? "") ||
                textView.autocapitalizationType != autocapitalizationType ||
                textView.autocorrectionType != autocorrectionType ||
                textView.keyboardType != keyboard ||
                textView.returnKeyType != returnKeyType
        else { return }
        updateTextField(textView)
    }
    
    private func updateSizes(uiView: UITextView) {
        guard !(text.wrappedValue ?? "").isEmpty else {
            DispatchQueue.main.async {
                if fixWidth != nil {
                    self.updateHeight.wrappedValue = LayoutGrid.halfModule * 9
                } else if fixHeight != nil {
                    self.updateWidth.wrappedValue = LayoutGrid.tripleModule
                }
            }
            return
        }

        DispatchQueue.main.async {
            if fixWidth != nil, updateHeight.wrappedValue != uiView.contentSize.height {
                self.updateHeight.wrappedValue = uiView.contentSize.height
            } else if fixHeight != nil, updateWidth.wrappedValue != uiView.contentSize.width {
                self.updateWidth.wrappedValue = uiView.contentSize.width
            }
        }
    }

    private func setConstraints(textView: UITextView) {
        textView.translatesAutoresizingMaskIntoConstraints = false

        if let fixWidth = fixWidth {
            var constraints = [NSLayoutConstraint]()
            let widthConstraint = textView.widthAnchor.constraint(equalToConstant: fixWidth + horizontalPadding)
            constraints.append(contentsOf: [
                widthConstraint,
                textView.heightAnchor.constraint(greaterThanOrEqualToConstant: LayoutGrid.halfModule * 9)
            ])
            if let maxHeight = maxHeight {
                constraints.append(textView.heightAnchor.constraint(lessThanOrEqualToConstant: maxHeight))
            }
            NSLayoutConstraint.activate(constraints)
        } else if let fixHeight = fixHeight {
            var constraints = [NSLayoutConstraint]()
            let heightConstraint = textView.heightAnchor.constraint(equalToConstant: fixHeight)
            constraints.append(contentsOf: [
                heightConstraint,
                textView.widthAnchor.constraint(greaterThanOrEqualToConstant: LayoutGrid.tripleModule)])
            if let maxWidth = maxWidth {
                constraints.append(textView.widthAnchor.constraint(lessThanOrEqualToConstant: maxWidth))
            }
            NSLayoutConstraint.activate(constraints)
        }
    }

}



