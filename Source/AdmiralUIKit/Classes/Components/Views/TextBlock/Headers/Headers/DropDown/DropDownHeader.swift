//
//  DropDownHeader.swift
//  AdmiralUIKit
//
//  Created on 21.02.2022.
//

import AdmiralTheme
import UIKit

/**
 DropDownHeader - A header with header title, arrow and button.

 You can create a DropDownHeader by specifying the following parameters in the initializer
 
 ## Initializer parameters:
 
 - title: String? - Title text block
 - dropDownHeaderType: DropDownHeaderType? - A type of header. DropDownHeaderType can be: up, down, custom
 - headerStyle: HeaderStyle - A style of title and size view. HeaderStyle can be: title, body, headline, headlineSecondary.
 
 ## Example to create DropDownHeader with title and dropDownHeaderType:
 # Code
    DropDownHeader(title: "Title", dropDownHeaderType: .down, headerStyle: .title)
*/
public class DropDownHeader: UIView, AnyAppThemable, AccessibilitySupport {
    
    /// The text that the label displays.
    public var title: String? {
        get { textLabel.text }
        set { textLabel.text = newValue }
    }
    
    /// Drop down header type.
    public var dropDownHeaderType: DropDownHeaderType = .down {
        didSet { updateImageView() }
    }
    
    /// Header style.
    public var headerStyle: HeaderStyle = .title {
        didSet { updateHeaderStyle() }
    }

    /// Color scheme.
    public var scheme = DropDownHeaderScheme() {
        didSet { updateScheme() }
    }
    
    // MARK: - AccessibilitySupport
    
    public var adjustsFontForContentSizeCategory: Bool = Appearance.isAccessabilitySupportEnabled {
        didSet { updateSchemeFonts() }
    }

    // MARK: - Private Properties
    
    private let textLabel = UILabel()
    private let arrowImageView = UIImageView()
    
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
    public init(
        title: String?,
        dropDownHeaderType: DropDownHeaderType = .down,
        headerStyle: HeaderStyle = .title) {
            super.init(frame: .zero)
            self.title = title
            self.headerStyle = headerStyle
            self.dropDownHeaderType = dropDownHeaderType
            commonInit()
    }
    
    /// Returns an object initialized from data in a given unarchiver.
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    // MARK: - Public Method
    
    open func apply(theme: AppTheme) {
        scheme = DropDownHeaderScheme(theme: theme)
    }
    
    // MARK: - Private Methods
    
    private func commonInit() {
        addSubviews()
        configureUI()
        configureLayout()
    }
    
    private func addSubviews() {
        [textLabel, arrowImageView].addToSuperview(self)
    }
    
    private func configureLayout() {
        NSLayoutConstraint.activate([
            textLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: headerStyle.edgeInsets.left),
            textLabelTopConstraint,
            textLabelBottomConstraint,
            arrowImageView.trailingAnchor.constraint(equalTo: textLabel.trailingAnchor, constant: LayoutGrid.doubleModule),
            
            arrowImageView.heightAnchor.constraint(equalToConstant: LayoutGrid.halfModule * 7),
            arrowImageView.widthAnchor.constraint(equalToConstant: LayoutGrid.halfModule * 7),
            trailingAnchor.constraint(equalTo: arrowImageView.trailingAnchor, constant: headerStyle.edgeInsets.right),
            arrowImageView.centerYAnchor.constraint(equalTo: textLabel.centerYAnchor),
            
            heightConstraint
        ])
    }
    
    private func updateScheme() {
        configure()
    }
    
    private func configure() {
        backgroundColor = scheme.backgroundColor.uiColor
        textLabel.textColor = scheme.textColor.parameter(for: .normal, style: headerStyle)?.uiColor
        arrowImageView.tintColor = scheme.imageTintColor.uiColor
    }
    
    private func configureUI() {
        apply(theme: defaultTheme)
        updateHeaderStyle()
        updateImageView()
    }
    
    private func updateImageView() {
        arrowImageView.image = dropDownHeaderType.image
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
