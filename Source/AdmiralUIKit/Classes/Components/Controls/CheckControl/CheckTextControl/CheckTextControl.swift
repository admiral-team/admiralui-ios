//
//  CheckTextControl.swift
//  AdmiralUI
//
//  Created on 21.12.2020.
//

import UIKit
import AdmiralTheme

/// Base class for checkbox or radiobutton and label.
final public class CheckTextControl<C: CheckControl>: UIControl, AnyAppThemable, AccessibilitySupport {
    
    // MARK: - Public Properties
    
    /// State control.
    public var checkState: CheckControlState = .normal {
        didSet {
            checkControl.checkState = checkState
            updateState()
        }
    }
    
    /// A Boolean value indicating whether the control is in the selected state.
    public override var isSelected: Bool {
        didSet {
            checkControl.isSelected = isSelected
            updateState()
        }
    }
    
    /// A Boolean value indicating whether the control is in the enabled state.
    public override var isEnabled: Bool {
        didSet {
            checkControl.isEnabled = isEnabled
            updateState()
        }
    }
    
    /// A Boolean value indicating whether the control is in the highlighted state.
    public override var isHighlighted: Bool {
        didSet {
            checkControl.isHighlighted = isHighlighted
            updateState()
        }
    }
    
    /// The text displayed in the text label.
    public var text: String? {
        get { return textLabel.text }
        set { textLabel.text = newValue }
    }
    
    /// The maximum number of lines for rendering text text label.
    public var numberOfLines: Int {
        get { return textLabel.numberOfLines }
        set { textLabel.numberOfLines = newValue }
    }
    
    // MARK: - AccessibilitySupport
    
    public var adjustsFontForContentSizeCategory: Bool = Appearance.isAccessabilitySupportEnabled {
        didSet { updateSchemeFonts() }
    }
    
    // MARK: - Internal Properties
    
    var scheme = CheckTextControlScheme() {
        didSet { updateState() }
    }
    
    // MARK: - Private Properties
    
    private let checkControl: C
    private let textLabel = UILabel()
    
    // MARK: - Initializer
    
    public init(checkControl: C) {
        self.checkControl = checkControl
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - AppTheamable
    
    public func apply(theme: AppTheme) {
        scheme = CheckTextControlScheme(theme: theme)
    }
    
    // MARK: - Private Methods
    
    private func commonInit() {
        addSubviews()
        configureConstraints()
        configureUI()
    }
    
    private func configureUI() {
        checkControl.isUserInteractionEnabled = false
        
        textLabel.numberOfLines = 0
    }
    
    private func addSubviews() {
        [checkControl,
         textLabel].addToSuperview(self)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            checkControl.leadingAnchor.constraint(equalTo: leadingAnchor),
            checkControl.topAnchor.constraint(equalTo: topAnchor),
            textLabel.leadingAnchor.constraint(equalTo: checkControl.trailingAnchor, constant: LayoutGrid.module),
            textLabel.topAnchor.constraint(equalTo: topAnchor),
            textLabel.heightAnchor.constraint(greaterThanOrEqualTo: checkControl.heightAnchor),
            bottomAnchor.constraint(equalTo: textLabel.bottomAnchor),
            trailingAnchor.constraint(equalTo: textLabel.trailingAnchor)
        ])
    }
    
    private func updateState() {
        updateScheme()
        checkControl.updateState()
    }
    
    private func updateScheme() {
        updateSchemeFonts()
        updateSchemeColors()
        checkControl.scheme = scheme.checkControlScheme
    }
    
    private func updateSchemeFonts() {
        textLabel.setDynamicFont(
            font: scheme.textFont.uiFont,
            textStyle: scheme.textFont.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory)
    }
    
    private func updateSchemeColors() {
        textLabel.textColor = scheme.textColor.parameter(for: state)?.uiColor
    }
    
}
