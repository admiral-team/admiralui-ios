//
//  TextInputView.swift
//  AdmiralUI
//
//  Created on 11.03.2021.
//

import UIKit

/// Text view delegate like standard UITextFieldView of UIKit framework.
@objc public protocol TextViewInputDelegate {
    /// Asks the delegate whether to begin editing in the specified text view.
    @objc optional func textViewInputShouldBeginEditing(_ textView: TextViewInput) -> Bool
    
    /// Asks the delegate whether to stop editing in the specified text view.
    @objc optional func textViewInputShouldEndEditing(_ textView: TextViewInput) -> Bool
    
    /// Tells the delegate when editing of the specified text view begins.
    @objc optional func textViewInputDidBeginEditing(_ textView: TextViewInput)
    
    /// Tells the delegate when editing of the specified text view ends.
    @objc optional func textViewInputDidEndEditing(_ textView: TextViewInput)
    
    /// Asks the delegate whether to replace the specified text in the text view.
    @objc optional func textViewInput(_ textView: TextViewInput, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool
    
    /// Tells the delegate when the user changes the text or attributes in the specified text view.
    @objc optional func textViewInputDidChange(_ textView: TextViewInput)
    
    /// Tells the delegate when the text selection changes in the specified text view.
    @objc optional func textViewInputDidChangeSelection(_ textView: TextViewInput)
    
    /// Asks the delegate whether the specified text view allows the specified type of user interaction with the specified URL in the specified range of text.
    @objc optional func textViewInput(_ textView: TextViewInput, shouldInteractWithURL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool
    
    /// Asks the delegate whether the specified text view allows the specified type of user interaction with the provided text attachment in the specified range of text.
    @objc optional func textViewInput(_ textView: TextViewInput, shouldInteractWithTextAttachment: NSTextAttachment, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool
}

open class TextViewInput: UIView {
    
    /// The text view’s delegate.
    public weak var delegate: TextViewInputDelegate?
        
    /// The text that the text field displays.
    public var text: String? {
        get { return inputTextView.text }
        set {
            inputTextView.text = newValue
            textViewStateNeedUpdate()
        }
    }
    
    /// The custom input view to display when the text field becomes the first responder.
    public override var inputView: UIView? {
        get { return inputTextView.inputView  }
        set { inputTextView.inputView = newValue }
    }

    /// The input text accessibility identifier
    public var inputTextAccessibilityId: String? {
        get {
            return inputTextView.accessibilityIdentifier
        } set {
            inputTextView.accessibilityIdentifier = newValue
        }
    }
    
    /// A Boolean value that indicates whether the text field is currently in edit mode.
    public var isEditing: Bool {
        get { return isTextViewEditing }
    }
    
    let inputTextView = UITextView()
    private var isTextViewEditing: Bool = false
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        inputTextView.delegate = self
    }
    
    func textViewStateNeedUpdate() {
        //
    }
    
}

// MARK: - UITextFieldDelegate

extension TextViewInput: UITextViewDelegate {
        
    @objc open func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        return delegate?.textViewInputShouldBeginEditing?(self) ?? true
    }

    @objc open func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        return delegate?.textViewInputShouldEndEditing?(self) ?? true
    }

    @objc open func textViewDidBeginEditing(_ textView: UITextView) {
        isTextViewEditing = true
        textViewStateNeedUpdate()
        delegate?.textViewInputDidBeginEditing?(self)
    }

    @objc open func textViewDidEndEditing(_ textView: UITextView) {
        isTextViewEditing = false
        textViewStateNeedUpdate()
        delegate?.textViewInputDidEndEditing?(self)
    }

    @objc open func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return delegate?.textViewInput?(self, shouldChangeTextIn: range, replacementText: text) ?? true
    }

    @objc open func textViewDidChange(_ textView: UITextView) {
        textViewStateNeedUpdate()
        delegate?.textViewInputDidChange?(self)
    }

    @objc open func textViewDidChangeSelection(_ textView: UITextView) {
        delegate?.textViewInputDidChangeSelection?(self)
    }

    @objc open func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        return delegate?.textViewInput?(self, shouldInteractWithURL: URL, in: characterRange, interaction: interaction) ?? true
    }

    @objc open func textView(_ textView: UITextView, shouldInteractWith textAttachment: NSTextAttachment, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        return delegate?.textViewInput?(self, shouldInteractWithTextAttachment: textAttachment, in: characterRange, interaction: interaction) ?? true
    }
    
}

// MARK: - UITextInputTraits

extension TextViewInput: UITextInputTraits {
    
