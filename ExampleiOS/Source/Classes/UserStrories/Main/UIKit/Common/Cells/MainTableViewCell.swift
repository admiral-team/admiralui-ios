//
//  MainTableViewCell.swift
//  ExampleiOS
//
//  Created on 09.11.2020.
//

import AdmiralUIKit
import AdmiralTheme
import UIKit

// MARK: - ViewModel

struct MainTableViewCellViewModel: TableViewListItem {
    let title: String
    let subtitle: String?
    let image: UIImage?
    
    var reuseIdentifier: String {
        String(describing: MainTableViewCell.self)
    }
    
    var didSelect: (() -> Void)?
    
    init(
        title: String,
        subtitle: String?,
        image: UIImage?,
        didSelect: (() -> Void)? = nil
    ) {
        self.title = title
        self.subtitle = subtitle
        self.image = image
        self.didSelect = didSelect
    }
}

struct MainSectionViewModel: TableViewListItemSection {
    var items: [TableViewListItem]
    var header: TableViewListItem?
    var footer: TableViewListItem?
    
    init(
        items: [TableViewListItem],
        header: TableViewListItem? = nil,
        footer: TableViewListItem? = nil
    ) {
        self.items = items
        self.header = header
        self.footer = footer
    }
}

final class MainTableViewCell: UITableViewCell, AnyAppThemable, AccessibilitySupport {
    
    // MARK: - AccessibilitySupport
    
    public var adjustsFontForContentSizeCategory: Bool = Appearance.isAccessabilitySupportEnabled {
        didSet { updateSchemeFonts() }
    }
    
    // MARK: - Private Properties
    
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let imageContainerView = UIView()
    private let itemImageView = UIImageView()
    private let disclosureImageView = UIImageView()
    
    private enum Constants {
        static let topInset: CGFloat = LayoutGrid.halfModule * 3
        static let bottomInset: CGFloat = LayoutGrid.halfModule * 3
        static let imageContainerViewWidth: CGFloat = LayoutGrid.halfModule * 11
        static let imageContainerViewHeight: CGFloat = LayoutGrid.halfModule * 11
        static let itemImageViewCornerRadius: CGFloat = (LayoutGrid.halfModule * 11) / 2
        
        static let titleLabelHeight: CGFloat = LayoutGrid.halfModule * 5
        static let subtitleLabelHeight: CGFloat = LayoutGrid.halfModule * 5
        
        static let imageWidth: CGFloat = LayoutGrid.halfModule * 6
        static let imageHeight: CGFloat = LayoutGrid.halfModule * 6
    }
    
    private var scheme = MainTableViewCellCustomScheme() {
        didSet { updateScheme() }
    }
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - AnyAppThemable
    
    func apply(theme: AppTheme) {
        scheme = MainTableViewCellCustomScheme(theme: theme)
    }
    
    // MARK: - Private Methods
    
    private func commonInit() {
        autoManage()
        
        addSubviews()
        setupViews()
        setupLabels()
        addConstraints()
        setupImageViews()
        setSelectionStyle()
    }
    
    private func addSubviews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(imageContainerView)
        contentView.addSubview(disclosureImageView)
        
        imageContainerView.addSubview(itemImageView)
    }
    
    private func setupViews() {
        imageContainerView.clipsToBounds = true
        imageContainerView.layer.cornerRadius = Constants.itemImageViewCornerRadius
        imageContainerView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupLabels() {
        titleLabel.numberOfLines = 1
        titleLabel.textAlignment = .left
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        subtitleLabel.numberOfLines = 1
        subtitleLabel.textAlignment = .left
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupImageViews() {
        disclosureImageView.image = UIImage(named: "disclosure")
        disclosureImageView.translatesAutoresizingMaskIntoConstraints = false
    
        itemImageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            imageContainerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.topInset),
            imageContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LayoutGrid.doubleModule),
            imageContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.bottomInset),
            imageContainerView.heightAnchor.constraint(equalToConstant: Constants.imageContainerViewHeight),
            imageContainerView.widthAnchor.constraint(equalToConstant: Constants.imageContainerViewWidth),
            
            itemImageView.centerYAnchor.constraint(equalTo: imageContainerView.centerYAnchor),
            itemImageView.centerXAnchor.constraint(equalTo: imageContainerView.centerXAnchor),
            itemImageView.heightAnchor.constraint(equalToConstant: Constants.imageHeight),
            itemImageView.widthAnchor.constraint(equalToConstant: Constants.imageWidth),
            
            disclosureImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            disclosureImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -LayoutGrid.doubleModule),
            disclosureImageView.heightAnchor.constraint(equalToConstant: Constants.imageHeight),
            disclosureImageView.widthAnchor.constraint(equalToConstant: Constants.imageWidth),
            
            titleLabel.leadingAnchor.constraint(equalTo: imageContainerView.trailingAnchor, constant: LayoutGrid.doubleModule),
            titleLabel.topAnchor.constraint(equalTo: imageContainerView.topAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: disclosureImageView.leadingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: Constants.titleLabelHeight),

            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: LayoutGrid.halfModule),
            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: disclosureImageView.leadingAnchor),
            subtitleLabel.heightAnchor.constraint(equalToConstant: Constants.subtitleLabelHeight)
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
            font: scheme.titleLabelFont.uiFont,
            textStyle: scheme.titleLabelFont.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory)
        subtitleLabel.setDynamicFont(
            font: scheme.subtitleLabelFont.uiFont,
            textStyle: scheme.subtitleLabelFont.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory)
    }
    
    private func updateSchemeColors() {
        contentView.backgroundColor = scheme.backgroundColor.uiColor
        titleLabel.textColor = scheme.titleLabelTextColor.uiColor
        subtitleLabel.textColor = scheme.subtitleLabelTextColor.uiColor
        imageContainerView.backgroundColor = scheme.imageViewContrainerViewTintColor.uiColor
        itemImageView.tintColor = scheme.imageViewTintColor.uiColor
    }
    
}

// MARK: - TableViewListItemConfigurable

extension MainTableViewCell: TableViewListItemConfigurable {
    
    func configure(for item: TableViewListItem) {
        guard let item = item as? MainTableViewCellViewModel else { return }
        
        titleLabel.text = item.title
        subtitleLabel.text = item.subtitle
        itemImageView.image = item.image
    }
    
}
