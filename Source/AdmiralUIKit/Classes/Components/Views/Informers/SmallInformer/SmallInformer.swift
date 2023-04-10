//
//  SmallInformer.swift
//  AdmiralUI
//
//  Created on 26.11.2020.
//

import UIKit
import AdmiralCore
import AdmiralTheme
import AdmiralUIResources

/// The direction of arrow pivot of informer.
public enum SmallInformerArrowDirection {
    /// The arrow is at the top
    case up
    /// The arrow is at the bottom
    case down
    /// The arrow is at the top right
    case upRight
    /// The arrow is at the bottom right
    case downRight
}

/// The corner radius of SmallInformer.
public enum CornerRadius: CGFloat {
    /// The zero value of corner radius.
    case zero = 0
    /// The module value of corner radius.
    case module = 4
    /// The doubleModule value of corner radius.
    case doubleModule = 8
    /// The tripleModule value of corner radius.
    case tripleModule = 12
    /// The quadrupleModule value of corner radius.
    case quadrupleModule = 16
}

/// Informer is a component that used to show some information.
open class SmallInformer: UIView, AnyAppThemable, AccessibilitySupport {
    
    // MARK: - Public Properties
    
    /// The font of title
    open var titleFont: UIFont? {
        get { return titleLabel.font }
        set { titleLabel.font = newValue }
    }

    /// The title text that the informer is displaying.
    open var titleText: String? {
        get { return titleLabel.text }
        set { titleLabel.text = newValue }
    }
    
    /// The number of lines of title label.
    open var titleLabelNumerOfLines: Int {
        get { return titleLabel.numberOfLines }
        set { titleLabel.numberOfLines = newValue }
    }
    
    /// The corner radius of informer.
    open var informerCornerRadius: CornerRadius = .module {
        didSet {
            wrapView.layer.cornerRadius = informerCornerRadius.rawValue
        }
    }
    
    /// A Boolean value indicating whether the control is in the enabled state.
    open var isEnabled: Bool = true {
        didSet { updateScheme() }
    }

    /// Informer style to configure the informer with library styles or custom style.
    open var style: InformerStyle = .default {
        didSet { updateScheme() }
    }

    /// Color scheme.
    public var scheme = SmallInformerScheme() {
        didSet { updateScheme() }
    }
    
    // MARK: - AccessibilitySupport
    
    public var adjustsFontForContentSizeCategory: Bool = Appearance.isAccessabilitySupportEnabled {
        didSet { updateSchemeFonts() }
    }
    
    // MARK: - Private Properties
    
    private enum Constants {
        static let topArrowImage = SystemAsset.Custom.Segment.arrowUp.image
        static let bottomArrowImage = SystemAsset.Custom.Segment.arrowDown.image
        static let heightImageView: CGFloat = LayoutGrid.module
        static let widthImageView: CGFloat = LayoutGrid.doubleModule
    }

    private let wrapView = UIView()
    private let titleLabel = UILabel()
    private let topArrowImageView = UIImageView()
    private let bottomArrowImageView = UIImageView()
    private let topRightArrowImageView = UIImageView()
    private let bottomRightArrowImageView = UIImageView()
    private var titleLabelTextColors = InformerParameters<UIColor>()
    private var wrapViewBackgroundColors = InformerParameters<UIColor>()
    private var backgroundColors = InformerParameters<UIColor>()
    
