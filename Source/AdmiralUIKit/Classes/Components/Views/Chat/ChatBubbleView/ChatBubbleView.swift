//
//  ChatBubbleView.swift
//  AdmiralUIKit
//
//  Created on 03.12.2021.
//

import UIKit
import AdmiralTheme
import AdmiralUIResources

public enum ChatStatus: String {
    case loading
    case error
    case sent
    case receive
    case read
    case none
}

public enum ChatBubbleState {
    case error
    case `default`
}

public enum ChatDirection: String {
    case left
    case right
}

public final class ChatBubbleView: UIView, AnyAppThemable {

    // MARK: - Constants

    private enum Constants {
        static let padding: CGFloat = LayoutGrid.quadrupleModule
        static let imageSize: CGFloat = LayoutGrid.halfModule * 7
    }

    // MARK: - Public properties

    /// The chatStatus.
    public var chatStatus: ChatStatus? {
        get { return chatStatusBubbleView.chatStatus }
        set {
            chatStatusBubbleView.chatStatus = newValue 
            updateScheme()
        }
    }

    /// Direction message.
    public var chatDirection: ChatDirection? {
        get { return chatStatusBubbleView.chatDirection }
        set {
            chatStatusBubbleView.chatDirection = newValue ?? .right
            updateScheme()
        }
    }

    /// The state of ChatBubbleView.
    public var state: ChatBubbleState = .default {
        didSet {
            updateScheme()
        }
    }

    /// The name label
    public var name: String? {
        get { return nameLabel.text }
        set {
            nameLabel.text = newValue
        }
    }

    /// Text message.
    public var messageText: String? {
        get { return messageTextLabel.text }
        set {
            messageTextLabel.text = newValue
            updateWidthAnchor()
        }
    }

    /// Time text.
    public var timeTitle: String? {
        get { return chatStatusBubbleView.timeTitle }
        set { chatStatusBubbleView.timeTitle = newValue }
    }

    public var adjustsFontForContentSizeCategory: Bool = Appearance.isAccessabilitySupportEnabled {
        didSet { updateFonts() }
    }

    // MARK: - Private computed properties

    private let errorView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Asset.Service.Solid.errorSolid.image
        return imageView
    }()

    private var maskedCorner: CACornerMask {
        switch chatDirection {
        case .left:
            return [.layerMaxXMinYCorner, .layerMaxXMaxYCorner, .layerMinXMinYCorner]
        default:
            return [.layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
        }
    }

    // MARK: - Internal Properties

    var scheme = ChatBubbleViewScheme() {
        didSet { updateScheme() }
    }

    // MARK: - Private properties

    private var chatStatusBubbleView = ChatBubbleStatusView()
    private var messageTextLabel = UILabel()
    private var nameLabel = UILabel()
    private let messageView = UIView()

    private var nameTopAnchor = NSLayoutConstraint()
    private var messageViewWidthConstraint = NSLayoutConstraint()
    private var messageViewStaticWidthConstraint = NSLayoutConstraint()
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
        self.scheme = ChatBubbleViewScheme(theme: theme)
    }

    // MARK: - Private methods

    private func commonInit() {
        autoManage()
        addSubviews()
        setupViews()
        configureUI()
        setupConstraints()
    }

    private func addSubviews() {
        [messageView].addToSuperview(self)
        [nameLabel, messageTextLabel, chatStatusBubbleView, errorView].addToSuperview(messageView)
    }

    private func setupConstraints() {
        messageViewWidthConstraint  = messageView.widthAnchor.constraint(lessThanOrEqualToConstant: LayoutGrid.quadrupleModule * 9)
        messageViewStaticWidthConstraint = messageView.widthAnchor.constraint(equalToConstant: 77)
        trailingConstraint = trailingAnchor.constraint(equalTo: messageView.trailingAnchor, constant: LayoutGrid.doubleModule)
        errorTrailingConstraint = errorView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: .zero)
        nameTopAnchor = nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: LayoutGrid.module)

        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            nameTopAnchor,

            bottomAnchor.constraint(equalTo: errorView.bottomAnchor, constant: LayoutGrid.module),
            messageView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: LayoutGrid.module),
            trailingConstraint,
            errorTrailingConstraint,
            bottomAnchor.constraint(equalTo: messageView.bottomAnchor, constant: LayoutGrid.module),
            
            errorView.widthAnchor.constraint(equalToConstant: Constants.imageSize),
            errorView.heightAnchor.constraint(equalToConstant: Constants.imageSize),

            messageTextLabel.leadingAnchor.constraint(equalTo: messageView.leadingAnchor, constant: LayoutGrid.halfModule * 3),
            messageView.trailingAnchor.constraint(equalTo: messageTextLabel.trailingAnchor, constant: LayoutGrid.halfModule * 3),
            messageTextLabel.topAnchor.constraint(equalTo: messageView.topAnchor, constant: LayoutGrid.module),
            messageView.trailingAnchor.constraint(equalTo: chatStatusBubbleView.trailingAnchor, constant: LayoutGrid.halfModule * 3),
            chatStatusBubbleView.topAnchor.constraint(equalTo: messageTextLabel.bottomAnchor, constant: LayoutGrid.halfModule),
            messageView.bottomAnchor.constraint(equalTo: chatStatusBubbleView.bottomAnchor, constant: LayoutGrid.module),
            messageViewWidthConstraint,
            messageViewStaticWidthConstraint
        ])
    }

    private func updateWidthAnchor() {
        guard let text = messageTextLabel.text,
              text.count >= 6
        else {
            messageViewWidthConstraint.isActive = false
            messageViewStaticWidthConstraint.isActive = true
            return
        }
        messageViewWidthConstraint.isActive = true
        messageViewStaticWidthConstraint.isActive = false
    }

    private func updateTrailingConstraints() {
        trailingConstraint.isActive = chatStatusBubbleView.chatDirection == .right
        errorTrailingConstraint.isActive = chatStatusBubbleView.chatDirection == .right
        trailingConstraint.constant = state == .default ? .zero : Constants.padding
    }

    private func setupViews() {
        messageView.layer.cornerRadius = LayoutGrid.tripleModule / 2
    }

    private func configureUI() {
        messageTextLabel.numberOfLines = .zero
        messageTextLabel.textAlignment = chatStatusBubbleView.chatDirection == .left ? .left : .right
        messageTextLabel.font = scheme.textFont.uiFont
        nameLabel.font = scheme.nameTextFont.uiFont
        errorView.tintColor = scheme.errorImageColor.uiColor
    }

    private func updateScheme() {
        updateFonts()
        updateColors()
        updateUI()
    }

    private func updateUI(){
        messageView.layer.maskedCorners = maskedCorner
        errorView.isHidden = !(state == .error && chatDirection == .right)
        updateTrailingConstraints()
        nameLabel.isHidden = !(chatDirection == .left)
        nameTopAnchor.constant = chatDirection == .left ? LayoutGrid.module : .zero
    }

    private func updateColors() {
        messageView.backgroundColor = scheme.backgroundColor.parameter(for: chatDirection ?? .left)?.uiColor
        messageTextLabel.textColor = scheme.textColor.parameter(for: chatDirection ?? .left)?.uiColor
        nameLabel.textColor = scheme.nameTextColor.uiColor
    }

    private func updateFonts() {
        messageTextLabel.setDynamicFont(
            font: scheme.textFont.uiFont,
            textStyle: scheme.textFont.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory
        )
        nameLabel.setDynamicFont(
            font: scheme.nameTextFont.uiFont,
            textStyle: scheme.nameTextFont.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory
        )
    }

}
