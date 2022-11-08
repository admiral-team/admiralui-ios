//
//  DoubleInputRangeTextField.swift
//  AdmiralUIKit
//
//  Created on 18.11.2021.
//

import UIKit
import AdmiralTheme

/// Text field delegate like standard UITextFieldDelegate of UIKit framework.
@objc public protocol DoubleInputRangeTextFieldDelegate {
    /// Called when the value of slider has changed. Return slider float value.
    @objc optional func inputRangeTextFieldSliderValue(_ slider: DoubleInputRangeTextField) -> Float

    /// Called when the value of slider has changed. Return text for textfield.
    @objc optional func inputRangeTextFieldSliderValueDidChange(_ slider: DoubleInputRangeTextField) -> String?

    /// Called when the minimum value of slider has changed. Return text for minimum value label.
    @objc optional func inputRangeTextFieldSliderMinBorderDidChange(_ slider: DoubleInputRangeTextField) -> String?

    /// Called when the maximum value of slider has changed. Return text for maximum value label.
    @objc optional func inputRangeTextFieldSliderMaxBorderDidChange(_ slider: DoubleInputRangeTextField) -> String?
}

public class DoubleInputRangeTextField: UIView, AnyAppThemable, AccessibilitySupport {
    
    private enum Constants {
        static let leadingLabelFrame = CGRect(x: .zero, y: .zero, width: LayoutGrid.tripleModule, height: LayoutGrid.halfModule * 5)
        static let fromLabelText = "От"
        static let toLabelText = "До"
    }

    /// The text field’s delegate.
    public weak var delegate: DoubleInputRangeTextFieldDelegate?

    /// The textfield state.
    public var state: TextInputState {
        get { return leftTextField.state }
        set { setState(newValue, animated: false) }
    }

    /// The slider’s minimum current value.
    public var lowerValue: Float {
        get { return slider.lowerValue }
        set { slider.lowerValue = newValue }
    }

