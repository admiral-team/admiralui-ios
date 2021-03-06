//
//  TwoTitleGhostButton.swift
//  AdmiralUI
//
//  Created on 15.02.2021.
//

import UIKit
import AdmiralTheme

/// Custom ghost button with left and right titles
public class TwoTitleGhostButton: UIControl, AnyAppThemable, AccessibilitySupport {
    
    // MARK: - Override states
    
    /// A Boolean value indicating whether the control is in the selected state.
    open override var isSelected: Bool {
        didSet { updateScheme() }
    }
    
    /// A Boolean value indicating whether the control draws a highlight.
    open override var isHighlighted: Bool {
        get { return super.isHighlighted }
        set {
            highlight() {
                super.isHighlighted = newValue
            }
            updateScheme()
        }
    }
    
    /// A Boolean value indicating whether the control is in the enabled state.
    open override var isEnabled: Bool {
        didSet { updateScheme() }
    }
    
    /// Text for left button label
    open var leftButtonTitle: String? {
        get { return leftLabel.text }
        set { leftLabel.text = newValue }
    }
    
    /// Text for right button label
    open var rightButtonTitle: String? {
        get { return rightLabel.text }
        set { rightLabel.text = newValue }
    }
    
    /// A Boolean value indicating whether the control highlight animated.
    open var shouldAnimateHighlighting: Bool = true
    
    /// Highlight animation duration.
    open var animationDuration: TimeInterval = Durations.Default.single
    
    open var scheme = TwoTitleGhostButtonScheme() {
        didSet { updateScheme() }
    }
    
    // MARK: - AccessibilitySupport
    
    public var adjustsFontForContentSizeCategory: Bool = Appearance.isAccessabilitySupportEnabled {
        didSet { updateSchemeFonts() }
    }
    
    // MARK: - Private Properties
    
    private let leftLabel = UILabel()
    private let rightLabel = UILabel()
    private var cornerRadius: CGFloat = LayoutGrid.module
    
    // MARK: - AnyAppThemable
    
    public func apply(theme: AppTheme) {
        scheme = TwoTitleGhostButtonScheme(theme: defaultTheme)
    }
    
    // MARK: - Public Methods
    
    /// Sets the corner radius of button.
    /// - Parameter radius: The  corner radius of button.
    open func setCornerRadius(_ radius: CGFloat) {
        cornerRadius = radius
        updateScheme()
    }
    
    // MARK: - Initializers
   
    /// Initializes and returns a newly allocated view object with the zero frame rectangle.
    convenience public init() {
        self.init(frame: .zero)
    }
    
    /// Initializes and returns a newly allocated view object with the specified frame rectangle.
    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    /// Returns an object initialized from data in a given unarchiver.
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    // MARK: - Private Properties
    
    private func commonInit() {
        apply(theme: defaultTheme)
        
        addSubviews()
        setupLabels()
        configureConstraints()
    }
    
    private func addSubviews() {
        [leftLabel,
         rightLabel].forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
         })
    }
    
    private func setupLabels() {
        leftLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        leftLabel.numberOfLines = 1
        leftLabel.textAlignment = .left
        
        rightLabel.numberOfLines = 1
        rightLabel.textAlignment = .right
        rightLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            leftLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            leftLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
           
            trailingAnchor.constraint(equalTo: rightLabel.trailingAnchor, constant: LayoutGrid.module),
            rightLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            rightLabel.leadingAnchor.constraint(equalTo: leftLabel.trailingAnchor)
        ])
    }
    
    private func highlight(animation: @escaping () -> Void) {
        guard shouldAnimateHighlighting else {
            animation()
            return
        }
        
        UIView.transition(
            with: self,
            duration: animationDuration,
            options: [.transitionCrossDissolve, .allowAnimatedContent, .allowUserInteraction],
            animations: animation,
            completion: nil)
    }
    
    private func updateScheme() {
        updateSchemeFonts()
        updateSchemeColors()
    }
    
    private func updateSchemeColors() {
        layer.cornerRadius = cornerRadius
        backgroundColor = scheme.backgroundColor.uiColor
        leftLabel.textColor = scheme.leftTitleColor.parameter(for: state)?.uiColor
        rightLabel.textColor = scheme.rightTitleColor.parameter(for: state)?.uiColor
    }
    
    private func updateSchemeFonts() {
        leftLabel.setDynamicFont(
            font: scheme.leftLabelFont.uiFont,
            textStyle: scheme.leftLabelFont.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory)
        rightLabel.setDynamicFont(
            font: scheme.rightLabelFont.uiFont,
            textStyle: scheme.rightLabelFont.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory)
    }
    
}
