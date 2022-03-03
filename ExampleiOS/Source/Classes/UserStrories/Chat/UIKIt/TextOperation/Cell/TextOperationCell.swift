//
//  TextOperationCell.swift
//  ExampleiOS
//
//  Created on 14.12.2021.
//

import AdmiralUIKit
import AdmiralTheme
import UIKit

struct TextOperationCellViewModel: TableViewListItem {

    var didSelect: (() -> Void)?
    let title: String
    let description: String
    let time: String
    let direction: ChatDirection
    let chatStatus: ChatStatus
    let style: TextOperationViewStyle
    let titleLabelText: String
    let chatBubbleTime: String

    var reuseIdentifier: String {
        String(describing: TextOperationCell.self)
    }

    init(
        title: String,
        description: String,
        time: String,
        didSelect: (() -> Void)? = nil,
        direction: ChatDirection = .right,
        chatStatus: ChatStatus = .none,
        style: TextOperationViewStyle,
        titleLabelText: String,
        chatBubbleTime: String
    ) {
        self.title = title
        self.description = description
        self.time = time
        self.didSelect = didSelect
        self.direction = direction
        self.chatStatus = chatStatus
        self.style = style
        self.titleLabelText = titleLabelText
        self.chatBubbleTime = chatBubbleTime
    }

}

final class TextOperationCell: UITableViewCell, AnyAppThemable, AccessibilitySupport {

    // MARK: - Private Properties

    private let textOperationView = TextOperationView()
    private let titleLabel = UILabel()

    private var scheme = TextOperationScheme() {
        didSet { updateScheme() }
    }

    // MARK: - AccessibilitySupport

    var adjustsFontForContentSizeCategory: Bool = Appearance.isAccessabilitySupportEnabled {
        didSet { updateSchemeFonts() }
    }

    // MARK: - AnyAppThemable

    func apply(theme: AppTheme) {
        scheme = TextOperationScheme(theme: theme)
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
        [titleLabel, textOperationView].forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        })

    }

    private func addConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: LayoutGrid.doubleModule),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LayoutGrid.doubleModule),

            textOperationView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: LayoutGrid.doubleModule),
            textOperationView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LayoutGrid.doubleModule),
            textOperationView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            contentView.widthAnchor.constraint(equalTo: textOperationView.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: LayoutGrid.module * 20)
        ])
    }

    private func setSelectionStyle() {
        selectionStyle = .none
    }

    private func updateScheme() {
        updateSchemeFonts()
        updateSchemeColors()
    }

    private func updateSchemeFonts() {
        titleLabel.setDynamicFont(
            font: scheme.titleFont.uiFont,
            textStyle: scheme.titleFont.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory)
    }

    private func updateSchemeColors() {
        backgroundColor = scheme.backgroundColor.uiColor
        titleLabel.textColor = scheme.textColor.uiColor
    }

}

// MARK: - TableViewListItemConfigurable

extension TextOperationCell: TableViewListItemConfigurable {

    func configure(for item: TableViewListItem) {
        guard let item = item as? TextOperationCellViewModel else { return }
        textOperationView.chatDirection = item.direction
        textOperationView.chatStatus = item.chatStatus
        textOperationView.style = item.style
        textOperationView.timeName = item.time
        textOperationView.titleName = item.title
        textOperationView.discriptionName = item.description
        textOperationView.chatBubbleTime = item.chatBubbleTime
        titleLabel.text = item.titleLabelText
    }

}
