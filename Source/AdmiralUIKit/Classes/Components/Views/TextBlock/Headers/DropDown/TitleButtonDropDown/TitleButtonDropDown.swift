//
//  TitleButtonDropDown.swift
//  AdmiralUIKit
//
//  Created on 24.02.2022.
//

import UIKit
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

*/

public protocol TitleButtonDropDownDelegate: AnyObject {
    func tapTitleButtonDropDownButton(_ button: UIButton)
}

/// A header with header title.
public class TitleButtonDropDown: UIView, AnyAppThemable, AccessibilitySupport {
    
    public weak var delegate: TitleButtonDropDownDelegate?
    
    /// A Boolean value indicating whether the control is in the enabled state.
    open var isEnabled: Bool = true {
        didSet { updateScheme()  }
    }
    
    /// The text that the label displays.
    public var title: String? {
        get { return textLabel.text }
        set { textLabel.text = newValue }
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
    
    public var adjustsFontForContentSizeCategory: Bool = Appearance.isAccessabilitySupportEnabled {
        didSet { updateSchemeFonts() }
    }
    
    // MARK: - Internal Properties
    
    var scheme = TitleButtonDropDownScheme() {
        didSet { updateScheme() }
    }
    
    // MARK: - Private Properties
    
    private let textLabel = UILabel()
    private let ghostButton = HeaderButtonWithArrow()
    
    /// Header style.
    private let headerStyle: HeaderStyle = .title
    
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
    public init(title: String?, buttonTitle: String?, dropDownHeaderType: DropDownHeaderType?) {
        super.init(frame: .zero)
        self.title = title
        self.buttonTitle = buttonTitle
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
        scheme = TitleButtonDropDownScheme(theme: theme)
    }
    
    // MARK: - Private Methods
    
    private func commonInit() {
        addSubviews()
        configureUI()
        configureLayout()
    }
    
    private func addSubviews() {
        [textLabel, ghostButton].addToSuperview(self)
    }
    
    private func configureLayout() {
        NSLayoutConstraint.activate([
            textLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: headerStyle.edgeInsets.left),
            textLabelTopConstraint,
            textLabelBottomConstraint,
            
            ghostButton.leadingAnchor.constraint(greaterThanOrEqualTo: textLabel.trailingAnchor, constant: LayoutGrid.doubleModule),
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
        textLabel.textColor = scheme.textColor.parameter(for: isEnabled ? .normal : .disabled)?.uiColor
        ghostButton.scheme = scheme.ghostButtonScheme
        ghostButton.isEnabled = isEnabled
    }
    
    private func configureUI() {
        apply(theme: defaultTheme)
        updateButtonTitle()
        updateHeaderStyle()
        updateImageView()
        
        ghostButton.addTarget(self, action: #selector(tapGhostButton(_:)), for: .touchUpInside)
    }
    
    @objc private func tapGhostButton(_ button: UIButton) {
        delegate?.tapTitleButtonDropDownButton(button)
    }
    
    private func updateImageView() {
        ghostButton.dropDownHeaderType = dropDownHeaderType
    }
    
    private func updateButtonTitle() {
        ghostButton.text = buttonTitle
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
            font: scheme.titleFont.uiFont,
            textStyle: scheme.titleFont.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory)
    }
    
}
