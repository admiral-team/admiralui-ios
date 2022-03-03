//
//  MainTitleTableViewCell.swift
//  ExampleiOS
//
//  Created on 10.11.2020.
//

import AdmiralUIKit
import AdmiralTheme
import UIKit

// MARK: - ViewModel

struct MainTitleTableViewCellViewModel: TableViewListItem {
    let title: String
    let subtitle: String?

    var reuseIdentifier: String {
        String(describing: MainTitleTableViewCell.self)
    }
    
    var didSelect: (() -> Void)?
    
    init(
        title: String,
        subtitle: String? = "",
        didSelect: (() -> Void)? = nil
    ) {
        self.title = title
        self.didSelect = didSelect
        self.subtitle = subtitle
    }
}

final class MainTitleTableViewCell: UITableViewCell, AnyAppThemable, AccessibilitySupport {
    
    // MARK: - AccessibilitySupport
    
    public var adjustsFontForContentSizeCategory: Bool = Appearance.isAccessabilitySupportEnabled {
        didSet { updateSchemeFonts() }
    }
    
    // MARK: - Private Properties
    
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let disclosureImageView = UIImageView()
    
    private enum Constants {
        static let titleLabelHeight: CGFloat = LayoutGrid.halfModule * 5
        static let imageWidth: CGFloat = LayoutGrid.halfModule * 6
        static let imageHeight: CGFloat = LayoutGrid.halfModule * 6
    }
    private var scheme = MainTitleTableViewCellCustomScheme() {
        didSet { updateScheme() }
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
        
    // MARK: - AnyAppThemable
    
    func apply(theme: AppTheme) {
        scheme = MainTitleTableViewCellCustomScheme(theme: theme)
    }
    
    // MARK: - Private Methods
    
    private func commonInit() {
        autoManage()
        
        addSubviews()
        setupLabels()
        addConstraints()
        setupImageViews()
        setSelectionStyle()
    }

    private func addSubviews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(disclosureImageView)
        contentView.addSubview(subtitleLabel)
    }
    
    private func setupLabels() {
        titleLabel.numberOfLines = 1
        titleLabel.textAlignment = .left
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        subtitleLabel.numberOfLines = 1
        subtitleLabel.textAlignment = .right
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
    
    private func setupImageViews() {
        disclosureImageView.image = UIImage(named: "disclosure")
        disclosureImageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            disclosureImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            contentView.trailingAnchor.constraint(equalTo: disclosureImageView.trailingAnchor, constant: LayoutGrid.doubleModule),
            disclosureImageView.heightAnchor.constraint(equalToConstant: Constants.imageHeight),
            disclosureImageView.widthAnchor.constraint(equalToConstant: Constants.imageWidth),
            
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LayoutGrid.doubleModule),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: LayoutGrid.module),
            disclosureImageView.leadingAnchor.constraint(equalTo: subtitleLabel.trailingAnchor, constant: LayoutGrid.doubleModule),
            subtitleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
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
            font: scheme.titleLabelFont.uiFont,
            textStyle: scheme.subtitleLabelFont.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory)
    }
    
    private func updateSchemeColors() {
        subtitleLabel.textColor = scheme.subtitleLabelTextColor.uiColor
        titleLabel.textColor = scheme.titleLabelTextColor.uiColor
        contentView.backgroundColor = scheme.backgroundColor.uiColor
    }
    
}

// MARK: - TableViewListItemConfigurable

extension MainTitleTableViewCell: TableViewListItemConfigurable {
    
    func configure(for item: TableViewListItem) {
        guard let item = item as? MainTitleTableViewCellViewModel else { return }
        titleLabel.text = item.title
        subtitleLabel.text = item.subtitle
    }
    
}
