//
//  InputNumberTextField.swift
//  AdmiralUIResources
//
//  Created by on 24.10.2022.
//  
//

import AdmiralTheme
import AdmiralUIResources
import UIKit
/**
 InputNumberTextField - A object that displays an editable text area with incrementing or decrementing a value.
 You can create a InputNumberTextField by specifying the following parameters in the initializer
 ## Initializer parameters:
 - titleText - leading text
 - value - the numeric value of the stepper
 - minimumValue - the lowest possible numeric value for the stepper
 - maximumValue - the highest possible numeric value for the stepper
 - stepValue - the step, or increment, value for the stepper. The default value for this property is 1.

 ## Example to create InputNumberTextField:
 # Code
 ```
 let inputTextField = InputNumberTextField()
 inputTextField.maximumValue = 0
 inputTextField.maximumValue = 9000000
 inputTextField.value = 0
 inputTextField.titleText = "Optional label"
 inputTextField.textFieldPlaceholder = "0"
 ```
*/
public class InputNumberTextField: UIControl, AnyAppThemable, AccessibilitySupport {

    // MARK: - Constants

    private enum Constants {
        static let height: CGFloat = LayoutGrid.halfModule * 9
        static let buttonHeight: CGFloat = LayoutGrid.halfModule * 9
        static let buttonWidth: CGFloat = LayoutGrid.halfModule * 9
        static let titleHeight: CGFloat = LayoutGrid.halfModule * 5
        static let spacing: CGFloat = LayoutGrid.halfModule / 2
        static let tick: TimeInterval = 0.25
        static let countTick: Float = 0.25

        static let firstStepMultiplier: Double = 5
        static let secondStepMultiplier: Double = 10
        static let thirdStepMultiplier: Double = 100

        enum TextField {
            static let defaultWidth: CGFloat = 48.0
            static let maxWidth: CGFloat = 102.0
        }
    }

    // MARK: - Public Properties

    /// The textfield state.
    public var textFieldState: TextInputState {
        get { return textField.state }
        set { setState(newValue, animated: false) }
    }

    /// A Boolean value indicating whether the control is in the enabled state.
    public override var isEnabled: Bool {
        didSet {
            configure(for: state)
            textFieldState = state == .disabled ? .disabled : .normal
        }
    }

    /// The keyboardType of textField
    public var keyboardType: UIKeyboardType {
        get { return textField.keyboardType }
        set { textField.keyboardType = newValue }
    }

    /// The text field’s name.
    public var name: String? {
        get { return textField.name }
        set { textField.name = newValue }
    }

    /// The text field placeholder text
    public var textFieldPlaceholder: String? {
        get { return textField.placeholder }
        set { textField.placeholder = newValue }
    }

    /// The numeric value of the stepper.
    public var value: Double = 0 {
        didSet {
            updateTextFieldText()
        }
    }

    /// The step, or increment, value for the stepper. The default value for this property is 1.
    public var stepValue: Double = 1.0 {
        didSet { inputStepValue = stepValue }
    }

    /// The lowest possible numeric value for the stepper.
    public var minimumValue: Double = 0 {
        didSet { updateTextFieldText() }
    }

    /// The highest possible numeric value for the stepper.
    public var maximumValue: Double = .infinity {
        didSet { updateTextFieldText() }
    }

    // The text that the label displays.
    public var titleText: String? {
        get { return titleLabel.text }
        set { titleLabel.text = newValue }
    }

    /// The textField
    public var inputTextField: UITextField {
        return textField.inputTextField
    }

    // MARK: - Internal Properties

    public var scheme = InputNumberTextFieldScheme() {
        didSet { updateScheme() }
    }

    // MARK: - AccessibilitySupport

    public var adjustsFontForContentSizeCategory: Bool = Appearance.isAccessabilitySupportEnabled {
        didSet { updateFonts() }
    }

    // MARK: - Private Properties

