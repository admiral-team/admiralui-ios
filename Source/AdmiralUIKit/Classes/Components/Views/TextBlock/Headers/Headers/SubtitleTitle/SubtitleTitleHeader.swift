//
//  SubtitleTitleHeader.swift
//  AdmiralUIKit
//
//  Created on 22.02.2022.
//

import UIKit
import AdmiralTheme
import AdmiralUIResources

/**
 SubtitleTitleHeader - A header with header title and subtitle.
 
 You can create a StandardTab by specifying the following parameters in the initializer
 
 ## Initializer parameters:
 
 - title: String? - Title text block
 - subtitle: String? - Subtitle text block
 - headerStyle: HeaderStyle - A style of title and subtitle text block. HeaderStyle can be: itle, body, headline, headlineSecondary, dropDown, paragraph, paragraphSecondary, link, separator, separatorShort, separatorEmpty
 ## Example to create vertical ToolBar:
 # Code
 ```
    SubtitleTitleHeader(title: "Title", subtitle: "Subtitle")
 ```
*/
public class SubtitleTitleHeader: UIView, AnyAppThemable, AccessibilitySupport {
    
    /// The text that the title label displays.
    public var title: String? {
        get { return titleLabel.text }
        set { titleLabel.text = newValue }
    }
    
    /// The text that the subtitle label displays.
    public var subtitle: String? {
        get { return subtitleLabel.text }
        set { subtitleLabel.text = newValue }
    }
    
    /// Header style.
    public var headerStyle: HeaderStyle = .title {
        didSet { updateHeaderStyle() }
    }

    /// Color scheme.
    public var scheme = SubtitleTitleHeaderScheme() {
        didSet { updateScheme() }
    }
    
    // MARK: - AccessibilitySupport
    
    public var adjustsFontForContentSizeCategory: Bool = Appearance.isAccessabilitySupportEnabled {
        didSet { updateSchemeFonts() }
    }
    
    // MARK: - Private Properties
    
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    
    private lazy var heightConstraint: NSLayoutConstraint = {
        return heightAnchor.constraint(greaterThanOrEqualToConstant: headerStyle.height)
    }()
    private lazy var subtitleLabelTopConstraint: NSLayoutConstraint = {
        return subtitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: headerStyle.edgeInsets.top)
    }()
    private lazy var titleLabelBottomConstraint: NSLayoutConstraint = {
        return bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: headerStyle.edgeInsets.bottom)
    }()
    
    // MARK: - Initializer
    
    /// Initializes and returns a newly allocated view object with the zero frame rectangle.
    public init(title: String?, subtitle: String?, headerStyle: HeaderStyle = .title) {
        super.init(frame: .zero)
        self.title = title
        self.subtitle = subtitle
        self.headerStyle = headerStyle
        commonInit()
    }
    
    /// Returns an object initialized from data in a given unarchiver.
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    // MARK: - Public Method
    
    open func apply(theme: AppTheme) {
        scheme = SubtitleTitleHeaderScheme(theme: theme)
    }
    
    // MARK: - Private Methods
    
    private func commonInit() {
        addSubviews()
        configureUI()
        configureLayout()
    }
    
    private func addSubviews() {
        [titleLabel, subtitleLabel].addToSuperview(self)
    }
    
    private func configureLayout() {
        NSLayoutConstraint.activate([
            subtitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: headerStyle.edgeInsets.left),
            trailingAnchor.constraint(equalTo: subtitleLabel.trailingAnchor, constant: headerStyle.edgeInsets.right),
            subtitleLabelTopConstraint,
            
            titleLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: LayoutGrid.halfModule),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: headerStyle.edgeInsets.left),
            titleLabelBottomConstraint,
            trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: headerStyle.edgeInsets.right),
            
            heightConstraint
        ])
    }
    
    private func updateScheme() {
        configure()
    }
    
    private func configure() {
        backgroundColor = scheme.backgroundColor.uiColor
        titleLabel.textColor = scheme.titleColor.parameter(for: .normal, style: headerStyle)?.uiColor
        subtitleLabel.textColor = scheme.subtitleColor.parameter(for: .normal, style: headerStyle)?.uiColor
    }
    
    private func configureUI() {
        apply(theme: defaultTheme)
        updateHeaderStyle()
    }
    
    private func updateHeaderStyle() {
        configure()
        updateSchemeFonts()
        
        heightConstraint.constant = headerStyle.height
        subtitleLabelTopConstraint.constant = headerStyle.edgeInsets.top
        titleLabelBottomConstraint.constant = headerStyle.edgeInsets.bottom
    }
    
    private func updateSchemeFonts() {
        titleLabel.setDynamicFont(
            font: scheme.titleFont.parameter(for: .normal, style: headerStyle)?.uiFont ?? scheme.defaultTitleFont.uiFont,
            textStyle: scheme.titleFont.parameter(for: .normal, style: headerStyle)?.textStyle ?? scheme.defaultTitleFont.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory)
        
        subtitleLabel.setDynamicFont(
            font: scheme.subtitleFont.parameter(for: .normal, style: headerStyle)?.uiFont ?? scheme.defaultTitleFont.uiFont,
            textStyle: scheme.subtitleFont.parameter(for: .normal, style: headerStyle)?.textStyle ?? scheme.defaultTitleFont.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory)
    }
    
}

