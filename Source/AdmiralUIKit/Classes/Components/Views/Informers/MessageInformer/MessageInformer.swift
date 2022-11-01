//
//  MessageInformer.swift
//  AdmiralUI
//
//  Created on 25.11.2020.
//

import UIKit
import AdmiralTheme
import AdmiralUIResources

/// MessageInformer is a component that used to show some information.
open class MessageInformer: UIView, AnyAppThemable, AccessibilitySupport {
    
    // MARK: - Public Properties
    
    /// The title text that the informer is displaying.
    open var titleText: String? {
        get { return titleLabel.text }
        set { titleLabel.text = newValue }
    }
    
    /// The description text that the informer is displaying.
    open var descriptionText: String? {
        get { return descriptionLabel.text }
        set { descriptionLabel.text = newValue }
    }
    
    /// The link text that the informer is displaying.
    open var subtitleText: String? {
        get { return subtitleLabel.text }
        set { subtitleLabel.text = newValue }
    }
    
    /// The number of lines of title label.
    open var titleLabelNumerOfLines: Int {
        get { return titleLabel.numberOfLines }
        set { titleLabel.numberOfLines = newValue }
    }
    
    /// The number of lines of description label.
    open var descriptionLabelNumerOfLines: Int {
        get { return descriptionLabel.numberOfLines }
        set { descriptionLabel.numberOfLines = newValue }
    }
    
    /// The number of lines of link label.
    open var subtitleLabelNumerOfLines: Int {
        get { return subtitleLabel.numberOfLines }
        set { subtitleLabel.numberOfLines = newValue }
    }
    
    /// A Boolean value indicating whether the control is in the enabled state.
    open var isEnabled: Bool = true {
        didSet { updateScheme() }
    }
    
    /// An image for description label
    open var descriptionImage: UIImage? {
        didSet {
            if descriptionImage != nil {
                descriptionImageView.image = descriptionImage
            } else {
                descriptionImage = nil
                disactiveDescriptionImageViewConstratint()
            }
        }
    }
    
    var scheme = MessageInformerScheme() {
        didSet { updateScheme() }
    }
    
    // MARK: - AccessibilitySupport
    
    public var adjustsFontForContentSizeCategory: Bool = Appearance.isAccessabilitySupportEnabled {
        didSet { updateSchemeFonts() }
    }
    
    // MARK: - Private Properties
    
    private enum Constants {
        static let arrowImage: UIImage = SystemAsset.Custom.Segment.arrowUp.image
        static let heightImageView: CGFloat = LayoutGrid.module
        static let widthImageView: CGFloat = LayoutGrid.doubleModule
        static let questionImage: UIImage = Asset.Service.Solid.helpSolid.image
    }
    
    private let wrapView = UIView()
    private let labelsView = UIView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let descriptionImageView = UIImageView()
    private let arrowImageView = UIImageView()
    
