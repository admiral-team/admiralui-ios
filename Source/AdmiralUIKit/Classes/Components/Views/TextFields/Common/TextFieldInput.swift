//
//  TextFieldInputView.swift
//  AdmiralUI
//
//  Created on 11.03.2021.
//

import UIKit

/// The state of tex input
public enum TextInputState: Int {
    /// The normal state of the field in which the user can edit textfield
    case normal
    /// The error state is useful to show the user an error
    case error
    /// The disabled state disable user input and hide input text
    case disabled
    /// The read only state disable user to modify textfield
    case readOnly
    
    /// The default value is normal state
    static var `default`: TextInputState {
        return .normal
    }
}

/// The size type of texfield trailing view
public enum TextInputTrailingViewStyle: Int {
    /// The small trailing view size style
    case small
    /// The large trailing view size styele
    case large
    
    /// The default value is small
    static var `default`: TextInputTrailingViewStyle {
        return .small
    }
}

/// Text field delegate like standard UITextFieldDelegate of UIKit framework.
@objc public protocol TextFieldInputDelegate {
    /// Called when the text has changed.
    @objc optional func textFieldInputDidChange(_ textField: TextFieldInput)
    
    /// Asks the delegate whether to begin editing in the specified text field.
    @objc optional func textFieldInputShouldBeginEditing(_ textField: TextFieldInput) -> Bool
    
    /// Tells the delegate when editing begins in the specified text field.
    @objc optional func textFieldInputDidBeginEditing(_ textField: TextFieldInput)
    
    /// Asks the delegate whether to stop editing in the specified text field.
    @objc optional func textFieldInputShouldEndEditing(_ textField: TextFieldInput) -> Bool
    
    /// Tells the delegate when editing stops for the specified text field.
    @objc optional func textFieldInputDidEndEditing(_ textField: TextFieldInput)
    
    /// Tells the delegate when editing stops for the specified text field, and the reason it stopped.
    @objc optional func textFieldInputDidEndEditing(_ textField: TextFieldInput, reason: UITextField.DidEndEditingReason)
    
    /// Asks the delegate whether to change the specified text.
    @objc optional func textFieldInput(_ textField: TextFieldInput, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    
    /// Asks the delegate whether to remove the text field’s current contents.
    @objc optional func textFieldInputShouldClear(_ textField: TextFieldInput) -> Bool

    /// Asks the delegate whether to process the pressing of the Return button for the text field.
    @objc optional func textFieldInputShouldReturn(_ textField: TextFieldInput) -> Bool
    
    /// Tells the delegate when the text selection changes in the specified text field.
    @objc optional func textFieldInputDidChangeSelection(_ textField: TextFieldInput)
}

open class TextFieldInput: UIView {
    
    /// The text field’s delegate.
    public weak var delegate: TextFieldInputDelegate?
        
    /// The text that the text field displays.
    public var text: String? {
        get { return inputTextField.text }
        set {
            inputTextField.text = newValue
            textFieldStateNeedUpdate()
            calculateContentSize()
        }
    }
    
    /// The custom input view to display when the text field becomes the first responder.
    public override var inputView: UIView? {
        get { return inputTextField.inputView  }
        set { inputTextField.inputView = newValue }
    }
    
    /// A Boolean value that indicates whether the text field is currently in edit mode.
    public var isEditing: Bool {
        get { return inputTextField.isEditing }
    }

    /// A view that allocated in the left corner of textField
    public var leftView: UIView? {
        get {
            return inputTextField.leftView
        }
        set {
            inputTextField.leftViewMode = .always
            inputTextField.leftView = newValue
        }
    }

    var onChangeContentSize: ((CGFloat) -> ())?

    let inputTextField = UITextField()

    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    override open func layoutSubviews() {
        super.layoutSubviews()
        inputTextField.invalidateIntrinsicContentSize()
        onChangeContentSize?(inputTextField.intrinsicContentSize.width)
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        inputTextField.delegate = self
        inputTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }

    private func calculateContentSize() {
        inputTextField.invalidateIntrinsicContentSize()
        onChangeContentSize?(inputTextField.intrinsicContentSize.width)
    }

    func textFieldStateNeedUpdate() {}

}


// MARK: - UITextFieldDelegate

extension TextFieldInput: UITextFieldDelegate {
        
    @objc open func textFieldDidChange(_ textField: UITextField) {
        textFieldStateNeedUpdate()
        delegate?.textFieldInputDidChange?(self)
    }
    
    @objc open func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return delegate?.textFieldInputShouldBeginEditing?(self) ?? true
    }
    
    @objc open func textFieldDidBeginEditing(_ textField: UITextField) {
        textFieldStateNeedUpdate()
        delegate?.textFieldInputDidBeginEditing?(self)
    }
    
    @objc open func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return delegate?.textFieldInputShouldBeginEditing?(self) ?? true
    }
    
    @objc open func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        textFieldStateNeedUpdate()
        if delegate?.textFieldInputDidEndEditing(_:) != nil {
            delegate?.textFieldInputDidEndEditing?(self)
        } else {
            delegate?.textFieldInputDidEndEditing?(self, reason: reason)
        }
    }
    
    @objc open func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return self.delegate?.textFieldInput?(self, shouldChangeCharactersIn: range, replacementString: string) ?? true
    }
    
    @objc open func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return delegate?.textFieldInputShouldClear?(self) ?? false
    }

    @objc open func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return delegate?.textFieldInputShouldReturn?(self) ?? false
    }
    
    @objc open func textFieldDidChangeSelection(_ textField: UITextField) {
        delegate?.textFieldInputDidChangeSelection?(self)
    }
    
}