    private let minusButton = CustomButton()
    private let plusButton = CustomButton()
    private let textField = TextField()
    private let titleLabel = UILabel()

    private var inputStepValue: Double = 1.0
    private var timer: Timer?
    private var runCount: Float = 0

    private let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        return formatter
    }()

    private lazy var textFieldWidth: NSLayoutConstraint = {
        return textField.widthAnchor.constraint(equalToConstant: Constants.TextField.defaultWidth)
    }()

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
        configure(for: textFieldState)
    }

    // MARK: - AppTheamable

    open func apply(theme: AppTheme) {
        self.scheme = InputNumberTextFieldScheme(theme: theme)
    }

    // MARK: - Private Methods

    private func commonInit() {
        addSubviews()
        configureLayout()
        configureUI()
    }

    private func addSubviews() {
        [titleLabel, textField, minusButton, plusButton].addToSuperview(self)
    }

    private func configureLayout() {
        NSLayoutConstraint.activate([
            plusButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            trailingAnchor.constraint(equalTo: plusButton.trailingAnchor),
            plusButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight),
            plusButton.widthAnchor.constraint(equalToConstant: Constants.buttonWidth),

            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: Constants.titleHeight),

            minusButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            minusButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight),
            minusButton.widthAnchor.constraint(equalToConstant: Constants.buttonWidth),
            minusButton.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: Constants.spacing),

            textField.leadingAnchor.constraint(equalTo: minusButton.trailingAnchor, constant: Constants.spacing),
            plusButton.leadingAnchor.constraint(equalTo: textField.trailingAnchor, constant: Constants.spacing),
            textFieldWidth,
            textField.heightAnchor.constraint(equalToConstant: Constants.height),
            textField.topAnchor.constraint(equalTo: topAnchor),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    private func configureUI() {
        apply(theme: defaultTheme)
        clipsToBounds = true
        configureTextField()
        configureButtons()
        setState(textFieldState, animated: false)
    }

    private func configureTextField() {
        textField.forceOpened = true
        textField.isSeparatorHidden = true
        textField.trailingViewStyle = .small

        textField.inputTextField.delegate = self
        textField.inputTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)

        textField.onChangeContentSize = { [weak self] width in
            self?.textField.contentWidth = width
            self?.updateTextFieldWidth(width: width)
        }

        updateTextFieldLayoutParametets()
    }

    private func updateTextFieldLayoutParametets() {
        var layoutParameters = textField.decorationView.layoutParameters
        layoutParameters.nameLabelHeight = .zero
        layoutParameters.textInputMinHeight = 7 * LayoutGrid.halfModule
        if let text = textField.text {
            if text.isEmpty {
                textField.inputTextField.textAlignment = .natural
                layoutParameters.placeholderSpacingLeading = .zero
                layoutParameters.placeholderSpacingTop = -LayoutGrid.halfModule / 2
                layoutParameters.textInputSpacingLeading = LayoutGrid.halfModule * 5
            } else {
                textField.inputTextField.textAlignment = .center
                layoutParameters.textInputSpacingLeading = .zero
            }
        }
        textField.decorationView.layoutParameters = layoutParameters
    }

    private func configureButtons() {
        minusButton.setImage(Asset.Service.Outline.minusOutline.image, for: .normal)
        plusButton.setImage(Asset.Service.Outline.plusOutline.image, for: .normal)

        minusButton.setCornerRadius(LayoutGrid.module, for: .normal)
        plusButton.setCornerRadius(LayoutGrid.module, for: .normal)

        minusButton.setMaskedCorners(corners: [.layerMinXMaxYCorner, .layerMinXMinYCorner], for: .normal)
        plusButton.setMaskedCorners(corners: [.layerMaxXMinYCorner, .layerMaxXMaxYCorner], for: .normal)

        minusButton.setNeedsLayout()
        minusButton.layoutIfNeeded()

        let minusTapGesture = UITapGestureRecognizer(target: self, action: #selector(tapMinus))
        minusTapGesture.cancelsTouchesInView = false
        minusButton.addGestureRecognizer(minusTapGesture)

        let plusTapGesture = UITapGestureRecognizer(target: self, action: #selector(tapPlus))
        plusTapGesture.cancelsTouchesInView = false
        plusButton.addGestureRecognizer(plusTapGesture)

        let minusLongGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleMinusLongPress))
        minusLongGesture.minimumPressDuration = 1.0
        minusLongGesture.cancelsTouchesInView = false
        minusButton.addGestureRecognizer(minusLongGesture)

        let plusLongGesture = UILongPressGestureRecognizer(target: self, action: #selector(handlePlusLongPress))
        plusLongGesture.minimumPressDuration = 1.0
        plusLongGesture.cancelsTouchesInView = false
        plusButton.addGestureRecognizer(plusLongGesture)
    }
    
    private func setStepValue() {
        runCount += Constants.countTick
        if runCount < Constants.countTick * 5 {
            inputStepValue = stepValue
        } else if runCount >= Constants.countTick * 5 && runCount < Constants.countTick * 12 {
            inputStepValue = stepValue * Constants.firstStepMultiplier
        } else if runCount >= Constants.countTick * 12 && runCount < Constants.countTick * 20 {
            inputStepValue = stepValue * Constants.secondStepMultiplier
        } else {
            inputStepValue = stepValue * Constants.thirdStepMultiplier
        }
    }

    private func updateTextFieldWidth(width: CGFloat) {
        if Constants.TextField.defaultWidth > width {
            textFieldWidth.constant =  Constants.TextField.defaultWidth
        } else if Constants.TextField.maxWidth < width {
            textFieldWidth.constant = Constants.TextField.maxWidth
        } else {
            textFieldWidth.constant = width
        }
    }

    private func updateCurrentNumber() {
        guard let textfieldText = textField.text,
              !textfieldText.isEmpty
        else {
            textField.text = ""
            return
        }

        let number = numberFormatter.number(from: textfieldText)?.doubleValue ?? 0.0

        if number > maximumValue {
            value = maximumValue
        } else if number < minimumValue {
            value = minimumValue
        } else {
            value = number
        }

        updateTextFieldText()
    }

    private func updateTextFieldText() {
        textField.text = numberFormatter.string(from: NSNumber(value: value)) ?? ""
        updateTextFieldLayoutParametets()
    }

    private func configure(for state: UIControl.State) {
        titleLabel.textColor = scheme.titleLabelColor.parameter(for: state)?.uiColor
        configureButtons(for: state)
    }

    private func configureButtons(for state: UIControl.State) {
        guard isEnabled else {
            plusButton.isEnabled = false
            minusButton.isEnabled = false
            return
        }

        switch value {
        case maximumValue:
            plusButton.isEnabled = false
            minusButton.isEnabled = true
        case minimumValue:
            minusButton.isEnabled = false
            plusButton.isEnabled = true
        default:
            minusButton.isEnabled = true
            plusButton.isEnabled = true
        }
    }

    private func configure(for state: TextInputState) {
        textField.state = state
    }

    private func updateScheme() {
        textField.scheme = scheme.textField
        configure(for: textFieldState)
        updateColors()
        updateFonts()
        configure(for: state)
    }

    private func updateColors() {
        let textFieldColorDisabled = scheme.textFieldBackground.parameter(for: .disabled)?.uiColor
        let textFieldColorNormal = scheme.textFieldBackground.parameter(for: .normal)?.uiColor
        let textFieldColorSelected = scheme.textFieldBackground.parameter(for: .highlighted)?.uiColor

        let buttonColorNormal = scheme.buttonBackgroundColor.parameter(for: .normal)?.uiColor
        let buttonColorDisabled = scheme.buttonBackgroundColor.parameter(for: .disabled)?.uiColor
        let buttonColorSelected = scheme.buttonBackgroundColor.parameter(for: .highlighted)?.uiColor

        let titleColorNormal = scheme.titleLabelColor.parameter(for: .normal)?.uiColor
        let titleColorDisabled = scheme.titleLabelColor.parameter(for: .disabled)?.uiColor
        let titleColorSelected = scheme.titleLabelColor.parameter(for: .highlighted)?.uiColor

        minusButton.setBackgroundColor(buttonColorNormal, for: .normal)
        minusButton.setBackgroundColor(buttonColorDisabled, for: .disabled)
        minusButton.setBackgroundColor(buttonColorSelected, for: .highlighted)

        plusButton.setBackgroundColor(buttonColorNormal, for: .normal)
        plusButton.setBackgroundColor(buttonColorDisabled, for: .disabled)
        plusButton.setBackgroundColor(buttonColorSelected, for: .highlighted)

        titleLabel.textColor = state == .disabled ? titleColorDisabled : (state == .selected ? titleColorSelected : titleColorNormal)
        textField.backgroundColor = state == .disabled ? textFieldColorDisabled : (state == .selected ? textFieldColorSelected : textFieldColorNormal)
    }

    private func updateFonts() {
        titleLabel.setDynamicFont(
            font: scheme.titleFont.uiFont,
            textStyle: scheme.titleFont.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory
        )
    }

}

