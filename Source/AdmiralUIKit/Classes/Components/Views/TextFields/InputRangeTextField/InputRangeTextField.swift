//
//  InputRangeTextField.swift
//  AdmiralUI
//
//  Created on 30.10.2020.
//

import UIKit
import AdmiralTheme

/// Text field delegate like standard UITextFieldDelegate of UIKit framework.
@objc public protocol InputRangeTextFieldDelegate {
    /// Called when the value of slider has changed. Return slider float value.
    @objc optional func inputRangeTextFieldSliderValue(_ slider: InputRangeTextField) -> Float
    
    /// Called when the value of slider has changed. Return text for textfield.
    @objc optional func inputRangeTextFieldSliderValueDidChange(_ slider: InputRangeTextField) -> String?
    
    /// Called when the minimum value of slider has changed. Return text for minimum value label.
    @objc optional func inputRangeTextFieldSliderMinBorderDidChange(_ slider: InputRangeTextField) -> String?
    
    /// Called when the maximum value of slider has changed. Return text for maximum value label.
    @objc optional func inputRangeTextFieldSliderMaxBorderDidChange(_ slider: InputRangeTextField) -> String?
}

public class InputRangeTextField: UIView, AnyAppThemable, AccessibilitySupport {
    
    /// The text field’s delegate.
    public weak var delegate: InputRangeTextFieldDelegate?
    
    /// The textfield state.
    public var state: TextInputState {
        get { return textField.state }
        set { setState(newValue, animated: false) }
    }
    
    /// The slider’s current value.
    public var value: Float {
        get { return slider.value }
        set { slider.value = newValue }
    }
    
    /// The minimum value of the slider.
    public var minimumValue: Float {
        get { return slider.minimumValue }
        set { updateMinValue(newValue) }
    }
    
    /// The maximum value of the slider
    public var maximumValue: Float {
        get { return slider.maximumValue }
        set { updateMaxValue(newValue) }
    }
    
    /// The number of simbols after comma on text.
    public var numberOfSimbolsAfterComma: Int = 0 {
        didSet {
            updateMinValue(minimumValue)
            updateMaxValue(maximumValue)
            updateText()
        }
    }
    
    /// The keyboardType of textField
    public var keyboardType: UIKeyboardType {
        get { return textField.keyboardType }
        set { textField.keyboardType = newValue }
    }
    
    /// The maximum number of lines to use for info.
    public var infoNumberOfLines: Int {
        get { return informerLabel.numberOfLines }
        set { informerLabel.numberOfLines = newValue }
    }
    
    /// The text field’s name.
    public var name: String? {
        get { return textField.name }
        set { textField.name = newValue }
    }
    
    /// The text that the text field displays.
    public var text: String? {
        get { return textField.text }
        set { textField.text = newValue }
    }
    
    // The string that displays when there is no other text in the text field.
    public var placeholder: String? {
        get { return textField.placeholder }
        set { textField.placeholder = newValue }
    }
    
    /// The string that displays some additional info.
    public var info: String? {
        get { return informerLabel.text }
        set { informerLabel.text = newValue }
    }
    
    public var inputTextField: UITextField {
        return textField.inputTextField
    }
    
    /// The text field’s trailing view.
    public var trailingView: UIView? {
        get { return textField.trailingView }
        set { textField.trailingView = newValue }
    }

    public var leadingText: String? {
        get { return textField.leadingText }
        set {
            textField.leadingText = newValue
        }
    }
    
    // MARK: - Internal Properties
    
    let slider = Slider()
    let textField = TextField()
    let minValueLabel = UILabel()
    let maxValueLabel = UILabel()
    let informerLabel = UILabel()
    
    var scheme = InputRangeTextFieldScheme() {
        didSet { updateScheme() }
    }

    // MARK: - AccessibilitySupport
    
    public var adjustsFontForContentSizeCategory: Bool = Appearance.isAccessabilitySupportEnabled {
        didSet { updateFonts() }
    }
    
    // MARK: - Private Properties
    
    private var textFieldState: TextInputState = .normal
    
    // MARK: - Public Methods
    
    /// Initializes and returns a newly allocated view object with the specified frame rectangle.
    public override init(frame: CGRect) {
        super.init(frame: .zero)
        commonInit()
    }
    
    /// Returns an object initialized from data in a given unarchiver.
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    /// Sets the accesibility Ids
    /// - Parameters:
    ///   - textFieldId: String?.
    ///   - sliderThubmImageId: String?.
    ///   - sliderProgressViewId: String?.
    public func setAccessibilityidentifiers(
        textFieldId: String? = nil,
        sliderThubmImageId: String? = nil,
        sliderProgressViewId: String? = nil
    ) {
        textField.inputTextField.accessibilityIdentifier = textFieldId
        slider.thumbImageAccesibilityId = sliderThubmImageId
        slider.progressViewAccesibilityId = sliderProgressViewId
    }

    /// Sets the  text, allowing you to animate the change visually.
    /// - Parameters:
    ///   - text: Text.
    ///   - animated: Specify true to animate the change in text; otherwise, specify false.
    public func setText(_ text: String?, animated: Bool) {
        textField.setText(text, animated: animated)
    }
    
    /// Sets the  state, allowing you to animate the change visually.
    /// - Parameters:
    ///   - state: State.
    ///   - animated: Specify true to animate the change in text; otherwise, specify false.
    public func setState(_ state: TextInputState, animated: Bool) {
        textField.setState(state, animated: animated)
        switch state {
        case .normal, .error, .readOnly:
            slider.isEnabled = true
        case .disabled:
            slider.isEnabled = false
        }
        configure(for: self.state)
    }
    