    /// The slider’s maximum current value.
    public var upperValue: Float {
        get { return slider.upperValue }
        set { slider.upperValue = newValue }
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

    public var leadingText: String? {
        get { return leftTextField.leadingText }
        set {
            leftTextField.leadingText = newValue
        }
    }

    public var trailingText: String? {
        get { return trailingLabel.text }
        set {
            trailingLabel.text = newValue
            updateLayoutConstraints()
        }
    }

    /// The keyboardType of textField
    public var keyboardType: UIKeyboardType {
        get { return leftTextField.keyboardType }
        set {
            leftTextField.keyboardType = newValue
            rightTextField.keyboardType = newValue
        }
    }

    /// The maximum number of lines to use for info.
    public var infoNumberOfLines: Int {
        get { return informerLabel.numberOfLines }
        set { informerLabel.numberOfLines = newValue }
    }

    /// The text field’s name.
    public var name: String? {
        get { return leftTextField.name }
        set { leftTextField.name = newValue }
    }

    /// The text that the text field displays.
    public var minValueText: String? {
        get { return leftTextField.text }
        set { leftTextField.text = newValue }
    }

    /// The text that the text field displays.
    public var maxValueText: String? {
        get { return rightTextField.text }
        set { rightTextField.text = newValue }
    }

    // The string that displays when there is no other text in the min text field.
    public var minTextPlaceholder: String? {
        get { return leftTextField.placeholder }
        set { leftTextField.placeholder = newValue }
    }

    // The string that displays when there is no other text in the max text field.
    public var maxTextPlaceholder: String? {
        get { return rightTextField.placeholder }
        set { rightTextField.placeholder = newValue }
    }

    /// The string that displays some additional info.
    public var info: String? {
        get { return informerLabel.text }
        set { informerLabel.text = newValue }
    }

    /// The text field with lower range value
    public var minInputTextField: UITextField {
        return leftTextField.inputTextField
    }

    /// The text field with upper range value
    public var maxInputTextField: UITextField {
        return rightTextField.inputTextField
    }

    /// The text field’s trailing view.
    public var trailingView: UIView? {
        get { return leftTextField.trailingView }
        set { leftTextField.trailingView = newValue }
    }

    // MARK: - Internal Properties

    let slider = DoubleSlider()
    let leftTextField = TextField()
    let rightTextField = TextField()
    let minValueLabel = UILabel()
    let maxValueLabel = UILabel()
    let informerLabel = UILabel()
    let fromLabel = UILabel()
    let trailingLabel = UILabel()
    let destinationLabel = UILabel()

    // MARK: - Private Properties

    private var trailingLabelConstraint = NSLayoutConstraint()
    private var rightTextFieldTrailingConstraints = NSLayoutConstraint()

    var scheme = InputRangeTextFieldScheme() {
        didSet { updateScheme() }
    }

    // MARK: - AccessibilitySupport

    public var adjustsFontForContentSizeCategory: Bool = Appearance.isAccessabilitySupportEnabled {
        didSet { updateFonts() }
    }

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

    /// Sets the  text, allowing you to animate the change visually.
    /// - Parameters:
    ///   - minValue: Text.
    ///   - maxValue: Text.
    ///   - animated: Specify true to animate the change in text; otherwise, specify false.
    public func setText(
        _ minValue: String?,
        _ maxValue: String?,
        animated: Bool
    ) {
        leftTextField.setText(minValue, animated: animated)
        rightTextField.setText(maxValue, animated: animated)
    }

    /// Sets the accesibility Ids
     /// - Parameters:
     ///   - leftTextFieldId: String?.
     ///   - rightTextFieldId: String?.
     ///   - doubleSliderLowerImageId: String?.
     ///   - doubleSliderUpperImageId: String?.
     ///   - doubleSliderProgressViewId: String?.
     public func setAccessibilityidentifiers(
         leftTextFieldId: String? = nil,
         rightTextFieldId: String? = nil,
         doubleSliderLowerImageId: String? = nil,
         doubleSliderUpperImageId: String? = nil,
         doubleSliderProgressViewId: String? = nil
     ) {
         leftTextField.inputTextField.accessibilityIdentifier = leftTextFieldId
         rightTextField.inputTextField.accessibilityIdentifier = rightTextFieldId
         slider.loweThubmImageAccesibilityId = doubleSliderLowerImageId
         slider.upperThumbImageViewAccesibilityId = doubleSliderUpperImageId
         slider.progressViewAccesibilityId = doubleSliderProgressViewId
     }

    /// Sets the  state, allowing you to animate the change visually.
    /// - Parameters:
    ///   - state: State.
    ///   - animated: Specify true to animate the change in text; otherwise, specify false.
    public func setState(_ state: TextInputState, animated: Bool) {
        leftTextField.setState(state, animated: animated)
        rightTextField.setState(state, animated: animated)
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
        let leadingFromView = UIView(frame: Constants.leadingLabelFrame)
        leadingFromView.addSubview(fromLabel)
        let leadingDestinationView = UIView(frame: Constants.leadingLabelFrame)
        leadingDestinationView.addSubview(destinationLabel)
        leftTextField.leadingView = leadingFromView
        rightTextField.leadingView = leadingDestinationView
        [leftTextField, minValueLabel, maxValueLabel, informerLabel, slider, rightTextField, trailingLabel].addToSuperview(self)
    }

    private func configureLayout() {
        trailingLabelConstraint = trailingLabel.leadingAnchor.constraint(equalTo: rightTextField.trailingAnchor, constant: LayoutGrid.doubleModule)
        rightTextFieldTrailingConstraints = rightTextField.trailingAnchor.constraint(equalTo: trailingAnchor)


        NSLayoutConstraint.activate([
            leftTextField.leadingAnchor.constraint(equalTo: leadingAnchor),
            leftTextField.trailingAnchor.constraint(equalTo: trailingAnchor),
            leftTextField.topAnchor.constraint(equalTo: topAnchor),

            slider.leadingAnchor.constraint(equalTo: leftTextField.leadingAnchor),
            leftTextField.trailingAnchor.constraint(equalTo: slider.trailingAnchor),
            slider.topAnchor.constraint(equalTo: leftTextField.bottomAnchor),

            minValueLabel.leadingAnchor.constraint(equalTo: leftTextField.leadingAnchor),
            minValueLabel.topAnchor.constraint(equalTo: slider.bottomAnchor),
            minValueLabel.widthAnchor.constraint(equalTo: maxValueLabel.widthAnchor, multiplier: 1.0),

            maxValueLabel.leadingAnchor.constraint(equalTo: minValueLabel.trailingAnchor),
            leftTextField.trailingAnchor.constraint(equalTo: maxValueLabel.trailingAnchor),
            maxValueLabel.topAnchor.constraint(equalTo: slider.bottomAnchor),

            informerLabel.leadingAnchor.constraint(equalTo: leftTextField.leadingAnchor),
            leftTextField.trailingAnchor.constraint(equalTo: informerLabel.trailingAnchor),
            informerLabel.topAnchor.constraint(equalTo: minValueLabel.bottomAnchor),
            informerLabel.bottomAnchor.constraint(equalTo: bottomAnchor),

            rightTextField.bottomAnchor.constraint(equalTo: trailingLabel.bottomAnchor, constant: LayoutGrid.module),
            rightTextField.topAnchor.constraint(equalTo: topAnchor),
            
            trailingLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            trailingLabelConstraint,
            rightTextFieldTrailingConstraints,
        ])
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        leftTextField.leftLabelWidth = fromLabel.frame.width
        rightTextField.leftLabelWidth = fromLabel.frame.width
    }

    private func updateLayoutConstraints() {
        guard trailingText != nil else {
            trailingLabelConstraint.constant = .zero
            rightTextFieldTrailingConstraints.isActive = true
            return
        }
        rightTextFieldTrailingConstraints.isActive = false
        trailingLabelConstraint.constant = LayoutGrid.module
    }

    private func configureUI() {
        apply(theme: defaultTheme)
        clipsToBounds = true

        leftTextField.forceOpened = true
        leftTextField.isSeparatorHidden = true
        leftTextField.trailingViewStyle = .small
        
        rightTextField.forceOpened = true
        rightTextField.isSeparatorHidden = true
        rightTextField.trailingViewStyle = .small

        minValueLabel.backgroundColor = .clear
        maxValueLabel.backgroundColor = .clear
        
        minValueLabel.text = String(minimumValue)
        maxValueLabel.text = String(maximumValue)

        fromLabel.frame = Constants.leadingLabelFrame
        fromLabel.text = Constants.fromLabelText
        fromLabel.textAlignment = .left

        destinationLabel.frame = Constants.leadingLabelFrame
        destinationLabel.text = Constants.toLabelText
        destinationLabel.textAlignment = .left

        minValueLabel.textAlignment = .left
        maxValueLabel.textAlignment = .right

        informerLabel.numberOfLines = 0

        slider.addTarget(self, action: #selector(sliderDidChange(_:)), for: .valueChanged)

        rightTextField.inputTextField.delegate = self
        rightTextField.inputTextField.addTarget(self, action: #selector(rightFieldDidChange(_:)), for: .editingChanged)

        leftTextField.inputTextField.delegate = self
        leftTextField.inputTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)

        leftTextField.onChangeContentSize = { [weak self] size in
            self?.leftTextField.contentWidth = size
        }

        setState(state, animated: false)
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
        leftTextField.text = String(format: "%.\(numberOfSimbolsAfterComma)f", slider.lowerValue)
        rightTextField.text = String(format: "%.\(numberOfSimbolsAfterComma)f", slider.upperValue)
    }

    @objc private func sliderDidChange(_ slider: Slider) {
        updateText()
    }

    private func configure(for state: TextInputState) {
        informerLabel.textColor = leftTextField.decorationView.informerLabel.textColor
        minValueLabel.textColor = leftTextField.inputTextField.textColor
        maxValueLabel.textColor = leftTextField.inputTextField.textColor
        fromLabel.textColor = leftTextField.decorationView.informerLabel.textColor
        destinationLabel.textColor = leftTextField.decorationView.informerLabel.textColor
        switch state {
        case .normal, .error:
            slider.isEnabled = true
        case .disabled, .readOnly:
            slider.isEnabled = false
        }
    }

    private func updateScheme() {
        leftTextField.scheme = scheme.textField
        rightTextField.scheme = scheme.textField
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
        trailingLabel.setDynamicFont(
            font: scheme.textField.textFieldFont.uiFont,
            textStyle: scheme.textField.textFieldFont.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory)
        informerLabel.setDynamicFont(
            font: scheme.textField.informerFont.uiFont,
            textStyle: scheme.textField.informerFont.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory)
        fromLabel.setDynamicFont(
            font: scheme.textField.informerFont.uiFont,
            textStyle: scheme.textField.informerFont.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory)
        destinationLabel.setDynamicFont(
            font: scheme.textField.informerFont.uiFont,
            textStyle: scheme.textField.informerFont.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory)
    }

}

// MARK: - UITextFieldDelegate

extension DoubleInputRangeTextField: UITextFieldDelegate {

    @objc public func textFieldDidChange(_ textField: TextField) {
        configure(for: state)
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let number = numberFormatter.number(from: minValueText?.replacingOccurrences(of: ",", with: ".") ?? "")
        if let value = delegate?.inputRangeTextFieldSliderValue?(self) {
            slider.setValue(value, animated: true)
        } else if let value = number?.floatValue {
            slider.setValue(value, animated: true)
        } else {
            slider.setValue(minimumValue, animated: true)
        }
        textField.invalidateIntrinsicContentSize()
        self.leftTextField.contentWidth = textField.intrinsicContentSize.width
    }

    @objc public func rightFieldDidChange(_ textField: TextField) {
        configure(for: state)
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let number = numberFormatter.number(from: maxValueText?.replacingOccurrences(of: ",", with: ".") ?? "")
        if let value = delegate?.inputRangeTextFieldSliderValue?(self) {
            slider.setValue(upperValue: value, animated: true)
        } else if let _ = number?.floatValue {
            guard let text = rightTextField.text,
                  let floatValue = Float(text)
            else {
                return
            }
            slider.setValue(upperValue: floatValue, animated: true)
        } else {
            slider.setValue(upperValue: minimumValue, animated: true)
        }
    }

    public func textFieldDidBeginEditing(_ textField: UITextField) {
        configure(for: state)
    }

    public func textFieldDidEndEditing(_ textField: UITextField) {
        configure(for: state)
    }

}