    private lazy var arrowImageViewLeadingConstraint: NSLayoutConstraint = {
        return arrowImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutGrid.halfModule * 5)
    }()
    
    private lazy var descriptionImageWidthConstraint: NSLayoutConstraint = {
        return descriptionImageView.widthAnchor.constraint(equalToConstant: LayoutGrid.module * 3)
    }()
    
    private lazy var descriptionImageViewLeadingConstraint: NSLayoutConstraint = {
        return descriptionImageView.leadingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor, constant: LayoutGrid.halfModule * 3)
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
    open func setArrowPivotLeadingAnchorPoint(constant: CGFloat, animated: Bool = true) {
        arrowImageViewLeadingConstraint.constant = constant
        if animated {
            UIView.animate(
                withDuration: Durations.Default.single,
                delay: 0,
                options: [.curveEaseInOut],
                animations: {
                    self.layoutIfNeeded()
                },
                completion: nil)
        } else {
            layoutIfNeeded()
        }
    }
    
    // MARK: - AnyAppTheamable
    
    open func apply(theme: AppTheme) {
        scheme = MessageInformerScheme(theme: theme)
    }
    
    // MARK: - Private Methods
    
    private func updateScheme() {
        updateSchemeFonts()
        updateSchemeColors()
    }
    
    private func updateSchemeColors() {
        titleLabel.textColor = scheme.titleLabelTextColors.parameter(isEnabled: isEnabled)?.uiColor
        descriptionLabel.textColor = scheme.descriptionLabelTextColors.parameter(isEnabled: isEnabled)?.uiColor
        subtitleLabel.textColor = scheme.subtitleLabelTextColors.parameter(isEnabled: isEnabled)?.uiColor
        wrapView.backgroundColor = scheme.wrapViewBackgroundColors.parameter(isEnabled: isEnabled)?.uiColor
        arrowImageView.tintColor = scheme.wrapViewBackgroundColors.parameter(isEnabled: isEnabled)?.uiColor
        backgroundColor = scheme.backgroundColors.parameter(isEnabled: isEnabled)?.uiColor
        descriptionImageView.tintColor = scheme.descriptionImageViewTintColors.parameter(isEnabled: isEnabled)?.uiColor
        if descriptionImageView.image?.renderingMode != UIImage.RenderingMode.alwaysTemplate {
            descriptionImageView.alpha = scheme.descriptionImageViewAlpha.parameter(isEnabled: isEnabled) ?? 1.0
        }
    }
    
    private func updateSchemeFonts() {
        titleLabel.setDynamicFont(
            font: scheme.titleLabelFont.uiFont,
            textStyle: scheme.titleLabelFont.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory)
        
        subtitleLabel.setDynamicFont(
            font: scheme.subtitleLabelFont.uiFont,
            textStyle: scheme.subtitleLabelFont.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory)
        
        descriptionLabel.setDynamicFont(
            font: scheme.descriptionLabelFont.uiFont,
            textStyle: scheme.descriptionLabelFont.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory)
    }
    
    private func commonInit() {
        configureUI()
    }
    
    private func configureUI() {
        apply(theme: defaultTheme)
        
        setupLabels()
        addSubviews()
        setupArrowView()
        configureConstraints()
    }
    
    private func setupLabels() {
        titleLabel.numberOfLines = 1
        titleLabel.textAlignment = .left
        
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .left
        
        subtitleLabel.numberOfLines = 0
        subtitleLabel.textAlignment = .left
    }
    
    private func disactiveDescriptionImageViewConstratint() {
        descriptionImageWidthConstraint.constant = 0.0
        descriptionImageViewLeadingConstraint.constant = 0.0
        setNeedsLayout()
    }
    
    private func setupArrowView() {
        arrowImageView.image = Constants.arrowImage
        descriptionImageView.image = Constants.questionImage
    }
    
    private func addSubviews() {
        [wrapView, arrowImageView].addToSuperview(self)
        [labelsView].addToSuperview(wrapView)
        [titleLabel, descriptionLabel, subtitleLabel, descriptionImageView].addToSuperview(labelsView)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            wrapView.leadingAnchor.constraint(equalTo: leadingAnchor),
            wrapView.topAnchor.constraint(equalTo: topAnchor, constant: LayoutGrid.module),
            wrapView.trailingAnchor.constraint(equalTo: trailingAnchor),
            wrapView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            arrowImageViewLeadingConstraint,
            arrowImageView.widthAnchor.constraint(equalToConstant: Constants.widthImageView),
            arrowImageView.heightAnchor.constraint(equalToConstant: Constants.heightImageView),
            wrapView.topAnchor.constraint(equalTo: arrowImageView.bottomAnchor),
            
            labelsView.widthAnchor.constraint(equalToConstant: LayoutGrid.module * 33),
            labelsView.topAnchor.constraint(equalTo: wrapView.topAnchor, constant: LayoutGrid.module * 3),
            labelsView.centerXAnchor.constraint(equalTo: wrapView.centerXAnchor),
            wrapView.bottomAnchor.constraint(equalTo: labelsView.bottomAnchor, constant: 30),
            
            titleLabel.leadingAnchor.constraint(equalTo: labelsView.leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: labelsView.topAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: labelsView.trailingAnchor),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: labelsView.leadingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: LayoutGrid.module),
            descriptionImageViewLeadingConstraint,
            
            descriptionImageView.centerYAnchor.constraint(equalTo: descriptionLabel.centerYAnchor),
            descriptionImageView.heightAnchor.constraint(equalToConstant: LayoutGrid.module * 3),
            descriptionImageView.trailingAnchor.constraint(lessThanOrEqualTo: labelsView.trailingAnchor),
            descriptionImageWidthConstraint,
            
            subtitleLabel.leadingAnchor.constraint(equalTo: labelsView.leadingAnchor),
            subtitleLabel.bottomAnchor.constraint(equalTo: labelsView.bottomAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: labelsView.trailingAnchor),
            subtitleLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: LayoutGrid.doubleModule)
        ])
    }
    
}
