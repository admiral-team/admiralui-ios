//
//  TextOperationView.swift
//  AdmiralUIKit
//
//  Created on 14.12.2021.
//

import UIKit
import AdmiralTheme
import AdmiralUIResources

/**
 TextOperationView - the component that presents a rounded view with title, description and chatBubbleStatusView.

 You can create a TextOperationView with the zero frame rectangle by specifying the following parameters in init:
 ## Initializer parameters:

 style: TextOperationViewStyle - The style of TextOperationView.

 chatStatus: ChatStatus? - The status of ChatBubbleStatusView.

 direction: ChatDirection - The direction of ChatBubbleStatusView.

 time: String - A time of TextOperationView.

 title: String - A title text of TextOperationView.

 description: String - A description text of TextOperationView.

 ## Example to create TextOperationView
 # Code
 ```
     let textOperationView = TextOperationView()
     textOperationView.style = .success
     textOperationView.chatStatus = .receive
     textOperationView.direction = .left
     textOperationView.timeName = "21:21"
     textOperationView.titleName = "+ 35 000 ₽"
     textOperationView.discriptionName =  "НПО «Ромашка»"
```
 */

public enum TextOperationViewStyle: Int {
    /// The success state of the TextOperationView.
    case success
    /// The error state of the TextOperationView.
    case error
    /// The default state of the TextOperationView.
    case `default`
}

/// A component that presents a rounded view with title, description and chatBubbleStatusView.
public final class TextOperationView: UIView, AnyAppThemable {

    // MARK: - Constants

    private enum Constants {
        static let width: CGFloat = LayoutGrid.module * 29
        static let textBlockstackViewSpacing = LayoutGrid.halfModule
        static let trailingConstant: CGFloat = LayoutGrid.tripleModule / 2
        static let topAnchor: CGFloat = LayoutGrid.module
        static let padding: CGFloat = LayoutGrid.quadrupleModule
    }

    // MARK: - Public properties

    /// The chatStatus.
    public var chatStatus: ChatStatus? = nil {
        didSet {
            chatStatusBubbleView.chatStatus = chatStatus
            updateScheme()
        }
    }

    /// Direction message.
    public var chatDirection: ChatDirection = .right {
        didSet {
            chatStatusBubbleView.chatDirection = chatDirection
            updateScheme()
        }
    }

    /// TextOperationView style.
    public var style: TextOperationViewStyle? {
        get { return textOperationStyle }
        set {
            textOperationStyle = newValue
            updateScheme()
        }
    }

    /// The title label name text.
    public var titleName: String? {
        get { return titleLabel.text }
        set {
            titleLabel.text = newValue
            updateScheme()
        }
    }

    /// Text description name text.
    public var discriptionName: String? {
        get { return discriptionLabel.text }
        set {
            discriptionLabel.text = newValue
            updateScheme()
        }
    }

    /// Time text.
    public var timeName: String? {
        get { return timeLabel.text }
        set {
            timeLabel.text = newValue
            updateScheme()
        }
    }

    /// ChatBubbleStatusView time label text.
    public var chatBubbleTime: String? {
        get { return chatStatusBubbleView.timeTitle }
        set {
            chatStatusBubbleView.timeTitle = newValue
            updateScheme()
        }
    }

    public var adjustsFontForContentSizeCategory: Bool = Appearance.isAccessabilitySupportEnabled {
        didSet { updateFonts() }
    }

    // MARK: - Internal Properties

    var scheme = TextOperationViewScheme() {
        didSet { updateScheme() }
    }