// MARK: - UITextInputTraits

extension TextFieldInput: UITextInputTraits {
    
    /// Identifies whether the text object should disable text copying and in some cases hide the text being entered.
    @objc open var isSecureTextEntry: Bool {
        get { return inputTextField.isSecureTextEntry }
        set { inputTextField.isSecureTextEntry = newValue }
    }
    
    /// A Boolean value that indicates whether the text-entry objects has any text.
    @objc open var hasText: Bool {
        return inputTextField.hasText
    }
    
    /// Insert a character into the displayed text.
    @objc open func insertText(_ text: String) {
        inputTextField.insertText(text)
    }
    
    /// Delete a character from the displayed text.
    @objc open func deleteBackward() {
        inputTextField.deleteBackward()
    }
    
    /// The auto-capitalization style for the text object.
    @objc open var autocapitalizationType: UITextAutocapitalizationType {
        get { return inputTextField.autocapitalizationType }
        set { inputTextField.autocapitalizationType = newValue }
    }
    
    /// The autocorrection style for the text object.
    @objc open var autocorrectionType: UITextAutocorrectionType {
        get { return inputTextField.autocorrectionType }
        set { inputTextField.autocorrectionType = newValue }
    }
    
    /// The spell-checking style for the text object.
    @objc open var spellCheckingType: UITextSpellCheckingType {
        get { return inputTextField.spellCheckingType }
        set { inputTextField.spellCheckingType = newValue }
    }
    
    /// The configuration state for smart quotes.
    @available(iOS 11.0, *)
    @objc open var smartQuotesType: UITextSmartQuotesType {
        get { return inputTextField.smartQuotesType }
        set { inputTextField.smartQuotesType = newValue }
    }
    
    /// The configuration state for smart dashes.
    @available(iOS 11.0, *)
    @objc open var smartDashesType: UITextSmartDashesType {
        get { return inputTextField.smartDashesType }
        set { inputTextField.smartDashesType = newValue }
    }
    
    /// The configuration state for the smart insertion and deletion of space characters.
    @available(iOS 11.0, *)
    @objc open var smartInsertDeleteType: UITextSmartInsertDeleteType {
        get { return inputTextField.smartInsertDeleteType }
        set { inputTextField.smartInsertDeleteType = newValue }
    }
    
    /// The keyboard style associated with the text object.
    @objc open var keyboardType: UIKeyboardType {
        get { return inputTextField.keyboardType }
        set { inputTextField.keyboardType = newValue }
    }
    
    /// The visible title of the Return key.
    @objc open var returnKeyType: UIReturnKeyType {
        get { return inputTextField.returnKeyType }
        set { inputTextField.returnKeyType = newValue }
    }
    
    /// The appearance style of the keyboard that is associated with the text object.
    @objc open var keyboardAppearance: UIKeyboardAppearance {
        get { return inputTextField.keyboardAppearance }
        set { inputTextField.keyboardAppearance = newValue }
    }
    
    /// A Boolean value indicating whether the Return key is automatically enabled when the user is entering text.
    @objc open var enablesReturnKeyAutomatically: Bool {
        get { return inputTextField.enablesReturnKeyAutomatically }
        set { inputTextField.enablesReturnKeyAutomatically = newValue }
    }
    
    /// The semantic meaning expected by a text input area.
    @objc open var textContentType: UITextContentType {
        get { return inputTextField.textContentType }
        set { inputTextField.textContentType = newValue }
    }
    
    /// The text position for the beginning of a document.
    @objc open var beginningOfDocument: UITextPosition {
        return inputTextField.beginningOfDocument
    }
    
    /// The range of selected text in a document.
    @objc open var selectedTextRange: UITextRange? {
        get { return inputTextField.selectedTextRange }
        set { inputTextField.selectedTextRange = newValue }
    }
    
    /// Return the number of UTF-16 characters between one text position and another text position.
    /// - Parameters:
    ///   - from: A custom object that represents a location within a document.
    ///   - toPosition: A custom object that represents another location within document.
    @objc open func offset(from: UITextPosition, to toPosition: UITextPosition) -> Int {
        return inputTextField.offset(from: from, to: toPosition)
    }
    
    /// Returns the text position at a given offset from another text position.
    /// - Parameters:
    ///   - position: A custom UITextPosition object that represents a location in a document.
    ///   - offset: A custom object that represents another location within document.
    @objc open func position(from position: UITextPosition, offset: Int) -> UITextPosition? {
        return inputTextField.position(from: position, offset: offset)
    }
    
    /// Return the range between two text positions.
    /// - Parameters:
    ///   - fromPosition: An object that represents a location in a document.
    ///   - toPosition: An object that represents another location in a document.
    @objc open func textRange(from fromPosition: UITextPosition, to toPosition: UITextPosition) -> UITextRange? {
        return inputTextField.textRange(from: fromPosition, to: toPosition)
    }

}
