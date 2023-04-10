//
//  TitleHeader.swift
//  AdmiralUIKit
//
//  Created on 21.02.2022.
//

import UIKit
import AdmiralCore
import AdmiralTheme
import AdmiralUIResources

/**
 TitleHeader - A header with header title, arrow and button.

 You can create a TitleHeader by specifying the following parameters in the initializer
 
 ## Initializer parameters:
 
 - title: String? - The text that the label displays
 - textAligment: NSTextAlignment - Alignment title text block
 - headerStyle: HeaderStyle - A style of title and size view. HeaderStyle can be: title, body, headline, headlineSecondary.
 
 ## Example to create TitleHeader with title and textAligment:
    TitleHeader(title: "Title", textAligment: .left, headerStyle: .title)
*/
public class TitleHeader: UIView, AnyAppThemable, AccessibilitySupport {
    
    /// The text that the label displays.
    public var title: String? {
        get { return textLabel.text }
        set { textLabel.text = newValue }
    }
    
    /// Text aligment.
    public var textAligment: NSTextAlignment {
        get { return textLabel.textAlignment }
        set { textLabel.textAlignment = newValue }
    }
    
    /// Header style.
    public var headerStyle: HeaderStyle = .title {
        didSet { updateHeaderStyle() }
    }

    /// Color scheme.
    public var scheme = TitleHeaderScheme() {
        didSet { updateScheme() }
    }
    
    // MARK: - AccessibilitySupport
    
    public var adjustsFontForContentSizeCategory: Bool = Appearance.isAccessabilitySupportEnabled {
        didSet { updateSchemeFonts() }
    }
    
    // MARK: - Private Properties
    
    private let textLabel = UILabel()
    private lazy var heightConstraint: NSLayoutConstraint = {
        return heightAnchor.constraint(greaterThanOrEqualToConstant: headerStyle.height)
    }()
    private lazy var textLabelTopConstraint: NSLayoutConstraint = {
        return textLabel.topAnchor.constraint(equalTo: topAnchor, constant: headerStyle.edgeInsets.top)
    }()
    private lazy var textLabelBottomConstraint: NSLayoutConstraint = {
        return bottomAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: headerStyle.edgeInsets.bottom)
    }()
    
    // MARK: - Initializer
    
    /// Initializes and returns a newly allocated view object with the zero frame rectangle.
    public init(title: String?, textAligment: NSTextAlignment = .left, headerStyle: HeaderStyle = .title) {
        super.init(frame: .zero)
        self.title = title
        self.textAligment = textAligment
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
        scheme = TitleHeaderScheme(theme: theme)
    }
    
    // MARK: - Private Methods
    
    private func commonInit() {
        addSubviews()
        configureUI()
        configureLayout()
    }
    
    private func addSubviews() {
        [textLabel].addToSuperview(self)
    }
    
    private func configureLayout() {
        NSLayoutConstraint.activate([
            textLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: headerStyle.edgeInsets.left),
            textLabelTopConstraint,
            textLabelBottomConstraint,
            trailingAnchor.constraint(equalTo: textLabel.trailingAnchor, constant: headerStyle.edgeInsets.right),
            
            heightConstraint
        ])
    }
    
    private func updateScheme() {
        configure()
    }
    
    private func configure() {
        backgroundColor = scheme.backgroundColor.uiColor
        textLabel.textColor = scheme.textColor.parameter(for: .normal, style: headerStyle)?.uiColor
    }
    
    private func configureUI() {
        apply(theme: defaultTheme)
        updateHeaderStyle()
    }
    
    private func updateHeaderStyle() {
        configure()
        updateSchemeFonts()
        
        heightConstraint.constant = headerStyle.height
        textLabelTopConstraint.constant = headerStyle.edgeInsets.top
        textLabelBottomConstraint.constant = headerStyle.edgeInsets.bottom
    }
    
    private func updateSchemeFonts() {
        textLabel.setDynamicFont(
            font: scheme.titleFont.parameter(for: .normal, style: headerStyle)?.uiFont ?? scheme.defaultTitleFont.uiFont,
            textStyle: scheme.titleFont.parameter(for: .normal, style: headerStyle)?.textStyle ?? scheme.defaultTitleFont.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory)
    }
    
}
