//
//  MenuListCell.swift
//  Example iOS
//
//  Created on 12.10.2020.
//

import AdmiralUIKit
import AdmiralTheme
import AdmiralUIResources
import UIKit

struct MenuListViewModel: TableViewListItem {
    
    let title: String?
    let subtitle: String?
    let tag: String?
    let isEnabled: Bool
    let didSelect: (() -> Void)?
    
    var reuseIdentifier: String {
        String(describing: MenuListCell.self)
    }
    
    init(
        title: String?,
        subtitle: String? = nil,
        tag: String? = nil,
        isEnabled: Bool = true,
        didSelect: (() -> Void)? = nil
    ) {
        self.title = title
        self.subtitle = subtitle
        self.tag = tag
        self.isEnabled = isEnabled
        self.didSelect = didSelect
    }
}

struct MenuListSectionViewModel: TableViewListItemSection {
    
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

final class MenuListCell: UITableViewCell, AnyAppThemable, TableViewListItemConfigurable, AccessibilitySupport {
    
    // MARK: - Public Properties
    
    var title: String? {
        get { titleLabel.text }
        set { titleLabel.text = newValue }
    }
    
    var subtitle: String? {
        get { subtitleLabel.text }
        set { subtitleLabel.text = newValue }
    }
    
    override var intrinsicContentSize: CGSize {
        CGSize(width: UIView.noIntrinsicMetric, height: 68)
    }
    
    // MARK: - AccessibilitySupport
    
    public var adjustsFontForContentSizeCategory: Bool = Appearance.isAccessabilitySupportEnabled {
        didSet { updateSchemeFonts() }
    }
    
    // MARK: - Private Properties
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        return label
    }()
        
    private let arrowImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private let containerTextLayoutGuide = UILayoutGuide()
    private var textVerticalSpacingConstraint: NSLayoutConstraint?
    private var imageHorizontalSpacingConstraint: NSLayoutConstraint?
    private var scheme = MenuListCellCustomScheme() {
        didSet { updateScheme() }
    }
    
    // MARK: - Public Methods
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
        commonInit()
    }
    
    public func apply(theme: AppTheme) {
        scheme = MenuListCellCustomScheme(theme: theme)
    }

    // MARK: - Private Methods
    
    private func commonInit() {
        autoManage()
        arrowImageView.image = AdmiralUIResources.Asset.System.Outline.chevronRightOutline.image
        configureConstraints()
    }
    
    private func configureConstraints() {
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(subtitleLabel)
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(arrowImageView)
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        
        addLayoutGuide(containerTextLayoutGuide)
        
        let imageHorizontalSpacing = containerTextLayoutGuide.trailingAnchor.constraint(equalTo: arrowImageView.leadingAnchor)
        let textVerticalSpacing = subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor)
        
        NSLayoutConstraint.activate([
            containerTextLayoutGuide.topAnchor.constraint(equalTo: topAnchor, constant: LayoutGrid.halfModule * 3),
            containerTextLayoutGuide.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutGrid.doubleModule),
            containerTextLayoutGuide.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            trailingAnchor.constraint(equalTo: arrowImageView.trailingAnchor, constant: LayoutGrid.doubleModule),
            arrowImageView.centerYAnchor.constraint(equalTo: containerTextLayoutGuide.centerYAnchor),
            
            imageHorizontalSpacing,
            titleLabel.topAnchor.constraint(equalTo: containerTextLayoutGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: containerTextLayoutGuide.leadingAnchor),
            containerTextLayoutGuide.trailingAnchor.constraint(greaterThanOrEqualTo: titleLabel.trailingAnchor),
            
            textVerticalSpacing,
            subtitleLabel.leadingAnchor.constraint(equalTo: containerTextLayoutGuide.leadingAnchor),
            containerTextLayoutGuide.trailingAnchor.constraint(greaterThanOrEqualTo: titleLabel.trailingAnchor),
            containerTextLayoutGuide.bottomAnchor.constraint(equalTo: subtitleLabel.bottomAnchor)
        ])
        
        updateLayoutConstraints()
    }
    
    private func updateLayoutConstraints() {
        textVerticalSpacingConstraint?.constant = (title != nil && subtitle != nil) ?  LayoutGrid.halfModule : 0
        imageHorizontalSpacingConstraint?.constant = (arrowImageView.image != nil) ? LayoutGrid.module : 0
    }
    
    private func updateScheme() {
        updateSchemeColors()
        updateSchemeFonts()
    }
    
    private func updateSchemeColors() {
        backgroundColor = scheme.backgroundColor.uiColor
        titleLabel.textColor = scheme.titleLabelTextColor.uiColor
        subtitleLabel.textColor = scheme.subtitleLabelTextColor.uiColor
        arrowImageView.tintColor = scheme.imageViewTintColor.uiColor
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
    
    // MARK: - TableViewListItemConfigurable
    
    func configure(for item: TableViewListItem) {
        guard let item = item as? MenuListViewModel else { return }
        title = item.title
        subtitle = item.subtitle
        arrowImageView.isHidden = !item.isEnabled
        updateLayoutConstraints()
    }

}