// MARK: - Buttons Actions

extension InputNumberTextField {

    @objc private func tapMinus() {
        if value - inputStepValue < minimumValue {
            value = minimumValue
        } else {
            value -= inputStepValue
        }
        updateTextFieldText()
        configureButtons(for: state)
    }

    @objc private func tapPlus() {
        if value + inputStepValue > maximumValue {
            value = maximumValue
        } else {
            value += inputStepValue
        }
        updateTextFieldText()
        configureButtons(for: state)
    }

    @objc private func handleMinusLongPress(gestureReconizer: UILongPressGestureRecognizer) {
        switch gestureReconizer.state {
        case .began:
            timer?.invalidate()
            timer = Timer.scheduledTimer(
                timeInterval: Constants.tick,
                target: self,
                selector: #selector(runTimedMinusCode(_:)),
                userInfo: nil,
                repeats: true)
        case .ended, .cancelled, .failed:
            finishTimer()
        default:
            break
        }
        configureButtons(for: state)
    }

    @objc private func handlePlusLongPress(gestureReconizer: UILongPressGestureRecognizer) {
        switch gestureReconizer.state {
        case .began:
            timer?.invalidate()
            timer = Timer.scheduledTimer(
                timeInterval: Constants.tick,
                target: self,
                selector: #selector(runTimedPlusCode(_:)),
                userInfo: nil,
                repeats: true)
        case .ended, .cancelled, .failed:
            finishTimer()
        default:
            break
        }
        configureButtons(for: state)
    }

    @objc private func finishTimer() {
        timer?.invalidate()
        timer = nil
        runCount = 0
        inputStepValue = stepValue
    }

    @objc private func runTimedMinusCode(_ timer: Timer) {
        setStepValue()
        tapMinus()
    }

    @objc private func runTimedPlusCode(_ timer: Timer) {
        setStepValue()
        tapPlus()
    }

}

// MARK: - UITextFieldDelegate

extension InputNumberTextField: UITextFieldDelegate {

    @objc public func textFieldDidChange(_ textField: TextField) {
        configure(for: textFieldState)
        textField.invalidateIntrinsicContentSize()
        self.textField.contentWidth = textField.intrinsicContentSize.width
        updateTextFieldLayoutParametets()
        updateCurrentNumber()
        configureButtons(for: state)
    }

    public func textFieldDidBeginEditing(_ textField: UITextField) {
        configure(for: textFieldState)
    }

    public func textFieldDidEndEditing(_ textField: UITextField) {
        configure(for: textFieldState)
    }

}