    private var textBlockStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical
        stackView.spacing = Constants.textBlockstackViewSpacing
        return stackView
    }()

    private let errorView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = PrivateAsset.Custom.Chat.error.image
        return imageView
    }()

    // MARK: - Private properties

    private var textOperationStyle: TextOperationViewStyle?
    private let titleLabel = UILabel()
    private let discriptionLabel = UILabel()
    private let timeLabel = UILabel()
    private let textOperationView = UIView()
    private var chatStatusBubbleView = ChatBubbleStatusView()
    private var trailingConstraint = NSLayoutConstraint()
    private var errorTrailingConstraint = NSLayoutConstraint()

    // MARK: - Initializer

    public init() {
        super.init(frame: .zero)
        commonInit()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func apply(theme: AppTheme) {
        self.scheme = TextOperationViewScheme(theme: theme)
    }

    // MARK: - Private methods

    private func commonInit() {
        addSubviews()
        setupViews()
        configureUI()
        setupConstraints()
    }

    private func addSubviews() {
        textBlockStackView.addArrangedSubview(titleLabel)
        textBlockStackView.addArrangedSubview(discriptionLabel)
        [textOperationView, errorView].addToSuperview(self)
        [textBlockStackView, timeLabel, chatStatusBubbleView].addToSuperview(textOperationView)
    }

    private func setupViews() {
        textOperationView.layer.cornerRadius = LayoutGrid.tripleModule / 2
    }

    private func configureUI() {
        textOperationView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }

    private func setupConstraints() {
        trailingConstraint = trailingAnchor.constraint(equalTo: textOperationView.trailingAnchor, constant: LayoutGrid.doubleModule)
        errorTrailingConstraint = errorView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: .zero)

        NSLayoutConstraint.activate([
            textOperationView.widthAnchor.constraint(equalToConstant: Constants.width),
            textBlockStackView.leadingAnchor.constraint(equalTo: textOperationView.leadingAnchor, constant: Constants.trailingConstant),
            textBlockStackView.topAnchor.constraint(equalTo: textOperationView.topAnchor, constant: Constants.topAnchor),
            textOperationView.trailingAnchor.constraint(equalTo: textBlockStackView.trailingAnchor, constant: Constants.trailingConstant),

            trailingConstraint,
            errorTrailingConstraint,
            bottomAnchor.constraint(equalTo: errorView.bottomAnchor, constant: LayoutGrid.module),

            timeLabel.leadingAnchor.constraint(equalTo: textOperationView.leadingAnchor, constant: Constants.trailingConstant),
            timeLabel.topAnchor.constraint(equalTo: textBlockStackView.bottomAnchor, constant: Constants.topAnchor),

            textOperationView.trailingAnchor.constraint(equalTo: chatStatusBubbleView.trailingAnchor, constant: Constants.trailingConstant),
            chatStatusBubbleView.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: LayoutGrid.halfModule),
            textOperationView.bottomAnchor.constraint(equalTo: chatStatusBubbleView.bottomAnchor, constant: Constants.topAnchor)
        ])
    }

    private func updateScheme() {
        updateFonts()
        updateColors()
        updateUI()
    }

    private func updateUI() {
        errorView.isHidden = !(textOperationStyle == .error && chatDirection == .right)
        updateTrailingConstraints()
    }

    private func updateTrailingConstraints() {
        trailingConstraint.isActive = chatStatusBubbleView.chatDirection == .right
        errorTrailingConstraint.isActive = chatStatusBubbleView.chatDirection == .right
        trailingConstraint.constant = textOperationStyle == .default || textOperationStyle == .success ? .zero : Constants.padding
    }

    private func updateColors() {
        textOperationView.backgroundColor = scheme.backgroundColor.parameter(style: textOperationStyle ?? .default)?.uiColor
        titleLabel.textColor = scheme.titleColor.parameter(style: textOperationStyle ?? .default)?.uiColor
        discriptionLabel.textColor = scheme.desciptionColor.uiColor
        timeLabel.textColor = scheme.timeColor.uiColor
    }

    private func updateFonts() {
        titleLabel.setDynamicFont(
            font: scheme.titleFont.uiFont,
            textStyle: scheme.titleFont.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory
        )
        discriptionLabel.setDynamicFont(
            font: scheme.desciptionFont.uiFont,
            textStyle: scheme.desciptionFont.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory
        )
        timeLabel.setDynamicFont(
            font: scheme.timeFont.uiFont,
            textStyle: scheme.timeFont.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory
        )
    }

}
