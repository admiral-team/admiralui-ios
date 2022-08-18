//
//  ChatMessageCell.swift
//  ExampleiOS
//
//  Created on 02.12.2021.
//

import AdmiralUIKit
import AdmiralTheme
import UIKit

struct ChatMessageCellViewModel: TableViewListItem {

    var didSelect: (() -> Void)?
    var message: String
    var time: String
    var name: String?
    var image: UIImage?
    var header: String?
    var direction: ChatDirection
    var chatStatus: ChatStatus?
    var state: ChatBubbleState

    var reuseIdentifier: String {
        String(describing: ChatMessageCell.self)
    }

    init(
        message: String,
        time: String,
        image: UIImage? = nil,
        didSelect: (() -> Void)? = nil,
        header: String? = nil,
        direction: ChatDirection = .right,
        chatStatus: ChatStatus? = nil,
        name: String? = nil,
        state: ChatBubbleState = .default
    ) {
        self.message = message
        self.time = time
        self.header = header
        self.image = image
        self.didSelect = didSelect
        self.direction = direction
        self.chatStatus = chatStatus
        self.name = name
        self.state = state
    }

}

final class ChatMessageCell: UITableViewCell, AnyAppThemable {

    // MARK: - Private Properties

    private let testChatBubble = ChatBubbleView()
    private var leadingAnchorConstraint = NSLayoutConstraint()
    private var trailingAnchorConstraint = NSLayoutConstraint()

    private var scheme = ChatMessageCellScheme() {
        didSet { updateScheme() }
    }

    // MARK: - AnyAppThemable

    func apply(theme: AppTheme) {
        scheme = ChatMessageCellScheme(theme: theme)
        testChatBubble.apply(theme: theme)
    }

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        setDefaultHighlighted(highlighted, animated: animated)
    }

    // MARK: - Private Methods

    private func commonInit() {
        autoManage()
        addSubviews()
        addConstraints()
        setSelectionStyle()
    }

    private func addSubviews() {
        [testChatBubble].forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        })
    }

    private func addConstraints() {
        leadingAnchorConstraint = testChatBubble.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LayoutGrid.doubleModule)
        trailingAnchorConstraint = contentView.trailingAnchor.constraint(equalTo: testChatBubble.trailingAnchor, constant: LayoutGrid.doubleModule)
        NSLayoutConstraint.activate([
            leadingAnchorConstraint,
            trailingAnchorConstraint,
            contentView.topAnchor.constraint(equalTo: testChatBubble.topAnchor, constant: LayoutGrid.halfModule),
            testChatBubble.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: LayoutGrid.halfModule)
        ])
    }

    private func setSelectionStyle() {
        selectionStyle = .none
    }

    private func updateScheme() {
        updateSchemeColors()
    }

    private func updateSchemeColors() {
        contentView.backgroundColor = scheme.backgroundColor.uiColor
    }

}

// MARK: - TableViewListItemConfigurable

extension ChatMessageCell: TableViewListItemConfigurable {

    func configure(for item: TableViewListItem) {
        guard let item = item as? ChatMessageCellViewModel else { return }
        testChatBubble.chatStatus = item.chatStatus
        testChatBubble.chatDirection = item.direction
        testChatBubble.messageText = item.message
        testChatBubble.timeTitle = item.time
        testChatBubble.name = item.name
        testChatBubble.state = item.state
        switch item.direction {
        case .left:
            trailingAnchorConstraint.isActive = false
            leadingAnchorConstraint.isActive = true
        default:
            leadingAnchorConstraint.isActive = false
            trailingAnchorConstraint.isActive = true
        }
    }

}
