//
//  TitleMoreDetailTextMessageListView.swift
//  AdmiralUI
//
//  Created on 17.11.2020.
//

import AdmiralTheme
import AdmiralUIResources
import UIKit

/// A view object with title, more label, detaile label and message view..
public class TitleMoreDetailTextMessageListView: BaseListView, CenterListViewComponent, AnyAppThemable, AccessibilitySupport {
    
    enum Constants {
        static let height: CGFloat = 120.0
    }
    
    // MARK: - Public Properties
    
    /// The text that the title label displays.
    public var title: String? {
        didSet { titleLabel.text = title }
    }
    
    /// The text that the more label displays.
    public var more: String? {
        didSet { moreLabel.text = more }
    }
    
    /// The text that the detaile label displays.
    public var detaile: String? {
        didSet { detaileTitleLabel.text = detaile }
    }
    
    /// The text that the detaile more label displays.
    public var detaileMore: String? {
        didSet { detaileMoreLabel.text = detaileMore }
    }

    /// The text that the subtitle label displays.
    public var subtitle: String? {
        didSet { subtitleLabel.text = subtitle }
    }
    
    /// The text that the tag view displays.
    public var tagText: String? {
        didSet { tagView.title = tagText }
    }
    
    /// The text that the message label displays.
    public var messageText: String? {
        didSet { messageTitleLabel.text = messageText }
    }

    /// Color scheme.
    public var scheme = TitleMoreDetailTextMessageListViewScheme() {
        didSet { updateScheme() }
    }
    
    // MARK: Internal Properties
    
    /// The state of the view. Default is normal.
    override var state: UIControl.State {
        didSet { configure(for: state) }
    }
    
    // MARK: - AccessibilitySupport
    
    public var adjustsFontForContentSizeCategory: Bool = Appearance.isAccessabilitySupportEnabled {
        didSet { updateSchemeFonts() }
    }
    
    // MARK: - Private Properties
    
    private let titleLabel = UILabel()
    private let moreLabel = UILabel()
    
    private let detaileTitleLabel = UILabel()
    private let detaileMoreLabel = UILabel()
    
    private let subtitleLabel = UILabel()
    private let tagView = TagControl()
    
    private let infoImageView = UIImageView()
    
    private let messageTitleLabel = UILabel()
    private let messageView = UIView()

    // MARK: - Initializer
    
    /// Initializes and returns a newly allocated view object with the zero frame rectangle.
    public init() {
        super.init(frame: .zero)
        commonInit()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        roundCorners(corners: [.bottomLeft, .topRight, .bottomRight], radius: LayoutGrid.doubleModule)
    }
    
    /// Returns an object initialized from data in a given unarchiver.
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    // MARK: - Public Method
    
    open func apply(theme: AppTheme) {
        scheme = TitleMoreDetailTextMessageListViewScheme(theme: theme)
        tagView.apply(theme: theme)
    }
    
    // MARK: - Private Methods
    
    private func updateScheme() {
        updateSchemeFonts()
        configure(for: state)
    }
    
    private func updateSchemeFonts() {
        titleLabel.setDynamicFont(
            font: scheme.titleFont.uiFont,
            textStyle: scheme.titleFont.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory)
        subtitleLabel.setDynamicFont(
            font: scheme.subtitleFont.uiFont,
            textStyle: scheme.subtitleFont.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory)
        moreLabel.setDynamicFont(
            font: scheme.moreFont.uiFont,
            textStyle: scheme.moreFont.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory)
        detaileTitleLabel.setDynamicFont(
            font: scheme.detaileTitleFont.uiFont,
            textStyle: scheme.detaileTitleFont.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory)
        detaileMoreLabel.setDynamicFont(
            font: scheme.detaileMoreFont.uiFont,
            textStyle: scheme.detaileMoreFont.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory)
        subtitleLabel.setDynamicFont(
            font: scheme.subtitleFont.uiFont,
            textStyle: scheme.subtitleFont.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory)
        tagView.titleFont = scheme.tagViewFont.uiFont
        tagView.textStyle = scheme.tagViewFont.textStyle
        messageTitleLabel.setDynamicFont(
            font: scheme.messageTitleFont.uiFont,
            textStyle: scheme.messageTitleFont.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory)
    }
    
    // MARK: - Private Methods
    
    private func configure(for state: UIControl.State) {
        backgroundColor = scheme.backgroundColor.parameter(for: state)?.uiColor
        titleLabel.textColor = scheme.titleLabelTextColor.parameter(for: state)?.uiColor
        subtitleLabel.textColor = scheme.subtitleLabelTextColor.parameter(for: state)?.uiColor
        
        moreLabel.textColor = scheme.moreLabelTextColor.parameter(for: state)?.uiColor
        
        detaileTitleLabel.textColor = scheme.detaileTitleLabelTextColor.parameter(for: state)?.uiColor
        detaileMoreLabel.textColor = scheme.detaileMoreLabelTextColor.parameter(for: state)?.uiColor
        
        infoImageView.tintColor = scheme.infoImageViewTintColor.parameter(for: state)?.uiColor
        
        tagView.isEnabled = state == .disabled ? false : true
        tagView.style = .additional
        
        messageView.backgroundColor = scheme.messageViewBackgroundColor.parameter(for: state)?.uiColor
        messageTitleLabel.textColor = scheme.messageTitleLabelTitleColor.parameter(for: state)?.uiColor
    }

