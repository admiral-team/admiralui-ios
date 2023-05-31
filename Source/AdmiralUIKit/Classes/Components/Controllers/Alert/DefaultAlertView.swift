//
//  DefaultAlertView.swift
//  AdmiralUI
//
//  Created on 09.11.2020.
//

import UIKit
import AdmiralTheme
/**
 DefaultAlertView - the component that presents a warning message to the user with diffrent options.
 You can create a DefaultAlertView with the zero frame rectangle by specifying the following parameters in init:
 ## Initializer parameters:
 - title: String? - Title label text.
 - message: String? - Message label text.
 - image: UIImage? - An image of imageView..
 - actions: String - The actions that the user can take in response to the alert or action sheet..
 - messageLabelTextAlignment: String - Message label text alignment..
 - messageFont: String - Message label font style..
 - titleFont: String - Title label font style.
 - messageTextColor: String - Message label text color..
 - titleTextColor: String - Title label text color.

 ## Example to create DefaultAlertView
 # Code
 ```
     let alertView = DefaultAlertView()
     alertView.title = "Hello"
     alertView.message = World
     alertView.image = UIImage()
```
 */
/// Alert view interface.
public protocol AlertView: AnyObject {
    
    /// The title of the alert.
    var title: String? { get set }
    
    /// Descriptive text that provides more details about the reason for the alert.
    var message: String? { get set }
    
    /// The image of the alert.
    var image: UIImage? { get set }
    
    /// The actions that the user can take in response to the alert or action sheet.
    var actions: [AlertAction] { get }
    
    /// Attaches an action object to the alert or action sheet.
    /// - Parameter action: The action object to display as part of the alert. Actions are displayed as buttons in the alert. The action object provides the button text and the action to be performed when that button is tapped.
    func addAction(_ action: AlertAction)

}

/// Type size image from alert view.
public enum AlertViewImageType {
    case illustration
    case icon
}

/// Font style of tittle label from alert view.
public enum AlertTitleFontStyle: Int {
    case title1
    case title2
    case subtitle1
    case subtitle2
    case headLine
}

/// Font style of message label from alert view.
public enum AlertMessageFontStyle: Int {
    case body1
    case body2
    case subhead4
    case subhead3
}

/// Text color for labels from alert view.
public enum AlertColorStyle: Int {
    case additional
    case mask
    case primary
    case secondary
}

/// The class that showing a warning message to the user with diffrent options.
public final class DefaultAlertView: UIView, AlertView, AnyAppThemable, AccessibilitySupport {

    // MARK: - Constants
    
    enum Constants {
        static let imageViewIllustrationWidth: CGFloat = 140.0
        static let imageViewIllustrationHeight: CGFloat = 140.0
        
        static let imageViewIconWidth: CGFloat = 54.0
        static let imageViewIconHeight: CGFloat = 54.0
    }
    
    // MARK: - Public Properties

    /// Title label text.
    public var title: String? {
        get { return titleLabel.text }
        set { titleLabel.text = newValue }
    }

    /// Message label text.
    public var message: String? {
        get { return messageLabel.text }
        set { messageLabel.text = newValue }
    }

    /// An image of imageView.
    public var image: UIImage? {
        get { return imageView.image }
        set {
            imageView.image = newValue
            updateImageViewLayout()
        }
    }

    /// Type alert.
    public var type: AlertViewImageType = .illustration {
        didSet { updateImageViewLayout() }
    }

    /// Color scheme.
    public var scheme = DefaultAlertViewCustomScheme() {
        didSet { updateScheme() }
    }
    
    /// The actions that the user can take in response to the alert or action sheet.
    public var actions: [AlertAction] {
        return stackActions
    }

    /// Message label text alignment.
    public var messageLabelTextAlignment: NSTextAlignment {
        get {
            return messageLabel.textAlignment
        } set {
            messageLabel.textAlignment = newValue
        }
    }

    /// Message label number of lines.
    public var messageLabelNumberOfLines: Int {
        get {
            return messageLabel.numberOfLines
        } set {
            messageLabel.numberOfLines = newValue
        }
    }

    /// Title label text color.
    public var titleTextColor: AlertColorStyle {
        get {
            return titleTextLabelColor
        } set {
            titleTextLabelColor = newValue
            updateScheme()
        }
    }
    /// Message label text color.
    public var messageTextColor: AlertColorStyle {
        get {
            return messageTextLabelColor
        } set {
            messageTextLabelColor = newValue
            updateScheme()
        }
    }

    /// Message label font style.
    public var messageFont: AlertMessageFontStyle {
        get {
            return messageLabelFontStyle
        } set {
            messageLabelFontStyle = newValue
            updateScheme()
        }
    }
    /// Title label font style.
    public var titleFont: AlertTitleFontStyle {
        get {
            return titleLabelFontStyle
        } set {
            titleLabelFontStyle = newValue
            updateScheme()
        }
    }

    // MARK: - AccessibilitySupport
    
    public var adjustsFontForContentSizeCategory: Bool = Appearance.isAccessabilitySupportEnabled {
        didSet { updateSchemeFonts() }
    }
    
    // MARK: - AnyAppThemable
    
    public func apply(theme: AppTheme) {
        scheme = DefaultAlertViewCustomScheme(theme: theme)
    }
    
    // MARK: - Private Properties
    