    private lazy var topArrowImageViewLeadingConstraint: NSLayoutConstraint = {
        return topArrowImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutGrid.halfModule * 5)
    }()
    
    private lazy var bottomArrowImageViewLeadingConstraint: NSLayoutConstraint = {
        return bottomArrowImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutGrid.halfModule * 5)
    }()
    
    private lazy var topRightArrowImageViewTrailingConstraint: NSLayoutConstraint = {
        return trailingAnchor.constraint(equalTo: topRightArrowImageView.trailingAnchor, constant: LayoutGrid.halfModule * 5)
    }()
    
    private lazy var bottomRightArrowImageTrailingConstraint: NSLayoutConstraint = {
        return trailingAnchor.constraint(equalTo: bottomRightArrowImageView.trailingAnchor, constant: LayoutGrid.halfModule * 5)
    }()

    // MARK: - Initializer
    
    /// Initializes and returns a newly allocated view object with the zero frame rectangle.
    convenience public init() {
        self.init(frame: CGRect())
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
    
    /// Sets the leading anchor of arrow pivot.
    /// - Parameter constant: The constant of leading anchor of arrow pivot.
    open func setArrowPivotLeadingAnchorPoint(constant: CGFloat) {
        topArrowImageViewLeadingConstraint.constant = constant
        bottomArrowImageViewLeadingConstraint.constant = constant
        topRightArrowImageViewTrailingConstraint.constant = constant
        bottomRightArrowImageTrailingConstraint.constant = constant
        
        setNeedsLayout()
    }
    
    /// Sets the leading anchor of arrow pivot.
    /// - Parameter constant: The constant of leading anchor of arrow pivot.
    open func setArrowDirection(direction: SmallInformerArrowDirection) {
        topArrowImageView.isHidden = direction == .up ? false : true
        bottomArrowImageView.isHidden  = direction == .down ? false : true
        topRightArrowImageView.isHidden = direction == .upRight ? false : true
        bottomRightArrowImageView.isHidden = direction == .downRight ? false : true
    }
    
    // MARK: - AnyAppTheamable
    
    open func apply(theme: AppTheme) {
        scheme = SmallInformerScheme(theme: theme)
    }
    
    // MARK: - Private Methods
    
    private func updateScheme() {
        updateSchemeFonts()
        updateSchemeColors()
    }
    
    private func updateSchemeColors() {
        titleLabel.textColor = scheme.titleLabelTextColors.parameter(isEnabled: isEnabled, style: style)?.uiColor
        wrapView.backgroundColor = scheme.wrapViewBackgroundColors.parameter(isEnabled: isEnabled, style: style)?.uiColor
        topArrowImageView.tintColor = scheme.wrapViewBackgroundColors.parameter(isEnabled: isEnabled, style: style)?.uiColor
        bottomArrowImageView.tintColor = scheme.wrapViewBackgroundColors.parameter(isEnabled: isEnabled, style: style)?.uiColor
        topRightArrowImageView.tintColor = scheme.wrapViewBackgroundColors.parameter(isEnabled: isEnabled, style: style)?.uiColor
        bottomRightArrowImageView.tintColor = scheme.wrapViewBackgroundColors.parameter(isEnabled: isEnabled, style: style)?.uiColor
        backgroundColor = scheme.backgroundColors.parameter(isEnabled: isEnabled, style: style)?.uiColor
    }
    
    private func updateSchemeFonts() {
        titleLabel.setDynamicFont(
            font: scheme.titleLabelFont.uiFont,
            textStyle: scheme.titleLabelFont.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory)
    }

    private func commonInit() {
        configureUI()
    }
    
    private func configureUI() {
        addSubviews()
        setupViews()
        setupLabels()
        setupArrowView()
        configureConstraints()
    }
    
    private func setupLabels() {
        titleLabel.numberOfLines = 6
        titleLabel.textAlignment = .left
    }
    
    private func setupArrowView() {
        topArrowImageView.image = Constants.topArrowImage
        bottomArrowImageView.image = Constants.bottomArrowImage
        topRightArrowImageView.image = Constants.topArrowImage
        bottomRightArrowImageView.image = Constants.bottomArrowImage
        setArrowDirection(direction: .up)
    }
    
    private func setupViews() {
        wrapView.layer.cornerRadius = LayoutGrid.halfModule
        wrapView.layer.masksToBounds = false
    }
    
    private func addSubviews() {
        [wrapView, topArrowImageView, bottomArrowImageView, topRightArrowImageView, bottomRightArrowImageView].addToSuperview(self)
        [titleLabel].addToSuperview(wrapView)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            wrapView.leadingAnchor.constraint(equalTo: leadingAnchor),
            wrapView.topAnchor.constraint(equalTo: topAnchor, constant: LayoutGrid.module),
            wrapView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomAnchor.constraint(equalTo: wrapView.bottomAnchor, constant: LayoutGrid.module),
            wrapView.widthAnchor.constraint(lessThanOrEqualToConstant: LayoutGrid.quadrupleModule * 9),
            
            topArrowImageViewLeadingConstraint,
            topArrowImageView.widthAnchor.constraint(equalToConstant: Constants.widthImageView),
            topArrowImageView.heightAnchor.constraint(equalToConstant: Constants.heightImageView),
            wrapView.topAnchor.constraint(equalTo: topArrowImageView.bottomAnchor),
            
            bottomArrowImageViewLeadingConstraint,
            bottomArrowImageView.widthAnchor.constraint(equalToConstant: Constants.widthImageView),
            bottomArrowImageView.heightAnchor.constraint(equalToConstant: Constants.heightImageView),
            bottomArrowImageView.topAnchor.constraint(equalTo: wrapView.bottomAnchor),
            
            topRightArrowImageViewTrailingConstraint,
            topRightArrowImageView.widthAnchor.constraint(equalToConstant: Constants.widthImageView),
            topRightArrowImageView.heightAnchor.constraint(equalToConstant: Constants.heightImageView),
            wrapView.topAnchor.constraint(equalTo: topRightArrowImageView.bottomAnchor),

            bottomRightArrowImageTrailingConstraint,
            bottomRightArrowImageView.widthAnchor.constraint(equalToConstant: Constants.widthImageView),
            bottomRightArrowImageView.heightAnchor.constraint(equalToConstant: Constants.heightImageView),
            bottomRightArrowImageView.topAnchor.constraint(equalTo: wrapView.bottomAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: wrapView.leadingAnchor, constant: LayoutGrid.halfModule * 3),
            titleLabel.trailingAnchor.constraint(equalTo: wrapView.trailingAnchor, constant: -LayoutGrid.halfModule * 3),
            titleLabel.topAnchor.constraint(equalTo: wrapView.topAnchor, constant: LayoutGrid.module),
            wrapView.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: LayoutGrid.module)
        ])
    }
    
}
