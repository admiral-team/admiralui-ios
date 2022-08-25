//
//  UploadingFileCell.swift
//  ExampleiOS
//
//  Created on 29.12.2021.
//

import AdmiralUIKit
import AdmiralTheme
import UIKit

struct UploadingFileCellItem: TableViewListItem {

    var didSelect: (() -> Void)?
    var state: UploadDocumentState
    var direction: ChatDirection
    var fileName: String
    var fileSize: String
    var chatTime: String
    var chatStatus: ChatStatus?
    var progressCircleStyle: ProgressViewStyle
    let trackProgressStyle: ProgressViewStyle

    var reuseIdentifier: String {
        String(describing: UploadingFileCell.self)
    }

    init(
        didSelect: (() -> Void)? = nil,
        state: UploadDocumentState,
        direction: ChatDirection,
        fileName: String,
        fileSize: String,
        chatTime: String,
        chatStatus: ChatStatus? = nil,
        progressCircleStyle: ProgressViewStyle,
        trackProgressStyle: ProgressViewStyle
    ) {
        self.didSelect = didSelect
        self.state = state
        self.direction = direction
        self.fileSize = fileSize
        self.fileName = fileName
        self.chatTime = chatTime
        self.chatStatus = chatStatus
        self.progressCircleStyle = progressCircleStyle
        self.trackProgressStyle = trackProgressStyle
    }

}

final class UploadingFileCell: UITableViewCell, AnyAppThemable, AccessibilitySupport {

    // MARK: - Constants

    private enum Constants {
        static let width: CGFloat = 234
    }

    // MARK: - Private Properties

    private let uploadDocumentView = UploadDocumentView()
    private var leadingAnchorConstraint = NSLayoutConstraint()
    private var trailingAnchorConstraint = NSLayoutConstraint()

    private var scheme = UploadingFileCellScheme() {
        didSet { updateScheme() }
    }

    // MARK: - AccessibilitySupport

    var adjustsFontForContentSizeCategory: Bool = Appearance.shared.isAccessabilitySupportEnabled {
        didSet { updateSchemeFonts() }
    }

    // MARK: - AnyAppThemable

    func apply(theme: AppTheme) {
        scheme = UploadingFileCellScheme(theme: theme)
        uploadDocumentView.apply(theme: theme)
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
        [uploadDocumentView].addToSuperview(contentView)
    }

    private func addConstraints() {
        leadingAnchorConstraint = uploadDocumentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LayoutGrid.doubleModule)
        trailingAnchorConstraint = contentView.trailingAnchor.constraint(equalTo: uploadDocumentView.trailingAnchor, constant: LayoutGrid.doubleModule)
        NSLayoutConstraint.activate([
            leadingAnchorConstraint,
            trailingAnchorConstraint,
            uploadDocumentView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: LayoutGrid.doubleModule),
            contentView.bottomAnchor.constraint(equalTo: uploadDocumentView.bottomAnchor, constant: LayoutGrid.module)
        ])
    }

    private func setSelectionStyle() {
        selectionStyle = .none
    }

    private func updateScheme() {
        updateSchemeColors()
    }

    private func updateSchemeFonts() {}

    private func updateSchemeColors() {
        contentView.backgroundColor = scheme.backgroundColor.uiColor
    }

}

// MARK: - TableViewListItemConfigurable

extension UploadingFileCell: TableViewListItemConfigurable {

    func configure(for item: TableViewListItem) {
        guard let item = item as? UploadingFileCellItem else { return }
        uploadDocumentView.fileName = item.fileName
        uploadDocumentView.fileSize = item.fileSize
        uploadDocumentView.chatTime = item.chatTime
        uploadDocumentView.state = item.state
        uploadDocumentView.progressCircleStyle = item.progressCircleStyle
        uploadDocumentView.trackProgressStyle = item.trackProgressStyle
        uploadDocumentView.direction = item.direction
        uploadDocumentView.chatStatus = item.chatStatus
        leadingAnchorConstraint.isActive = item.direction == .left
        trailingAnchorConstraint.isActive = item.direction == .right
    }

}
