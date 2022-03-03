//
//  UploadingImageCell.swift
//  ExampleiOS
//
//  Created on 29.12.2021.
//

import AdmiralUIKit
import AdmiralTheme
import UIKit

struct UploadingGridItem: TableViewListItem {

    var didSelect: (() -> Void)?
    var models: [UploadImageItem]
    var chatTime: String?
    var chatStatus: ChatStatus?
    var chatDirection: ChatDirection
    var titleLabelText: String
    var state: UploadImageGridState

    var reuseIdentifier: String {
        String(describing: UploadingImageCell.self)
    }

    init(
        didSelect: (() -> Void)? = nil,
        models: [UploadImageItem],
        titleLabelText: String,
        chatTime: String? = nil,
        chatStatus: ChatStatus? = nil,
        chatDirection: ChatDirection,
        state: UploadImageGridState = .default
    ) {
        self.didSelect = didSelect
        self.models = models
        self.chatTime = chatTime
        self.chatStatus = chatStatus
        self.chatDirection = chatDirection
        self.titleLabelText = titleLabelText
        self.state = state
    }

}

final class UploadingImageCell: UITableViewCell, AnyAppThemable, AccessibilitySupport {

    // MARK: - Constants

    private enum Constants {
        static let width: CGFloat = 234
    }

    // MARK: - Private Properties

    private let uploadImageGridView = UploadImageGridView()
    private let titleLabel = UILabel()
    private var leadingConstraint = NSLayoutConstraint()
    private var trailingConstraint = NSLayoutConstraint()

    private var scheme = UploadingImageCellScheme() {
        didSet { updateScheme() }
    }

    // MARK: - AccessibilitySupport

    var adjustsFontForContentSizeCategory: Bool = Appearance.isAccessabilitySupportEnabled {
        didSet { updateSchemeFonts() }
    }

    // MARK: - AnyAppThemable

    func apply(theme: AppTheme) {
        scheme = UploadingImageCellScheme(theme: theme)
        uploadImageGridView.apply(theme: theme)
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

    override func prepareForReuse() {
        super.prepareForReuse()
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
        [titleLabel, uploadImageGridView].addToSuperview(contentView)
    }

    private func addConstraints() {
        leadingConstraint = uploadImageGridView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LayoutGrid.doubleModule)
        trailingConstraint = contentView.trailingAnchor.constraint(equalTo: uploadImageGridView.trailingAnchor, constant: LayoutGrid.doubleModule)

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LayoutGrid.doubleModule),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: LayoutGrid.doubleModule),

            uploadImageGridView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: LayoutGrid.doubleModule),
            contentView.bottomAnchor.constraint(equalTo: uploadImageGridView.bottomAnchor, constant: LayoutGrid.doubleModule),
            leadingConstraint,
            trailingConstraint
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
            adjustsFontForContentSize: adjustsFontForContentSizeCategory
        )
    }

    private func updateSchemeColors() {
        contentView.backgroundColor = scheme.backgroundColor.uiColor
        titleLabel.textColor = scheme.textColor.uiColor
    }

}

// MARK: - TableViewListItemConfigurable

extension UploadingImageCell: TableViewListItemConfigurable {

    func configure(for item: TableViewListItem) {
        guard let item = item as? UploadingGridItem else { return }

        uploadImageGridView.models = item.models
        uploadImageGridView.direction = item.chatDirection
        uploadImageGridView.chatStatus = item.chatStatus
        uploadImageGridView.chatTime = item.chatTime
        uploadImageGridView.state = item.state
        titleLabel.text = item.titleLabelText

        leadingConstraint.isActive = item.chatDirection == .left
        trailingConstraint.isActive = item.chatDirection == .right
    }

}
