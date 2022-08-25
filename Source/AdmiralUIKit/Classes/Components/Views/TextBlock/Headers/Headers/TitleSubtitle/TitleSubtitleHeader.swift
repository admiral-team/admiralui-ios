//
//  TitleSubtitleHeader.swift
//  AdmiralUIKit
//
//  Created on 22.02.2022.
//

import UIKit
import AdmiralTheme
import AdmiralUIResources

/**
 TitleSubtitleHeader - A header with header title and subtitle.
 
 You can create a StandardTab by specifying the following parameters in the initializer
 
 ## Initializer parameters:
 
 - title: String? - Title text block
 - subtitle: String? - Subtitle text block
 - headerStyle: HeaderStyle - A style of title and subtitle text block. HeaderStyle can be: itle, body, headline, headlineSecondary, dropDown, paragraph, paragraphSecondary, link, separator, separatorShort, separatorEmpty
 ## Example to create vertical ToolBar:
 # Code
 ```
    TitleSubtitleHeader(title: "Title", subtitle: "Subtitle")
 ```
*/
public class TitleSubtitleHeader: UIView, AnyAppThemable, AccessibilitySupport {
    
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
    
    // MARK: - AccessibilitySupport
    
    public var adjustsFontForContentSizeCategory: Bool = Appearance.shared.isAccessabilitySupportEnabled {
        didSet { updateSchemeFonts() }
    }
    
    // MARK: - Internal Properties
    
    var scheme = TitleSubtitleHeaderScheme() {
        didSet { updateScheme() }
    }
    
    // MARK: - Private Properties
    
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    
    private lazy var heightConstraint: NSLayoutConstraint = {
        return heightAnchor.constraint(greaterThanOrEqualToConstant: headerStyle.height)
    }()
    private lazy var titleLabelTopConstraint: NSLayoutConstraint = {
        return titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: headerStyle.edgeInsets.top)
    }()
    private lazy var subtitleLabelBottomConstraint: NSLayoutConstraint = {
        return bottomAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: headerStyle.edgeInsets.bottom)
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
        scheme = TitleSubtitleHeaderScheme(theme: theme)
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
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: headerStyle.edgeInsets.left),
            titleLabelTopConstraint,
            trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: headerStyle.edgeInsets.right),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: LayoutGrid.halfModule),
            subtitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: headerStyle.edgeInsets.left),
            trailingAnchor.constraint(equalTo: subtitleLabel.trailingAnchor, constant: headerStyle.edgeInsets.right),
            subtitleLabelBottomConstraint,
            
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
        titleLabelTopConstraint.constant = headerStyle.edgeInsets.top
        subtitleLabelBottomConstraint.constant = headerStyle.edgeInsets.bottom
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
