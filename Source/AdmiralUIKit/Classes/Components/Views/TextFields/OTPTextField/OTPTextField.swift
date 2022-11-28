//
//  OTPTextField.swift
//  AdmiralUI
//
//  Created on 22.10.2020.
//

import UIKit
import AdmiralTheme

/// An object that displays an editable text area for enter sms code.
public class OTPTextField: TextFieldInput, AnyAppThemable, AccessibilitySupport {
    
    // MARK: - Public Properties
    
    /// The textfield state.
    public var state: TextInputState {
        get { return textFieldState }
        set { setState(newValue, animated: false) }
    }
    
    /// The string that displays when there is no other text in the text field.
    public var placeholder: String? {
        get { return inputTextField.placeholder }
        set {
            inputTextField.placeholder = newValue
            updatePlaceholder()
        }
    }
    
    /// The string that displays some additional info.
    public var info: String? {
        get { return decorationView.info }
        set { decorationView.info = newValue }
    }
    
    /// The maximum number of lines to use for info.
    public var infoNumberOfLines: Int {
        get { return  decorationView.informerLabel.numberOfLines }
        set { decorationView.informerLabel.numberOfLines = newValue }
    }

    /// Color scheme.
    public var scheme = OTPTextFieldScheme() {
        didSet { updateScheme() }
    }
    
    // MARK: - Internal Properties
    
    var placeholderFont = UIFont.systemFont(ofSize: 16)
    
    var placeholderColor = UIColor.black
    
    // MARK: - AccessibilitySupport
    
    public var adjustsFontForContentSizeCategory: Bool = Appearance.isAccessabilitySupportEnabled {
        didSet { updateFonts() }
    }
    
    private(set) var decorationView: TextInputDecorationView!
    
    // MARK: - Private Properties
    
    private var textFieldState: TextInputState = .normal
    
    // MARK: - Public Methods
    
    /// Asks UIKit to make this object the first responder in its window.
    @discardableResult
    open override func becomeFirstResponder() -> Bool {
        return inputTextField.becomeFirstResponder()
    }

    /// Notifies this object that it has been asked to relinquish its status as first responder in its window.
    @discardableResult
    open override func resignFirstResponder() -> Bool {
        return inputTextField.resignFirstResponder()
    }
    
    /// Sets the  text, allowing you to animate the change visually.
    /// - Parameters:
    ///   - text: Text.
    ///   - animated: Specify true to animate the change in text; otherwise, specify false.
    public func setText(_ text: String?, animated: Bool) {
        inputTextField.text = text
        configureState(anmated: animated)
    }
    
    /// Sets the  state, allowing you to animate the change visually.
    /// - Parameters:
    ///   - state: State.
    ///   - animated: Specify true to animate the change in text; otherwise, specify false.
    public func setState(_ state: TextInputState, animated: Bool) {
        textFieldState = state
        configureState(anmated: animated)
    }
    
    // MARK: - AppTheamable
    
    public func apply(theme: AppTheme) {
        self.scheme = OTPTextFieldScheme(theme: theme)
    }
    
    // MARK: - Private Methods
    
    override func commonInit() {
        super.commonInit()
        addSubviews()
        configureUI()
    }
    
    override func textFieldStateNeedUpdate() {
        configureState(anmated: true)
    }
    
    private func addSubviews() {
        decorationView = TextInputDecorationView(textInput: inputTextField)
        [decorationView].addToSuperview(self)
        decorationView.fillView(view: self).activate()
    }
    
    private func configureUI() {
        apply(theme: defaultTheme)
        clipsToBounds = true

        inputTextField.textAlignment = .center
        
        decorationView.informerLabel.numberOfLines = 0
        decorationView.informerLabel.textAlignment = .center
        decorationView.separatorView.lineWidth = 2.0
        
        var layoutParameters = decorationView.layoutParameters
        layoutParameters.nameLabelHeight = 0
        layoutParameters.textInputMinHeight = 7 * LayoutGrid.halfModule
        layoutParameters.textInputSpacingTop = 3 * LayoutGrid.halfModule
        decorationView.layoutParameters = layoutParameters
        
        decorationView.nameLabel.isHidden = true
        decorationView.placeholderLabel.isHidden = true
        
        configureState(anmated: false)
    }
    
    private func configureState(anmated: Bool) {
        updateTextField()
        
        if anmated {
            UIView.animate(
                withDuration: Durations.Default.half,
                delay: 0,
                options: [.curveEaseInOut],
                animations: {
                    self.updateColors()
                }, completion: nil)
        } else {
            updateColors()
        }
    }
    
    private func updateScheme() {
        updateFonts()
        updateColors()
    }
    
    private func updateFonts() {
        inputTextField.setDynamicFont(
            font: scheme.textFieldFont.uiFont,
            textStyle: scheme.textFieldFont.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory)
        placeholderFont = scheme.placeholderFont.uiFont
        decorationView.informerLabel.setDynamicFont(
            font: scheme.informerFont.uiFont,
            textStyle: scheme.informerFont.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory)
    }

    private func updatePlaceholder() {
        guard let text = inputTextField.placeholder else {
            inputTextField.placeholder = nil
            return
        }
        
        inputTextField.attributedPlaceholder = NSAttributedString(string: text, attributes: [
            .foregroundColor: placeholderColor,
            .font: placeholderFont
        ])
    }
    
    private func updateTextField() {
        inputTextField.isUserInteractionEnabled = (state != .disabled && state != .readOnly)
    }
    
    private func updateColors() {
        inputTextField.textColor = scheme.textColor.uiColor
        inputTextField.tintColor = scheme.tintColor.uiColor
        placeholderColor = scheme.placeholderColor.uiColor
                
        switch state {
        case .normal:
            decorationView.separatorView.lineColor = isEditing ? scheme.tintColor.uiColor : scheme.underlineColor.uiColor
            decorationView.informerLabel.textColor = scheme.underlineColor.uiColor
            decorationView.separatorView.lineMode = .solid
        case .error:
            decorationView.informerLabel.textColor = scheme.errorColor.uiColor
            decorationView.separatorView.lineColor = scheme.errorColor.uiColor
            decorationView.separatorView.lineMode = .solid
        case .disabled:
            decorationView.informerLabel.textColor = scheme.disabledColor.uiColor
            decorationView.separatorView.lineColor = scheme.disabledColor.uiColor
            inputTextField.textColor = scheme.disabledColor.uiColor
            decorationView.separatorView.lineMode = .solid
        case .readOnly:
            decorationView.informerLabel.textColor = scheme.underlineColor.uiColor
            decorationView.separatorView.lineColor = scheme.underlineColor.uiColor
            decorationView.separatorView.lineMode = .dashed(dash: LayoutGrid.halfModule, gap: LayoutGrid.halfModule, phase: 0)
        }
    }
    
}