    // MARK: - AppTheamable
    
    open func apply(theme: AppTheme) {
        self.scheme = InputRangeTextFieldScheme(theme: theme)
    }
        
    // MARK: - Private Methods
    
    private func commonInit() {
        addSubviews()
        configureLayout()
        configureUI()
    }
    
    private func addSubviews() {
        [textField, minValueLabel, maxValueLabel, informerLabel, slider].addToSuperview(self)
    }
    
    private func configureLayout() {
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: leadingAnchor),
            trailingAnchor.constraint(equalTo: textField.trailingAnchor),
            textField.topAnchor.constraint(equalTo: topAnchor),

            slider.leadingAnchor.constraint(equalTo: textField.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: slider.trailingAnchor),
            slider.topAnchor.constraint(equalTo: textField.bottomAnchor),
            
            minValueLabel.leadingAnchor.constraint(equalTo: textField.leadingAnchor),
            minValueLabel.topAnchor.constraint(equalTo: slider.bottomAnchor),
            minValueLabel.widthAnchor.constraint(equalTo: maxValueLabel.widthAnchor, multiplier: 1.0),

            maxValueLabel.leadingAnchor.constraint(equalTo: minValueLabel.trailingAnchor),
            textField.trailingAnchor.constraint(equalTo: maxValueLabel.trailingAnchor),
            maxValueLabel.topAnchor.constraint(equalTo: slider.bottomAnchor),
            
            informerLabel.leadingAnchor.constraint(equalTo: textField.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: informerLabel.trailingAnchor),
            informerLabel.topAnchor.constraint(equalTo: minValueLabel.bottomAnchor),
            informerLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
        
    private func configureUI() {
        apply(theme: defaultTheme)
        clipsToBounds = true
        
        textField.forceOpened = true
        textField.isSeparatorHidden = true
        textField.trailingViewStyle = .small
        
        minValueLabel.backgroundColor = .clear
        maxValueLabel.backgroundColor = .clear
        
        minValueLabel.text = String(minimumValue)
        maxValueLabel.text = String(maximumValue)
        
        minValueLabel.textAlignment = .left
        maxValueLabel.textAlignment = .right
        
        informerLabel.numberOfLines = 0
        
        slider.addTarget(self, action: #selector(sliderDidChange(_:)), for: .valueChanged)
        textField.inputTextField.delegate = self
        textField.inputTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        setState(state, animated: false)

        textField.onChangeContentSize = { [weak self] size in
            self?.textField.contentWidth = size
        }
    }
    
    private func updateMinValue(_ value: Float) {
        slider.minimumValue = value
        minValueLabel.text = delegate?.inputRangeTextFieldSliderMinBorderDidChange?(self) ?? String(format: "%.\(numberOfSimbolsAfterComma)f", value)
            
    }
    
    private func updateMaxValue(_ value: Float) {
        slider.maximumValue = value
        maxValueLabel.text = delegate?.inputRangeTextFieldSliderMaxBorderDidChange?(self) ?? String(format: "%.\(numberOfSimbolsAfterComma)f", value)
    }
    
    private func updateText() {
        textField.text = String(format: "%.\(numberOfSimbolsAfterComma)f", slider.value)
    }
    
    @objc private func sliderDidChange(_ slider: Slider) {
        if let text = delegate?.inputRangeTextFieldSliderValueDidChange?(self) {
            textField.text = text
        } else {
            updateText()
        }
    }
    
    @objc private func textFieldChange(_ textField: UITextField) {
        if let value = Float(textField.text ?? "") {
            self.slider.setValue(value, animated: true)
        }
    }
    
    private func configure(for state: TextInputState) {
        informerLabel.textColor = textField.decorationView.informerLabel.textColor
        minValueLabel.textColor = textField.inputTextField.textColor
        maxValueLabel.textColor = textField.inputTextField.textColor

        switch state {
        case .normal, .error:
            slider.isEnabled = true
        case .disabled, .readOnly:
            slider.isEnabled = false
        }
    }
    
    private func updateScheme() {
        textField.scheme = scheme.textField
        slider.scheme = scheme.slider
        configure(for: state)
        updateFonts()
    }
    
    private func updateFonts() {
        minValueLabel.setDynamicFont(
            font: scheme.valueFont.uiFont,
            textStyle: scheme.valueFont.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory)
        maxValueLabel.setDynamicFont(
            font: scheme.valueFont.uiFont,
            textStyle: scheme.valueFont.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory)
        informerLabel.setDynamicFont(
            font: scheme.textField.informerFont.uiFont,
            textStyle: scheme.textField.informerFont.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory)
    }
        
}

// MARK: - UITextFieldDelegate

extension InputRangeTextField: UITextFieldDelegate {
    
    @objc public func textFieldDidChange(_ textField: TextField) {
        configure(for: state)
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let number = numberFormatter.number(from: text?.replacingOccurrences(of: ",", with: ".") ?? "")
        if let value = delegate?.inputRangeTextFieldSliderValue?(self) {
            slider.setValue(value, animated: true)
        } else if let value = number?.floatValue {
            slider.setValue(value, animated: true)
        } else {
            slider.setValue(minimumValue, animated: true)
        }

        textField.invalidateIntrinsicContentSize()
        self.textField.contentWidth = textField.intrinsicContentSize.width
    }

    public func textFieldDidBeginEditing(_ textField: UITextField) {
        configure(for: state)
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        configure(for: state)
    }
    
}