    private func commonInit() {
        addSubviews()
        configureUI()
        configureLayout()
    }
    
    private func addSubviews() {
        [titleLabel,
         moreLabel,
         detaileTitleLabel,
         detaileMoreLabel,
         infoImageView,
         subtitleLabel,
         tagView,
         messageView
        ].addToSuperview(self)
        
        [messageTitleLabel].addToSuperview(messageView)
    }
    
    private func configureLayout() {
        let constraintMoreLeading = moreLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: LayoutGrid.halfModule)
        constraintMoreLeading.priority = .defaultHigh
        
        let constraintDetaileLeading = detaileMoreLabel.leadingAnchor.constraint(equalTo: detaileTitleLabel.trailingAnchor, constant: LayoutGrid.halfModule)
        constraintDetaileLeading.priority = .defaultHigh
        
        let constraintSubtitleLeading = tagView.leadingAnchor.constraint(equalTo: subtitleLabel.trailingAnchor, constant: LayoutGrid.halfModule)
        constraintSubtitleLeading.priority = .defaultHigh
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: LayoutGrid.halfModule * 3),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutGrid.doubleModule),
            titleLabel.heightAnchor.constraint(equalToConstant: LayoutGrid.halfModule * 5),
            moreLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: LayoutGrid.doubleModule),
            
            constraintMoreLeading,
            moreLabel.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            moreLabel.heightAnchor.constraint(equalToConstant: LayoutGrid.halfModule * 4),
            trailingAnchor.constraint(greaterThanOrEqualTo: moreLabel.trailingAnchor),
            
            detaileTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: LayoutGrid.halfModule),
            detaileTitleLabel.heightAnchor.constraint(equalToConstant: LayoutGrid.halfModule * 5),
            detaileTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutGrid.doubleModule),
            infoImageView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: LayoutGrid.doubleModule),

            constraintDetaileLeading,
            detaileMoreLabel.topAnchor.constraint(equalTo: detaileTitleLabel.topAnchor, constant: 3.0),
            detaileMoreLabel.heightAnchor.constraint(equalToConstant: LayoutGrid.doubleModule),
            
            infoImageView.heightAnchor.constraint(equalToConstant: LayoutGrid.doubleModule),
            infoImageView.widthAnchor.constraint(equalToConstant: LayoutGrid.doubleModule),
            infoImageView.leadingAnchor.constraint(equalTo: detaileMoreLabel.trailingAnchor, constant: LayoutGrid.halfModule),
            infoImageView.bottomAnchor.constraint(equalTo: detaileTitleLabel.bottomAnchor),
            
            constraintSubtitleLeading,
            
            subtitleLabel.topAnchor.constraint(equalTo: detaileTitleLabel.bottomAnchor, constant: LayoutGrid.halfModule),
            subtitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutGrid.doubleModule),
            tagView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: LayoutGrid.doubleModule),
            
            tagView.centerYAnchor.constraint(equalTo: subtitleLabel.centerYAnchor),
            tagView.heightAnchor.constraint(equalToConstant: 20.0),
            
            messageTitleLabel.centerYAnchor.constraint(equalTo: messageView.centerYAnchor),
            messageTitleLabel.centerXAnchor.constraint(equalTo: messageView.centerXAnchor),
            
            messageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutGrid.doubleModule),
            messageView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 10.0),
            messageView.heightAnchor.constraint(equalToConstant: LayoutGrid.module * 4),
            trailingAnchor.constraint(greaterThanOrEqualTo: messageView.trailingAnchor, constant: LayoutGrid.doubleModule),
            messageView.widthAnchor.constraint(equalTo: messageTitleLabel.widthAnchor, constant: LayoutGrid.doubleModule),
            bottomAnchor.constraint(equalTo: messageView.bottomAnchor, constant: LayoutGrid.halfModule * 3)
        ])
    }
    
    private func configureUI() {
        apply(theme: defaultTheme)
    
        moreLabel.numberOfLines = 1
        titleLabel.numberOfLines = 1
        subtitleLabel.numberOfLines = 1
        detaileMoreLabel.numberOfLines = 1
        detaileTitleLabel.numberOfLines = 1
        messageTitleLabel.numberOfLines = 1
        
        messageTitleLabel.textAlignment = .center
        
        infoImageView.image = Asset.Service.Outline.infoOutline.image

        tagView.setCornerRadius(4.0)
    }
    
    private func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: messageView.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        messageView.layer.mask = mask
    }
    
}
