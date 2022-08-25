//
//  TagControl.swift
//  AdmiralUI
//
//  Created on 15.10.2020.
//

import UIKit
import AdmiralTheme

public enum TagStyle: Int {
    case none
    case `default`
    case success
    case additional
    case error
    case attention
}

/// A tag is a label that marks and catalogs information to facilitate the search process. When you click on a tag, all elements with this tag are loaded.
open class TagControl<T: UIView, V: UIView>: UIControl, AnyAppThemable, AccessibilitySupport {
    
    // MARK: - Override states
    
    /// A Boolean value indicating whether the control is in the selected state.
    open override var isSelected: Bool {
        didSet { updateScheme() }
    }
    
    /// A Boolean value indicating whether the control draws a highlight.
    open override var isHighlighted: Bool {
        get { return super.isHighlighted }
        set {
            highlight() { super.isHighlighted = newValue }
            updateScheme()
        }
    }
    
    /// A Boolean value indicating whether the control is in the enabled state.
    open override var isEnabled: Bool {
        didSet { updateScheme() }
    }
    
    // MARK: - Public Parameters
    
    /// A Boolean value indicating whether the control highlight animated.
    open var shouldAnimateHighlighting: Bool = true
    
    /// Highlight animation duration.
    open var animationDuration: TimeInterval = Durations.Default.single
    
    /// Additional leading view. In this field, you can add any object from UIView.
    open var leadingView: T? {
        didSet { configureLeadingView(oldValue: oldValue) }
    }
    
    /// Additional trailing view. In this field, you can add any object from UIView.
    open var trailingView: V? {
        didSet { configureTrailingView(oldValue: oldValue) }
    }
    
    /// The text in the middle.
    open var title: String? {
        get { return titleLabel.text }
        set { titleLabel.text = newValue }
    }
    
    /// The height object.
    public var height: CGFloat = LayoutGrid.halfModule * 9
    
    // MARK: - Internal Parameters

    public var style: TagStyle = .default {
        didSet { updateScheme() }
    }
    
    public var scheme = TagControlCustomScheme() {
        didSet { updateScheme() }
    }
    
    public var titleFont: UIFont? {
        didSet { titleLabel.font = titleFont }
    }
    
    public var textStyle: UIFont.TextStyle?
    
    // MARK: - AccessibilitySupport
    
    public var adjustsFontForContentSizeCategory: Bool = Appearance.shared.isAccessabilitySupportEnabled {
        didSet { updateSchemeFonts() }
    }
    
    // MARK: - Private Parameters
    
    private let titleHeight: CGFloat = LayoutGrid.halfModule * 5
    private let titleLabel = UILabel()
    private var leadingContainerView = UIView()
    private var trailingContainerView = UIView()
    
    private var widthLeadingContainerConstraint: NSLayoutConstraint!
    private var leadingContainerLeadingConstraint: NSLayoutConstraint!
    private var labelLeadingAnchor: NSLayoutConstraint!
    private var labelTrailingConstraing: NSLayoutConstraint!
    
    private var widthTrailingContainerConstraint: NSLayoutConstraint!
    private var trailingContainerTrailingConstraint: NSLayoutConstraint!
    
    private var backgroundViewColor = ControlParameter<UIColor>()
    private var textColor = ControlParameter<UIColor>()
    private var tintItemsColor = ControlParameter<UIColor>()
    
    // MARK: - Initializer
    