    private let titleLabel = UILabel()
    private let messageLabel = UILabel()
    private let imageView = UIImageView()

    private var titleTextLabelColor: AlertColorStyle = .primary
    private var messageTextLabelColor: AlertColorStyle = .additional

    private var messageLabelFontStyle: AlertMessageFontStyle = .subhead3
    private var titleLabelFontStyle: AlertTitleFontStyle = .title1

    private var stackActions = [AlertAction]() {
        didSet { updateStackView() }
    }
    
    private lazy var actionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = LayoutGrid.module
        return stackView
    }()
    
    private lazy var imageViewWidthConstraint: NSLayoutConstraint = {
        return imageView.widthAnchor.constraint(equalToConstant: 0.0)
    }()

    private lazy var imageViewHeightConstraint: NSLayoutConstraint = {
        return imageView.heightAnchor.constraint(equalToConstant: 0.0)
    }()
    
    // MARK: - Initializer
    
    /// Initializes and returns a newly allocated view object with the specified frame rectangle.
    public override init(frame: CGRect) {
        super.init(frame: .zero)
        commonInit()
    }
    
    /// Returns an object initialized from data in a given unarchiver.
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    // MARK: - Public Methods
    
    /// Attaches an action object to the alert or action sheet.
    /// - Parameter action: The action object to display as part of the alert. Actions are displayed as buttons in the alert. The action object provides the button text and the action to be performed when that button is tapped.
    public func addAction(_ action: AlertAction) {
        stackActions.append(action)
    }
    
    // MARK: - Private Methods
    
    private func commonInit() {
        apply(theme: defaultTheme)
        
        configurationUI()
        addSubviews()
        configureLayout()
    }
    
    private func configurationUI() {
        titleLabel.textAlignment = .center
        messageLabel.textAlignment = .center

        titleLabel.numberOfLines = 2
        messageLabel.numberOfLines = 0
        
        imageView.contentMode = .scaleAspectFit
        
        layer.cornerRadius = LayoutGrid.doubleModule
        clipsToBounds = true
    }
    
    private func addSubviews() {
        [titleLabel, messageLabel, imageView, actionStackView].addToSuperview(self)
    }
    
    private func configureLayout() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: LayoutGrid.quadrupleModule),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageViewWidthConstraint,
            imageViewHeightConstraint,
            
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutGrid.doubleModule),
            trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: LayoutGrid.doubleModule),
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: LayoutGrid.halfModule * 5),
            
            messageLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            messageLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: LayoutGrid.halfModule * 2.5),
            
            actionStackView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            actionStackView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            actionStackView.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: LayoutGrid.module * 5),
            bottomAnchor.constraint(equalTo: actionStackView.bottomAnchor, constant: LayoutGrid.doubleModule)
        ])
    }
    
    private func updateImageViewLayout() {
        switch type {
        case .illustration:
            imageViewWidthConstraint.constant = Constants.imageViewIllustrationWidth
            imageViewHeightConstraint.constant = Constants.imageViewIllustrationHeight
        case .icon:
            imageViewWidthConstraint.constant = Constants.imageViewIconWidth
            imageViewHeightConstraint.constant = Constants.imageViewIconHeight
        }
    }
    
    private func updateStackView() {
        actionStackView.arrangedSubviews.forEach({ $0.removeFromSuperview() })
        
        for index in 0..<stackActions.count {
            let action = stackActions[index]
            
            var button: CustomButton
            switch action.style {
            case .primary:
                button = PrimaryButton()
            case .alternative:
                button = GhostButton()
            }
            
            button.setTitle(action.title, for: [.normal])
            button.tag = index
            button.addTarget(self, action: #selector(tapButton(_:)), for: .touchUpInside)
            actionStackView.addArrangedSubview(button)
        }
    }
    
    private func updateScheme() {
        updateSchemeFonts()
        updateSchemeColors()
        updateActionsScheme()
    }
    
    private func updateSchemeColors() {
        titleLabel.textColor = scheme.titleColor.parameter(style: titleTextLabelColor)?.uiColor
        messageLabel.textColor = scheme.titleColor.parameter(style: messageTextLabelColor)?.uiColor
        backgroundColor = scheme.backgroundColor.uiColor
    }
    
    private func updateSchemeFonts() {
        titleLabel.setDynamicFont(
            font: scheme.titleFont.parameter(style: titleLabelFontStyle)?.uiFont ?? scheme.defaultTitleFont.uiFont,
            textStyle: scheme.titleFont.parameter(style: titleLabelFontStyle)?.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory
        )
        messageLabel.setDynamicFont(
            font: scheme.messageFont.parameter(style: messageLabelFontStyle)?.uiFont ?? scheme.defaultMessageFont.uiFont,
            textStyle: scheme.messageFont.parameter(style: messageLabelFontStyle)?.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory
        )
    }
    
    private func updateActionsScheme() {
        actionStackView.arrangedSubviews.forEach {
            if let primary = $0 as? PrimaryButton {
                primary.scheme = scheme.primaryButtonScheme
            } else if let alternative = $0 as? GhostButton {
                alternative.scheme =  scheme.ghostButtonScheme
            }
        }
    }
    
    @objc private func tapButton(_ button: CustomButton) {
        guard button.tag < stackActions.count else { return }
        
        stackActions[button.tag].handler?(stackActions[button.tag])
    }
    
}
