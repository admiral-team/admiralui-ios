//
//  ButtonDropDown.swift
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

public protocol ButtonDropDownDelegate: AnyObject {
    func tapButtonDropDownButton(_ button: UIButton)
}

/// A header with header title.
public class ButtonDropDown: UIView, AnyAppThemable {
    
    public weak var delegate: TitleButtonDropDownDelegate?
    
    /// A Boolean value indicating whether the control is in the enabled state.
    open var isEnabled: Bool = true {
        didSet { updateScheme()  }
    }
    
    /// The text that the button displays.
    public var buttonTitle: String? {
        didSet { updateButtonTitle() }
    }
    
    /// Drop down header type.
    public var dropDownHeaderType: DropDownHeaderType? {
        didSet { updateImageView() }
    }

    /// Color scheme.
    public var scheme = ButtonDropDownScheme() {
        didSet { updateScheme() }
    }

    // MARK: - Private Properties
    
    private let ghostButton = HeaderButtonWithArrow()
    private let headerStyle: HeaderStyle = .title
    
    private lazy var heightConstraint: NSLayoutConstraint = {
        return heightAnchor.constraint(greaterThanOrEqualToConstant: headerStyle.height)
    }()
    private lazy var topConstraint: NSLayoutConstraint = {
        return ghostButton.topAnchor.constraint(equalTo: topAnchor, constant: headerStyle.edgeInsets.top)
    }()
    private lazy var bottomConstraint: NSLayoutConstraint = {
        return bottomAnchor.constraint(equalTo: ghostButton.bottomAnchor, constant: headerStyle.edgeInsets.bottom)
    }()
    
    // MARK: - Initializer
    
    /// Initializes and returns a newly allocated view object with the zero frame rectangle.
    public init(buttonTitle: String?, dropDownHeaderType: DropDownHeaderType?) {
        super.init(frame: .zero)
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
        scheme = ButtonDropDownScheme(theme: theme)
    }
    
    // MARK: - Private Methods
    
    private func commonInit() {
        addSubviews()
        configureUI()
        configureLayout()
    }
    
    private func addSubviews() {
        [ghostButton].addToSuperview(self)
    }
    
    private func configureLayout() {
        NSLayoutConstraint.activate([
            topConstraint,
            bottomConstraint,
            ghostButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: headerStyle.edgeInsets.left),
            trailingAnchor.constraint(greaterThanOrEqualTo: ghostButton.trailingAnchor, constant: headerStyle.edgeInsets.right),
            
            heightConstraint
        ])
    }
    
    private func updateScheme() {
        configure()
    }
    
    private func configure() {
        backgroundColor = scheme.backgroundColor.uiColor
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
        
        heightConstraint.constant = headerStyle.height
        topConstraint.constant = headerStyle.edgeInsets.top
        bottomConstraint.constant = headerStyle.edgeInsets.bottom
    }
    
}