    /// Initializes and returns a newly allocated view object with the specified frame rectangle.
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    /// Returns an object initialized from data in a given unarchiver.
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    /// The natural size for the receiving view, considering only properties of the view itself.
    public override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: height)
    }
    
    // MARK: - AnyAppThemable
    
    open func apply(theme: AppTheme) {
        scheme = TagControlCustomScheme(theme: theme)
    }
    
    // MARK: - Internal Methods
    
    func updateIfNeeded(for newState: UIControl.State) {
        guard newState.contains(state) else { return }
        
        configure(for: state)
    }
    
    func highlight(animation: @escaping () -> Void) {
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
    
    func setCornerRadius(_ radius: CGFloat) {
        layer.cornerRadius = radius
    }
    
    // MARK: - Configuration Methods
    
    func configure(for state: UIControl.State) {
        apply(theme: defaultTheme)
    }
    
    // MARK: - Public Methods

    /// Sets the title to use.
    ///
    /// - Parameters:
    ///   - title: The title to use for the specified state.
    open func setTitle(_ title: String?) {
        titleLabel.text = title
    }
    
    // MARK: - Private Methods
    
    private func commonInit() {
        widthLeadingContainerConstraint = leadingContainerView.widthAnchor.constraint(equalToConstant: 0)
        leadingContainerLeadingConstraint = leadingContainerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0)
        
        widthTrailingContainerConstraint = trailingContainerView.widthAnchor.constraint(equalToConstant: 0)
        trailingContainerTrailingConstraint = trailingAnchor.constraint(equalTo: trailingContainerView.trailingAnchor, constant: 0)
        
        configureView()
        setLabel()
        addSubviews()
        configureConstraints()
    }
    
    private func setLabel() {
        titleLabel.numberOfLines = 1
        titleLabel.textAlignment = .center
    }
    
    private func addSubviews() {
        [leadingContainerView,
         trailingContainerView,
         titleLabel].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingContainerView.trailingAnchor, constant: LayoutGrid.halfModule * 3),
            titleLabel.trailingAnchor.constraint(equalTo: trailingContainerView.leadingAnchor, constant: -LayoutGrid.halfModule * 3),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: titleHeight),

            widthLeadingContainerConstraint,
            leadingContainerLeadingConstraint,
            leadingContainerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            widthTrailingContainerConstraint,
            trailingContainerTrailingConstraint,
            trailingContainerView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    private func configureView() {
        setCornerRadius(height / 2)
        clipsToBounds = true
    }
    
    private func configureLeadingView(oldValue: UIView?) {
        oldValue?.removeFromSuperview()
        
        if let leadingView = leadingView {
            leadingContainerView.addSubview(leadingView)
            leadingView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate(leadingView.fillView(view: leadingContainerView))
        }

        if leadingView == nil {
            widthLeadingContainerConstraint.isActive = true
            leadingContainerLeadingConstraint.constant = LayoutGrid.halfModule * 3
        } else {
            widthLeadingContainerConstraint.isActive = false
            leadingContainerLeadingConstraint.constant = LayoutGrid.halfModule * 3
        }
        
        updateIfNeeded(for: [.normal])
    }
    
    private func configureTrailingView(oldValue: UIView?) {
        oldValue?.removeFromSuperview()
        
        if let trailingView = trailingView {
            trailingContainerView.addSubview(trailingView)
            trailingView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate(trailingView.fillView(view: trailingContainerView))
        }

        if trailingView == nil {
            widthTrailingContainerConstraint.isActive = true
            trailingContainerTrailingConstraint.constant = LayoutGrid.halfModule * 3
        } else {
            widthTrailingContainerConstraint.isActive = false
            trailingContainerTrailingConstraint.constant = LayoutGrid.halfModule * 3
        }
        
        updateIfNeeded(for: [.normal])
    }
    
    public func updateScheme() {
        updateSchemeFonts()
        updateSchemeColors()
    }
    
    private func updateSchemeFonts() {
        titleLabel.setDynamicFont(
            font: titleFont ?? scheme.font.uiFont,
            textStyle: textStyle ?? scheme.font.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory)
    }
    
    private func updateSchemeColors() {
        titleLabel.textColor = scheme.textColor.parameter(for: state, style: style)?.uiColor
        backgroundColor = scheme.backgroundColor.parameter(for: state, style: style)?.uiColor
        leadingView?.tintColor = scheme.viewTintColor.parameter(for: state, style: style)?.uiColor
        leadingView?.alpha = scheme.leadingTrailingViewsAlpha.parameter(for: state) ?? 1.0
        trailingView?.alpha = scheme.leadingTrailingViewsAlpha.parameter(for: state) ?? 1.0
        trailingView?.tintColor = scheme.viewTintColor.parameter(for: state, style: style)?.uiColor
    }
    
}
