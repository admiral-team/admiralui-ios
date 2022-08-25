//
//  ArrowWithButtonHeader.swift
//  AdmiralUIKit
//
//  Created on 22.02.2022.
//

import UIKit
import AdmiralTheme
import AdmiralUIResources

/// ArrowWithButtonHeader delegate.
public protocol ArrowWithButtonHeaderDelegate: AnyObject {
    
    /**
     Tells the delegate that the button selected.
     
     - Parameter button: - current button.
     */
    func tapArrowWithButtonHeaderButton(_ button: UIButton)
}

/**
 ArrowWithButtonHeader - A header with header title, arrow and button.

 You can create a TitleArrowWithButtonHeader by specifying the following parameters in the initializer
 
 ## Initializer parameters:
 
 - title: String? - Title text block
 - buttonTitle: String - Title button
 - buttonAction: () -> () - The callback action by tapping the button
 - renderingMode: Image.TemplateRenderingMode - Rendering mode for image
 - dropDownHeaderType: DropDownHeaderType? - A type of header. DropDownHeaderType can be: up, down, custom
 - headerStyle: HeaderStyle - A style of header text block. HeaderStyle can be: title, body, headline, headlineSecondary
 
 ## Example to create vertical TitleArrowWithButtonHeader:
 # Code
 ```
    TitleArrowWithButtonHeader(
        title: "Title",
        buttonTitle: "Button",
        dropDownHeaderType: .up)
 ```
*/
public class ArrowWithButtonHeader: UIView, AnyAppThemable, AccessibilitySupport {
    
    public weak var delegate: ArrowWithButtonHeaderDelegate?
    
    /// The text that the label displays.
    public var title: String? {
        get { return textLabel.text }
        set { textLabel.text = newValue }
    }
    
    /// Header style.
    public var headerStyle: HeaderStyle = .title {
        didSet { updateHeaderStyle() }
    }
    
    /// The text that the button displays.
    public var buttonTitle: String? {
        didSet { updateButtonTitle() }
    }
    
    /// Drop down header type.
    public var dropDownHeaderType: DropDownHeaderType? {
        didSet { updateImageView() }
    }
    
    // MARK: - AccessibilitySupport
    
    public var adjustsFontForContentSizeCategory: Bool = Appearance.shared.isAccessabilitySupportEnabled {
        didSet { updateSchemeFonts() }
    }
    
    // MARK: - Internal Properties
    
    var scheme = ArrowWithButtonHeaderScheme() {
        didSet { updateScheme() }
    }
    
    // MARK: - Private Properties
    
    private let textLabel = UILabel()
    private let arrowImageView = UIImageView()
    private let ghostButton = GhostButton()
    
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
    public init(title: String?, buttonTitle: String?, dropDownHeaderType: DropDownHeaderType?, headerStyle: HeaderStyle = .title) {
        super.init(frame: .zero)
        self.title = title
        self.buttonTitle = buttonTitle
        self.dropDownHeaderType = dropDownHeaderType
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
        scheme = ArrowWithButtonHeaderScheme(theme: theme)
    }
    
    // MARK: - Private Methods
    
    private func commonInit() {
        addSubviews()
        configureUI()
        configureLayout()
    }
    
    private func addSubviews() {
        [textLabel, arrowImageView, ghostButton].addToSuperview(self)
    }
    
    private func configureLayout() {
        NSLayoutConstraint.activate([
            textLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: headerStyle.edgeInsets.left),
            textLabelTopConstraint,
            textLabelBottomConstraint,
            
            arrowImageView.leadingAnchor.constraint(equalTo: textLabel.trailingAnchor, constant: LayoutGrid.module),
            arrowImageView.heightAnchor.constraint(equalToConstant: LayoutGrid.halfModule * 7),
            arrowImageView.widthAnchor.constraint(equalToConstant: LayoutGrid.halfModule * 7),
            arrowImageView.centerYAnchor.constraint(equalTo: textLabel.centerYAnchor),
            
            ghostButton.leadingAnchor.constraint(greaterThanOrEqualTo: arrowImageView.trailingAnchor, constant: LayoutGrid.doubleModule),
            ghostButton.centerYAnchor.constraint(equalTo: textLabel.centerYAnchor),
            trailingAnchor.constraint(equalTo: ghostButton.trailingAnchor, constant: headerStyle.edgeInsets.right),
            
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
        ghostButton.scheme = scheme.ghostButtonScheme
    }
    
    private func configureUI() {
        apply(theme: defaultTheme)
        updateButtonTitle()
        updateHeaderStyle()
        updateImageView()
        
        ghostButton.addTarget(self, action: #selector(tapGhostButton(_:)), for: .touchUpInside)
    }
    
    @objc private func tapGhostButton(_ button: UIButton) {
        delegate?.tapArrowWithButtonHeaderButton(button)
    }
    
    private func updateImageView() {
        arrowImageView.image = dropDownHeaderType?.image
    }
    
    private func updateButtonTitle() {
        ghostButton.setTitle(buttonTitle, for: .normal)
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

