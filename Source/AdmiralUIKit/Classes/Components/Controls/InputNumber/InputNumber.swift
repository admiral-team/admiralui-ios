//
//  InputNumber.swift
//  AdmiralUI
//
//  Created on 02.11.2020.
//

import UIKit
import AdmiralTheme
import AdmiralUIResources

/// An object that displays an editable text area with incrementing or decrementing a value.
public class InputNumber: UIControl, AnyAppThemable, AccessibilitySupport {
    
    enum Constants {
        static let height: CGFloat = LayoutGrid.doubleModule * 4
        static let buttonHeight: CGFloat = LayoutGrid.module * 5
        static let buttonWidth: CGFloat = LayoutGrid.module * 5
        static let titleHeight: CGFloat = LayoutGrid.halfModule * 5
        static let tick: TimeInterval = 0.25
        static let countTick: Float = 0.25
        
        static let firstStepMultiplier: Double = 5
        static let secondStepMultiplier: Double = 10
        static let thirdStepMultiplier: Double = 100
        
        enum TitleLabel {
            static let defaultWidth: CGFloat = 48.0
            static let maxWidth: CGFloat = 102.0
        }
    }
    
    // MARK: - Public Properties
    
    // A Boolean value indicating whether the control is in the enabled state.
    public override var isEnabled: Bool {
        didSet { configure(for: state) }
    }
    
    // The text that the label displays.
    public var text: String? {
        get { return titleLabel.text }
        set { titleLabel.text = newValue }
    }
    
    /// The numeric value of the stepper.
    public var value: Double = 0 {
        didSet { updateValueState() }
    }
    
    /// The lowest possible numeric value for the stepper.
    public var minimumValue: Double = 0 {
        didSet { updateValueState() }
    }
    
    /// The highest possible numeric value for the stepper.
    public var maximumValue: Double = .infinity {
        didSet { updateValueState() }
    }
    
    /// The step, or increment, value for the stepper. The default value for this property is 1.
    public var stepValue: Double = 1.0 {
        didSet { inputStepValue = stepValue }
    }

    /// Color scheme.
    public var scheme = InputNumberScheme() {
        didSet { updateScheme() }
    }
    
    public override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: Constants.height)
    }
    
    // MARK: - AccessibilitySupport
    
    public var adjustsFontForContentSizeCategory: Bool = Appearance.isAccessabilitySupportEnabled {
        didSet { updateFonts() }
    }

    // MARK: - Private Properties
    
    private let titleLabel = UILabel()
    private let numberLabel = UILabel()
    private let minusButton = CustomButton()
    private let plusButton = CustomButton()
        
    private var inputStepValue: Double = 1.0
    private var timer: Timer?
    private var runCount: Float = 0
    
    private lazy var widthNumberLabel: NSLayoutConstraint = {
        return numberLabel.widthAnchor.constraint(equalToConstant: Constants.TitleLabel.defaultWidth)
    }()
    
    // MARK: - Initializer
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    deinit {
        finishTimer()
    }
    
    // MARK: - Public Methods
    
    /// Set text for title.
    /// - Parameter text: left title text.
    public func setText(_ text: String?) {
        titleLabel.text = text
    }
    
    /// Set  incrementing  value.
    public func setValue(_ value: Double) {
        self.value = value
    }
    
    // MARK: - Public Methods
    
    public func apply(theme: AppTheme) {
        scheme = InputNumberScheme(theme: theme)
    }
        
    // MARK: - Private Methods
    
    private func commonInit() {
        addSubviews()
        configureConstraints()
        configureUI()
    }
    
    private func configureUI() {
        apply(theme: defaultTheme)
        
        titleLabel.textAlignment = .left
        numberLabel.textAlignment = .center
        
        minusButton.setImage(Asset.Service.Outline.minusOutline.image, for: .normal)
        plusButton.setImage(Asset.Service.Outline.plusOutline.image, for: .normal)
        
        minusButton.setCornerRadius(Constants.buttonHeight / 2, for: [.normal])
        plusButton.setCornerRadius(Constants.buttonHeight / 2, for: [.normal])
        
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
    
    private func configure(for state: UIControl.State) {
        titleLabel.textColor = scheme.textColor.parameter(for: state)?.uiColor
        numberLabel.textColor = scheme.textColor.parameter(for: state)?.uiColor
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
    
    private func updateScheme() {
        scheme.tintColor.forEachState() { state, color in
            minusButton.setTintColor(color.uiColor, for: state)
            plusButton.setTintColor(color.uiColor, for: state)
        }
        
        scheme.backgroundColor.forEachState() { state, color in
            minusButton.setBackgroundColor(color.uiColor, for: state)
            plusButton.setBackgroundColor(color.uiColor, for: state)
        }
        configure(for: state)
        updateFonts()
    }
    
    private func updateFonts() {
        titleLabel.setDynamicFont(
            font: scheme.titleFont.uiFont,
            textStyle: scheme.titleFont.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory)
        numberLabel.setDynamicFont(
            font: scheme.numberFont.uiFont,
            textStyle: scheme.numberFont.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory)
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
    
    @objc private func tapMinus() {
        if value - inputStepValue < minimumValue {
            value = minimumValue
        } else {
            value -= inputStepValue
        }
    }
    
    @objc private func tapPlus() {
        if value + inputStepValue > maximumValue {
            value = maximumValue
        } else {
            value += inputStepValue
        }
    }
    
    private func updateTitleLabelWidth() {
        let textLabelWidth = numberLabel.intrinsicContentSize.width
        
        if Constants.TitleLabel.defaultWidth > textLabelWidth {
            widthNumberLabel.constant =  Constants.TitleLabel.defaultWidth
        } else if Constants.TitleLabel.maxWidth < textLabelWidth {
            widthNumberLabel.constant = Constants.TitleLabel.maxWidth
        } else {
            widthNumberLabel.constant = textLabelWidth
        }
    }
    
    private func updateValueState() {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        
        numberLabel.text = formatter.string(from: NSNumber(value: value))
        updateTitleLabelWidth()
        
        configureButtons(for: state)
        sendActions(for: .valueChanged)
    }
    
    private func addSubviews() {
        [titleLabel, numberLabel, minusButton, plusButton].addToSuperview(self)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            plusButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            trailingAnchor.constraint(equalTo: plusButton.trailingAnchor),
            plusButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight),
            plusButton.widthAnchor.constraint(equalToConstant: Constants.buttonWidth),
            
            numberLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            numberLabel.leadingAnchor.constraint(equalTo: minusButton.trailingAnchor, constant: LayoutGrid.module),
            plusButton.leadingAnchor.constraint(equalTo: numberLabel.trailingAnchor, constant: LayoutGrid.module),
            widthNumberLabel,
            numberLabel.heightAnchor.constraint(equalToConstant: Constants.titleHeight),
            
            minusButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            minusButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight),
            minusButton.widthAnchor.constraint(equalToConstant: Constants.buttonWidth),
            minusButton.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: LayoutGrid.module),
            
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: Constants.titleHeight)
        ])
    }
    
    private func setNumberLabel(_ value: Double) {
        if value > maximumValue {
            self.value = maximumValue
        } else if value < minimumValue {
            self.value = minimumValue
        } else {
            self.value = value
        }
        updateValueState()
    }
    
}
