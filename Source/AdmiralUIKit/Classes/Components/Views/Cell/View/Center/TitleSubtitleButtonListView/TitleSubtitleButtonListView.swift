//
//  TitleSubtitleButtonListView.swift
//  AdmiralUI
//
//  Created on 18.11.2020.
//

import UIKit
import AdmiralTheme

/// A view object with title, subtitle and button.
public class TitleSubtitleButtonListView: BaseListView, CenterListViewComponent, AnyAppThemable, AccessibilitySupport {
    
    enum Constants {
        static let height: CGFloat = 100.0
    }
    
    // MARK: - Public Properties
    
    /// The text that the title label displays.
    public var title: String? {
        didSet { titleLabel.text = title }
    }

    /// The text that the tag subtitle label displays.
    public var tagSubtitle: String? {
        didSet { subtitleTagLabel.text = tagSubtitle }
    }
    
    /// The text that the tag view displays.
    public var tagText: String? {
        didSet { tagView.title = tagText }
    }
    
    /// The text that the more subtitle displays.
    public var subtitle: String? {
        didSet { subtitleLabel.text = subtitle }
    }
    
    /// The text that the button displays.
    public var buttonTitle: String? {
        didSet { ghostButton.setTitle(buttonTitle, for: .normal) }
    }

    /// The button accessibility id 
    public var buttonAccesibilityId: String? {
        didSet {
            ghostButton.accessibilityIdentifier = buttonAccesibilityId
        }
    }
    
    /// The closure sign that button did select.
    public var didSelect: (() -> Void)?

    /// Color scheme.
    public var scheme = TitleSubtitleButtonListViewScheme() {
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
    
    private let subtitleLabel = UILabel()
    
    private let subtitleTagLabel = UILabel()
    private let tagView = TagControl()
    
    private let ghostButton = UIButton()

    // MARK: - Initializer
    
    /// Initializes and returns a newly allocated view object with the zero frame rectangle.
    public init() {
        super.init(frame: .zero)
        commonInit()
    }
    
    /// Returns an object initialized from data in a given unarchiver.
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    // MARK: - Public Method
    
    open func apply(theme: AppTheme) {
        scheme = TitleSubtitleButtonListViewScheme(theme: theme)
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
        subtitleTagLabel.setDynamicFont(
            font: scheme.subtitleTagFont.uiFont,
            textStyle: scheme.subtitleTagFont.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory)
        subtitleLabel.setDynamicFont(
            font: scheme.subtitleFont.uiFont,
            textStyle: scheme.subtitleFont.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory)
        ghostButton.titleLabel?.setDynamicFont(
            font: scheme.ghostButtonFont.uiFont,
            textStyle: scheme.ghostButtonFont.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory)
        tagView.titleFont = scheme.tagViewFont.uiFont
        tagView.textStyle = scheme.tagViewFont.textStyle
    }
    
    // MARK: - Private Methods
    
    private func configure(for state: UIControl.State) {
        backgroundColor = scheme.backgroundColor.parameter(for: state)?.uiColor
        titleLabel.textColor = scheme.titleLabelTextColor.parameter(for: state)?.uiColor
        subtitleLabel.textColor = scheme.subtitleLabelTextColor.parameter(for: state)?.uiColor
        
        subtitleTagLabel.textColor = scheme.subtitleTagLabelTextColor.parameter(for: state)?.uiColor
        
        ghostButton.setTitleColor(scheme.buttonTitleColor.parameter(for: state)?.uiColor, for: state)
        
        tagView.isEnabled = state == .disabled ? false : true
        tagView.style = .additional
        ghostButton.isEnabled = isEnabled
    }

    private func commonInit() {
        addSubviews()
        configureUI()
        configureLayout()
    }
    
    private func addSubviews() {
        [titleLabel,
         subtitleTagLabel,
         tagView,
         subtitleLabel,
         ghostButton
        ].addToSuperview(self)
    }
    
    private func configureLayout() {
        let constraintSubtitleLeading = tagView.leadingAnchor.constraint(equalTo: subtitleTagLabel.trailingAnchor, constant: LayoutGrid.halfModule)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: LayoutGrid.halfModule * 3),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutGrid.doubleModule),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: LayoutGrid.doubleModule),
            titleLabel.heightAnchor.constraint(equalToConstant: LayoutGrid.halfModule * 5),
            
            constraintSubtitleLeading,
            
            subtitleTagLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: LayoutGrid.halfModule),
            subtitleTagLabel.heightAnchor.constraint(equalToConstant: LayoutGrid.halfModule * 5),
            subtitleTagLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutGrid.doubleModule),
            trailingAnchor.constraint(greaterThanOrEqualTo: tagView.trailingAnchor, constant: LayoutGrid.doubleModule),
            
            tagView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: LayoutGrid.halfModule),
            tagView.heightAnchor.constraint(equalToConstant: 20.0),
            
            subtitleLabel.topAnchor.constraint(equalTo: subtitleTagLabel.bottomAnchor, constant: LayoutGrid.module),
            subtitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutGrid.doubleModule),
            trailingAnchor.constraint(equalTo: subtitleLabel.trailingAnchor, constant: LayoutGrid.doubleModule),
            
            ghostButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutGrid.doubleModule),
            ghostButton.heightAnchor.constraint(equalToConstant: LayoutGrid.halfModule * 5),
            ghostButton.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: LayoutGrid.halfModule * 3),
            ghostButton.heightAnchor.constraint(equalToConstant: LayoutGrid.halfModule * 5),
            trailingAnchor.constraint(greaterThanOrEqualTo: ghostButton.trailingAnchor, constant: LayoutGrid.doubleModule),
            bottomAnchor.constraint(equalTo: ghostButton.bottomAnchor, constant: LayoutGrid.halfModule * 3)
        ])
    }
    
    private func configureUI() {
        apply(theme: defaultTheme)
        
        titleLabel.numberOfLines = 0
        subtitleLabel.numberOfLines = 0
        subtitleTagLabel.numberOfLines = 0
        
        tagView.setCornerRadius(4.0)
        ghostButton.addTarget(self, action: #selector(buttonDidSelect(_:)), for: .touchUpInside)
    }
    
    @objc private func buttonDidSelect(_ button: UIButton) {
        didSelect?()
    }
    
}
