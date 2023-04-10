//
//  HeaderButtonWithArrow.swift
//  AdmiralUIKit
//
//  Created on 24.02.2022.
//

import AdmiralCore
import AdmiralTheme
import AdmiralUIResources
import UIKit

/// Custom ghost button with left and right titles
public class HeaderButtonWithArrow: UIControl, AnyAppThemable, AccessibilitySupport {
    
    // MARK: - Override states
    
    /// A Boolean value indicating whether the control is in the selected state.
    override public var isSelected: Bool {
        didSet { updateScheme() }
    }
    
    /// A Boolean value indicating whether the control draws a highlight.
    override public var isHighlighted: Bool {
        get { return super.isHighlighted }
        set {
            highlight() {
                super.isHighlighted = newValue
            }
            updateScheme()
        }
    }
    
    /// A Boolean value indicating whether the control is in the enabled state.
    override public var isEnabled: Bool {
        didSet { updateScheme() }
    }
    
    /// Text for button label
    public var text: String? {
        get { return textLabel.text }
        set { textLabel.text = newValue }
    }

    public var scheme = HeaderButtonWithArrowScheme() {
        didSet { updateScheme() }
    }
    
    /// Image arrow is up state.
    public var dropDownHeaderType: DropDownHeaderType? = .down {
        didSet {
            arrowImageView.image = dropDownHeaderType?.image
        }
    }
    
    /// A Boolean value indicating whether the control highlight animated.
    public var shouldAnimateHighlighting: Bool = true
    
    /// Highlight animation duration.
    public var animationDuration: TimeInterval = Durations.Default.single
    
    // MARK: - AccessibilitySupport
    
    public var adjustsFontForContentSizeCategory: Bool = Appearance.isAccessabilitySupportEnabled {
        didSet { updateSchemeFonts() }
    }
    
    // MARK: - Private Properties
    
    private let textLabel = UILabel()
    private let arrowImageView = UIImageView()
    
    // MARK: - AnyAppThemable
    
    public func apply(theme: AppTheme) {
        scheme = HeaderButtonWithArrowScheme(theme: theme)
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
        setImageView()
        configureConstraints()
    }
    
    private func addSubviews() {
        [textLabel,
         arrowImageView].forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
         })
    }
    
    private func setupLabels() {
        textLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        textLabel.numberOfLines = 1
        textLabel.textAlignment = .left
    }
    
    private func setImageView() {
        arrowImageView.clipsToBounds = false
        arrowImageView.contentMode = .scaleAspectFill
        arrowImageView.image = dropDownHeaderType?.image
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            textLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            textLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            arrowImageView.widthAnchor.constraint(equalToConstant: LayoutGrid.halfModule * 7),
            arrowImageView.heightAnchor.constraint(equalToConstant: LayoutGrid.halfModule * 7),
            arrowImageView.leadingAnchor.constraint(equalTo: textLabel.trailingAnchor, constant: LayoutGrid.doubleModule),
            trailingAnchor.constraint(equalTo: arrowImageView.trailingAnchor),
            arrowImageView.centerYAnchor.constraint(equalTo: textLabel.centerYAnchor),
            heightAnchor.constraint(equalToConstant: LayoutGrid.halfModule * 11)
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
        textLabel.textColor = scheme.textColor.parameter(for: state)?.uiColor
        arrowImageView.tintColor = scheme.imageColor.parameter(for: state)?.uiColor
    }
    
    private func updateSchemeFonts() {
        textLabel.setDynamicFont(
            font: scheme.titleLabelFont.uiFont,
            textStyle: scheme.titleLabelFont.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory)
    }
    
}


