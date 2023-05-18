//
//  ChatBubbleStatusView.swift
//  AdmiralUIKit
//
//  Created on 03.12.2021.
//

import UIKit
import AdmiralTheme

/// The style of ChatBubbleStatusView.
public enum ChatBubbleStatusStyle: Int {
    /// The default style of ChatBubbleStatusStyle.
    case `default`
    /// The light style of ChatBubbleStatusStyle.
    case light
}
/**
 ChatBubbleStatusView - A view for chat message with time.

 You can create a ChatBubbleStatusView by specifying the following parameters in the initializer

 ## Initializer parameters:

 - time: String - Time text message
 - status: ChatStatus - A status ChatBubbleView. Can be in the following states: loading, error, sent, receive, read
 - direction: ChatDirection - A direction for text mesage. Can be: left, right
 - time: String - Time text message.
 - style: ChatBubbleStatusStyle - The style ChatBubbleStatusView

 ## Example to create ChatBubbleStatusView:
 # Code
 ```
 let chatStatusBubbleView = ChatBubbleStatusView()
 ```
*/
public class ChatBubbleStatusView: UIView, AnyAppThemable {

    // MARK: - Constants

    private enum Constants {
        static let stackViewSpacing = LayoutGrid.halfModule
        static let width: CGFloat = 53
        static let minWidth: CGFloat = 33
    }

    // MARK: - Public properties

    /// The chat status of ChatBubbleStatusView.
    public var chatStatus: ChatStatus? = nil {
        didSet {
            updateScheme()
        }
    }

    /// The direction of ChatBubbleStatusView.
    public var chatDirection: ChatDirection? {
        didSet {
            updateScheme()
        }
    }

    /// The style of ChatBubbleStatusView.
    public var style: ChatBubbleStatusStyle = .default {
        didSet {
            updateScheme()
        }
    }

    /// The time title text label.
    public var timeTitle: String? {
        get { return timeLabel.text }
        set { timeLabel.text = newValue }
    }

    // MARK: - AccessibilitySupport

    public var adjustsFontForContentSizeCategory: Bool = Appearance.isAccessabilitySupportEnabled {
        didSet { updateFonts() }
    }

    public var scheme = ChatBubbleStatusViewScheme() {
        didSet { updateScheme() }
    }

    private var image: UIImage? {
        switch chatStatus {
        case .loading:
            return Asset.System.Outline.timeOutline.image
        case .error:
            return Asset.Service.Outline.errorOutline.image
        case .sent:
            return Asset.Custom.Chat.sent.image
        case .receive:
            return Asset.Custom.Chat.sent.image
        case .read:
            return Asset.Custom.Chat.read.image
        case nil:
            return nil
        default:
            return nil
        }
    }

    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalSpacing
        stackView.axis = .horizontal
        stackView.spacing = Constants.stackViewSpacing
        return stackView
    }()

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    // MARK: - Private properties

    private let timeLabel = UILabel()
    private var centerTimeXConstraint = NSLayoutConstraint()
    private var timeLeadingConstraint = NSLayoutConstraint()
    private var imageTrailingConstraint = NSLayoutConstraint()
    private var widthConstraint = NSLayoutConstraint()
    private let overView = UIView()

    // MARK: - Initializer

    convenience public init() {
        self.init(frame: CGRect())
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    // MARK: - AppTheamable

    public func apply(theme: AppTheme) {
        self.scheme = ChatBubbleStatusViewScheme(theme: theme)
    }

    // MARK: - Private methods

    private func commonInit() {
        addSubviews()
        setupConstraints()
    }

    private func updateScheme() {
        updateFonts()
        updateColors()
        updateLayout()
    }

    private func addSubviews() {
        [overView].addToSuperview(self)
        [timeLabel, imageView].addToSuperview(overView)
    }

    private func setupConstraints() {
        timeLeadingConstraint = timeLabel.leadingAnchor.constraint(equalTo: overView.leadingAnchor)
        imageTrailingConstraint = imageView.trailingAnchor.constraint(equalTo: overView.trailingAnchor)
        widthConstraint = overView.widthAnchor.constraint(equalToConstant: Constants.width)

        NSLayoutConstraint.activate([
            overView.leadingAnchor.constraint(equalTo: leadingAnchor),
            overView.trailingAnchor.constraint(equalTo: trailingAnchor),
            overView.topAnchor.constraint(equalTo: topAnchor),
            overView.bottomAnchor.constraint(equalTo: bottomAnchor),
            overView.heightAnchor.constraint(equalToConstant: LayoutGrid.doubleModule),
            widthConstraint,
            timeLabel.centerYAnchor.constraint(equalTo: overView.centerYAnchor),
            imageView.centerYAnchor.constraint(equalTo: overView.centerYAnchor),

            timeLeadingConstraint,
            imageTrailingConstraint,

            imageView.widthAnchor.constraint(equalToConstant: LayoutGrid.doubleModule),
            imageView.heightAnchor.constraint(equalToConstant: LayoutGrid.doubleModule)
        ])
    }

    private func updateFonts() {
        timeLabel.setDynamicFont(
            font: scheme.textFont.uiFont,
            textStyle: scheme.textFont.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory
        )
    }

    private func updateColors() {
        let status = chatStatus ?? .none
        let direction = chatDirection ?? .right
        timeLabel.textColor = scheme.textColor.parameter(for: status, direction: direction, style: style)?.uiColor
        imageView.tintColor = scheme.imageColor.parameter(for: status, direction: direction, style: style)?.uiColor
    }


    private func updateLayout() {
        guard let chatStatus = chatStatus,
              chatStatus != .none
        else {
            imageView.isHidden = true
            widthConstraint.constant = Constants.minWidth
            imageTrailingConstraint.isActive = false
            return
        }

        imageView.isHidden = false
        imageView.image = image

        widthConstraint.constant = Constants.width
        imageTrailingConstraint.isActive = true
    }

}
