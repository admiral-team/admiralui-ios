//
//  BigInformer.swift
//  AdmiralUI
//
//  Created on 24.11.2020.
//

import UIKit
import AdmiralTheme

/// The style of informer.
public enum InformerStyle: Int {
    /// The default state of the informer.
    case `default`
    /// The success state of the informer.
    case success
    /// The attention state of the informer.
    case attention
    /// The error state of the informer is useful to show the number of errors.
    case error
}

public protocol BigInformerDelegate: AnyObject {
    func didTapLinkLabel(_ bigInformer: BigInformer)
}

/// Informer is a component that used to show some information.
open class BigInformer: UIView, AnyAppThemable, AccessibilitySupport {
     
    // MARK: - Public Properties
    
    /// Informers delegate to handle tap to link label.
    weak open var delegate: BigInformerDelegate?
    
    /// The font of title
    open var titleFont: UIFont? {
        get { return titleLabel.font }
        set { titleLabel.font = newValue }
    }
    
    /// The font of description label.
    open var descriptionFont: UIFont? {
        get { return descriptionLabel.font }
        set { descriptionLabel.font = newValue }
    }
    
    /// The font of link label.
    var linkLabelFont: UIFont? {
        get { return linkLabel.font }
        set { linkLabel.font = newValue }
    }
    
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
    open var linkText: String? {
        get { return linkLabel.text }
        set { linkLabel.text = newValue }
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
    open var linkLabelNumerOfLines: Int {
        get { return linkLabel.numberOfLines }
        set { linkLabel.numberOfLines = newValue }
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
    public var scheme = BigInformerScheme() {
        didSet { updateScheme() }
    }
    
    // MARK: - AccessibilitySupport
    
    public var adjustsFontForContentSizeCategory: Bool = Appearance.isAccessabilitySupportEnabled {
        didSet { updateSchemeFonts() }
    }
    
    // MARK: - Private Properties
    
    private enum Constants {
        static let arrowImage = Asset.Custom.Segment.arrowUp.image
        static let heightImageView: CGFloat = LayoutGrid.module
        static let widthImageView: CGFloat = LayoutGrid.doubleModule
    }

    private let wrapView = UIView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let linkLabel = UILabel()
    private let arrowImageView = UIImageView()
    
    private lazy var arrowImageViewLeadingConstraint: NSLayoutConstraint = {
        return arrowImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutGrid.halfModule * 5)
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
        scheme = BigInformerScheme(theme: theme)
    }
    
    // MARK: - Private Methods

    private func updateScheme() {
        updateSchemeFonts()
        updateSchemeColors()
    }
    
    private func updateSchemeColors() {
        titleLabel.textColor = scheme.titleLabelTextColors.parameter(isEnabled: isEnabled, style: style)?.uiColor
        descriptionLabel.textColor = scheme.descriptionLabelTextColors.parameter(isEnabled: isEnabled, style: style)?.uiColor
        linkLabel.textColor = scheme.linkLabelTextColors.parameter(isEnabled: isEnabled, style: style)?.uiColor
        linkLabel.isUserInteractionEnabled = isEnabled
        wrapView.backgroundColor = scheme.wrapViewBackgroundColors.parameter(isEnabled: isEnabled, style: style)?.uiColor
        arrowImageView.tintColor = scheme.wrapViewBackgroundColors.parameter(isEnabled: isEnabled, style: style)?.uiColor
    }
    
    private func updateSchemeFonts() {
        titleLabel.setDynamicFont(
            font: scheme.titleLabelFont.uiFont,
            textStyle: scheme.titleLabelFont.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory)
        descriptionLabel.setDynamicFont(
            font: scheme.descriptionLabelFont.uiFont,
            textStyle: scheme.descriptionLabelFont.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory)
        linkLabel.setDynamicFont(
            font: scheme.linkLabelFont.uiFont,
            textStyle: scheme.linkLabelFont.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory)
    }
    
    private func commonInit() {
        configureUI()
    }
    
    private func configureUI() {
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
        
        linkLabel.numberOfLines = 1
        linkLabel.textAlignment = .left
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(linkLabelTapped))
        linkLabel.addGestureRecognizer(tapGesture)
    }
    
    private func setupArrowView() {
        arrowImageView.image = Constants.arrowImage
    }
    
    private func addSubviews() {
        [wrapView, arrowImageView].addToSuperview(self)
        [titleLabel, descriptionLabel, linkLabel].addToSuperview(wrapView)
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
            
            titleLabel.leadingAnchor.constraint(equalTo: wrapView.leadingAnchor, constant: LayoutGrid.doubleModule),
            titleLabel.topAnchor.constraint(equalTo: wrapView.topAnchor, constant: LayoutGrid.halfModule * 5),
            wrapView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: LayoutGrid.doubleModule),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: wrapView.leadingAnchor, constant: LayoutGrid.doubleModule),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: LayoutGrid.module),
            wrapView.trailingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor, constant: LayoutGrid.doubleModule),
            
            linkLabel.leadingAnchor.constraint(equalTo: wrapView.leadingAnchor, constant: LayoutGrid.doubleModule),
            wrapView.bottomAnchor.constraint(equalTo: linkLabel.bottomAnchor, constant: LayoutGrid.halfModule * 5),
            wrapView.trailingAnchor.constraint(equalTo: linkLabel.trailingAnchor, constant: LayoutGrid.doubleModule),
            linkLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: LayoutGrid.doubleModule)
        ])
    }
    
    @objc private func linkLabelTapped() {
        delegate?.didTapLinkLabel(self)
    }
    
}
