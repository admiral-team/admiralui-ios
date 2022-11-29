//
//  DoubleTextField.swift
//  AdmiralUI
//
//  Created on 21.10.2020.
//

import UIKit
import AdmiralTheme

/// Double text fields with alignment.
public class DoubleTextField<T1, T2>: UIView, AnyAppThemable, AccessibilitySupport where T1: TextField, T2: TextField {
            
    /// Text field alignment.
    public enum Alignment {
        case fixedFirst(first: CGFloat)
        case fixedSecond(second: CGFloat)
        case ratio(ration: CGFloat)
    }
    
    // MARK: - Public Parameters
    
    // The state of texfield.
    public var state: TextInputState {
        get { return textFieldState }
        set { setState(newValue, animated: false) }
    }
    
    // The string that displays some additional info.
    public var info: String? {
        get { return informerLabel.text }
        set { update(info: newValue) }
    }
    
    /// First Text Field.
    public let firstTextField: T1
    
    /// Second Text Field.
    public let secondTextField: T2

    /// Color scheme.
    public var scheme = DoubleTextFieldScheme() {
        didSet { updateScheme() }
    }
    
    /// Alignment textfields. 3 state: Fixed width first textfeild, fixed width second textfield, ratio first to second textfield.
    public var alignment: Alignment {
        didSet {
            NSLayoutConstraint.deactivate([aligmentConstraint])
            setAligmentConstraint()
            NSLayoutConstraint.activate([aligmentConstraint])
            
            setNeedsLayout()
            layoutIfNeeded()
        }
    }
    
    // MARK: - Internal Parameters
    
    var informerVerticalSpacing: CGFloat = LayoutGrid.module {
        didSet {
            updateInformerVerticalSpacingConstraints()
            layoutIfNeeded()
        }
    }
    
    // MARK: - AccessibilitySupport
    
    public var adjustsFontForContentSizeCategory: Bool = Appearance.isAccessabilitySupportEnabled {
        didSet { updateFonts() }
    }
    
    // MARK: - Private Parameters
    
    private let height: CGFloat = 72.0
    private var aligmentConstraint: NSLayoutConstraint!
    private var informerLabel = UILabel()
    private var textFieldState: TextInputState = .normal
    private var informerVerticalSpacingConstraint: NSLayoutConstraint?
    
    // MARK: - Initializer
    
    /// Initializes and returns a newly allocated view object
    /// - Parameters:
    ///   - firstTextField: First textfield.
    ///   - secondTextField: Second textfield.
    ///   - alignment: Textfields alignment.
    public init(firstTextField: T1, secondTextField: T2, alignment: Alignment) {
        self.firstTextField = firstTextField
        self.secondTextField = secondTextField
        self.alignment = alignment
        super.init(frame: .zero)
        
        commonInit()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// The natural size for the receiving view, considering only properties of the view itself.
    public override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width, height: height)
    }
    
    public func apply(theme: AppTheme) {
        firstTextField.apply(theme: theme)
        secondTextField.apply(theme: theme)
        scheme = DoubleTextFieldScheme(theme: theme)
    }
    
    // MARK: - Public Methods
    
    public func setState(_ state: TextInputState, animated: Bool) {
        textFieldState = state
        configureState(anmated: animated)
    }
    
    // MARK: - Private Methods
    
    private func setAligmentConstraint() {
        switch alignment {
        case .fixedFirst(let first):
            aligmentConstraint = firstTextField.widthAnchor.constraint(equalToConstant: first)
        case .fixedSecond(let second):
            aligmentConstraint = secondTextField.widthAnchor.constraint(equalToConstant: second)
        case .ratio(let ration):
            aligmentConstraint = firstTextField.widthAnchor.constraint(equalTo: secondTextField.widthAnchor, multiplier: ration)
        }
    }
    
    private func commonInit() {
        configureUI()
        setAligmentConstraint()
        addSubviews()
        configureConstraints()
        configureInformerLabelLayout()
    }
    
    private func configureUI() {
        clipsToBounds = true

        informerLabel.numberOfLines = 0
        informerLabel.backgroundColor = .clear
        configureState(anmated: false)
    }
    
    private func addSubviews() {
        [firstTextField, secondTextField, informerLabel].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            firstTextField.leadingAnchor.constraint(equalTo: leadingAnchor),
            firstTextField.topAnchor.constraint(equalTo: topAnchor),
            firstTextField.trailingAnchor.constraint(equalTo: secondTextField.leadingAnchor, constant: -LayoutGrid.doubleModule),
            firstTextField.heightAnchor.constraint(equalToConstant: 72),
            
            secondTextField.trailingAnchor.constraint(equalTo: trailingAnchor),
            secondTextField.topAnchor.constraint(equalTo: topAnchor),
            secondTextField.heightAnchor.constraint(equalToConstant: 72),
            aligmentConstraint
        ])
    }
    
    private func configureInformerLabelLayout() {
        let topFirstTextField = informerLabel.topAnchor.constraint(greaterThanOrEqualTo: firstTextField.bottomAnchor, constant: LayoutGrid.module)
        let topSecondTextField = informerLabel.topAnchor.constraint(greaterThanOrEqualTo: secondTextField.bottomAnchor, constant: LayoutGrid.module)
        let leading = informerLabel.leadingAnchor.constraint(equalTo: firstTextField.leadingAnchor)
        let trailing = secondTextField.trailingAnchor.constraint(equalTo: informerLabel.trailingAnchor)
        let bottom = informerLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        
        bottom.priority = UILayoutPriority(UILayoutPriority.required.rawValue - 1)
        informerLabel.setContentHuggingPriority(.required, for: .vertical)
        
        informerVerticalSpacingConstraint = topFirstTextField
        updateInformerVerticalSpacingConstraints()
        
        NSLayoutConstraint.activate([topFirstTextField, topSecondTextField, leading, trailing, bottom])
    }
    
    private func configureState(anmated: Bool) {
        setNeedsLayout()

        if anmated {
            UIView.animate(
                withDuration: Durations.Default.half,
                delay: 0,
                options: [.curveEaseInOut],
                animations: {
                    self.updateColors()
                    self.layoutIfNeeded()
                }, completion: nil)
        } else {
            updateColors()
            layoutIfNeeded()
        }
    }
    
    private func updateColors() {
        switch state {
        case .normal:
            informerLabel.textColor = scheme.underlineColor.uiColor
        case .error:
            informerLabel.textColor = scheme.errorColor.uiColor
        case .disabled:
            informerLabel.textColor = scheme.disabledColor.uiColor
        case .readOnly:
            informerLabel.textColor = scheme.underlineColor.uiColor
        }
    }
    
    private func update(info: String?) {
        informerLabel.text = info
        updateInformerVerticalSpacingConstraints()
    }
    
    private func updateInformerVerticalSpacingConstraints() {
        let isHidden = info?.nilIfEmpty == nil
        informerVerticalSpacingConstraint?.constant = isHidden ? 0 : informerVerticalSpacing
    }
    
    private func updateScheme() {
        firstTextField.scheme = scheme.first
        secondTextField.scheme = scheme.second
        updateColors()
        updateFonts()
    }
    
    private func updateFonts() {
        informerLabel.setDynamicFont(
            font: scheme.informerFont.uiFont,
            textStyle: scheme.informerFont.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory)
    }
    
}