    /// Identifies whether the text object should disable text copying and in some cases hide the text being entered.
    @objc open var isSecureTextEntry: Bool {
        get { return inputTextView.isSecureTextEntry }
        set { inputTextView.isSecureTextEntry = newValue }
    }
    
    /// A Boolean value that indicates whether the text-entry objects has any text.
    @objc open var hasText: Bool {
        return inputTextView.hasText
    }
    
    /// Insert a character into the displayed text.
    @objc open func insertText(_ text: String) {
        inputTextView.insertText(text)
    }
    
    /// Delete a character from the displayed text.
    @objc open func deleteBackward() {
        inputTextView.deleteBackward()
    }
    
    /// The auto-capitalization style for the text object.
    @objc open var autocapitalizationType: UITextAutocapitalizationType {
        get { return inputTextView.autocapitalizationType }
        set { inputTextView.autocapitalizationType = newValue }
    }
    
    /// The autocorrection style for the text object.
    @objc open var autocorrectionType: UITextAutocorrectionType {
        get { return inputTextView.autocorrectionType }
        set { inputTextView.autocorrectionType = newValue }
    }
    
    /// The spell-checking style for the text object.
    @objc open var spellCheckingType: UITextSpellCheckingType {
        get { return inputTextView.spellCheckingType }
        set { inputTextView.spellCheckingType = newValue }
    }
    
    /// The configuration state for smart quotes.
    @available(iOS 11.0, *)
    @objc open var smartQuotesType: UITextSmartQuotesType {
        get { return inputTextView.smartQuotesType }
        set { inputTextView.smartQuotesType = newValue }
    }
    
    /// The configuration state for smart dashes.
    @available(iOS 11.0, *)
    @objc open var smartDashesType: UITextSmartDashesType {
        get { return inputTextView.smartDashesType }
        set { inputTextView.smartDashesType = newValue }
    }
    
    /// The configuration state for the smart insertion and deletion of space characters.
    @available(iOS 11.0, *)
    @objc open var smartInsertDeleteType: UITextSmartInsertDeleteType {
        get { return inputTextView.smartInsertDeleteType }
        set { inputTextView.smartInsertDeleteType = newValue }
    }
    
    /// The keyboard style associated with the text object.
    @objc open var keyboardType: UIKeyboardType {
        get { return inputTextView.keyboardType }
        set { inputTextView.keyboardType = newValue }
    }
    
    /// The visible title of the Return key.
    @objc open var returnKeyType: UIReturnKeyType {
        get { return inputTextView.returnKeyType }
        set { inputTextView.returnKeyType = newValue }
    }
    
    /// The appearance style of the keyboard that is associated with the text object.
    @objc open var keyboardAppearance: UIKeyboardAppearance {
        get { return inputTextView.keyboardAppearance }
        set { inputTextView.keyboardAppearance = newValue }
    }
    
    /// A Boolean value indicating whether the Return key is automatically enabled when the user is entering text.
    @objc open var enablesReturnKeyAutomatically: Bool {
        get { return inputTextView.enablesReturnKeyAutomatically }
        set { inputTextView.enablesReturnKeyAutomatically = newValue }
    }
    
    /// The semantic meaning expected by a text input area.
    @objc open var textContentType: UITextContentType {
        get { return inputTextView.textContentType }
        set { inputTextView.textContentType = newValue }
    }
    
    /// The text position for the beginning of a document.
    @objc open var beginningOfDocument: UITextPosition {
        return inputTextView.beginningOfDocument
    }
    
    /// Return the number of UTF-16 characters between one text position and another text position.
    /// - Parameters:
    ///   - from: A custom object that represents a location within a document.
    ///   - toPosition: A custom object that represents another location within document.
    @objc open func offset(from: UITextPosition, to toPosition: UITextPosition) -> Int {
        return inputTextView.offset(from: from, to: toPosition)
    }
    
    /// Returns the text position at a given offset from another text position.
    /// - Parameters:
    ///   - position: A custom UITextPosition object that represents a location in a document.
    ///   - offset: A custom object that represents another location within document.
    @objc open func position(from position: UITextPosition, offset: Int) -> UITextPosition? {
        return inputTextView.position(from: position, offset: offset)
    }
    
    /// Return the range between two text positions.
    /// - Parameters:
    ///   - fromPosition: An object that represents a location in a document.
    ///   - toPosition: An object that represents another location in a document.
    @objc open func textRange(from fromPosition: UITextPosition, to toPosition: UITextPosition) -> UITextRange? {
        return inputTextView.textRange(from: fromPosition, to: toPosition)
    }

}
