//
//  ContactsTableViewCell.swift
//  ExampleiOS
//
//  Created on 09.03.2021.
//

import AdmiralUIKit
import AdmiralTheme
import UIKit

// MARK: - ViewModel

struct ContactsTableViewCellViewModel: TableViewListItem {
    let title: String
    let subtitle: String
    let additionaltitle: String

    var reuseIdentifier: String {
        String(describing: ContactsTableViewCell.self)
    }
    
    var didSelect: (() -> Void)?
    
    init(
        title: String,
        subtitle: String = "",
        additionaltitle: String = "",
        didSelect: (() -> Void)? = nil
    ) {
        self.title = title
        self.subtitle = subtitle
        self.additionaltitle = additionaltitle
        self.didSelect = didSelect
    }
}

final class ContactsTableViewCell: UITableViewCell, AnyAppThemable, AccessibilitySupport {
    
    // MARK: - AccessibilitySupport
    
    var adjustsFontForContentSizeCategory: Bool = Appearance.shared.isAccessabilitySupportEnabled {
        didSet { updateSchemeFonts() }
    }
    
    // MARK: - Private Properties
    
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let additionalLabel = UILabel()
    private lazy var subtitleLabelHeightConstraint: NSLayoutConstraint = {
        subtitleLabel.heightAnchor.constraint(equalToConstant: 0)
    }()
    private lazy var subtitleTopConstraint: NSLayoutConstraint = {
        subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: LayoutGrid.halfModule)
    }()
    private lazy var additionalLabelTopConstraint: NSLayoutConstraint = {
        additionalLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: LayoutGrid.halfModule * 3)
    }()
    private lazy var additionalLabelHeightConstraint: NSLayoutConstraint = {
        additionalLabel.heightAnchor.constraint(equalToConstant: 0)
    }()
    private var scheme = ContactsTableViewCustomTheme() {
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
        scheme = ContactsTableViewCustomTheme(theme: theme)
    }
    
    // MARK: - Private Methods
    
    private func commonInit() {
        autoManage()
        
        addSubviews()
        setupLabels()
        addConstraints()
        setSelectionStyle()
    }

    private func addSubviews() {
        [titleLabel,
         subtitleLabel,
         additionalLabel].forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
         })
    }
    
    private func setupLabels() {
        titleLabel.numberOfLines = 1
        titleLabel.textAlignment = .left
        
        subtitleLabel.numberOfLines = 0
        subtitleLabel.textAlignment = .left
        
        additionalLabel.numberOfLines = 1
        additionalLabel.textAlignment = .left
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: LayoutGrid.module * 3),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LayoutGrid.doubleModule),
            contentView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: LayoutGrid.doubleModule),
            
            subtitleTopConstraint,
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: LayoutGrid.halfModule),
            subtitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LayoutGrid.doubleModule),
            contentView.trailingAnchor.constraint(equalTo: subtitleLabel.trailingAnchor, constant: LayoutGrid.doubleModule),
            
            additionalLabelTopConstraint,
            additionalLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LayoutGrid.doubleModule),
            contentView.trailingAnchor.constraint(equalTo: additionalLabel.trailingAnchor, constant: LayoutGrid.doubleModule),
            additionalLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -LayoutGrid.halfModule)
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
        
        additionalLabel.setDynamicFont(
            font: scheme.additionalLabelFont.uiFont,
            textStyle: scheme.additionalLabelFont.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory)
    }
    
    private func updateSchemeColors() {
        titleLabel.textColor = scheme.titleLabelTextColor.uiColor
        subtitleLabel.textColor = scheme.subtitleLabelFontTextColor.uiColor
        additionalLabel.textColor = scheme.additionalLabelTextColor.uiColor
        backgroundColor = scheme.backgroundColor.uiColor
    }
    
}

// MARK: - TableViewListItemConfigurable

extension ContactsTableViewCell: TableViewListItemConfigurable {
    
    func configure(for item: TableViewListItem) {
        guard let item = item as? ContactsTableViewCellViewModel else { return }
        
        titleLabel.text = item.title
        subtitleLabel.text = item.subtitle
        additionalLabel.text = item.additionaltitle
        
        if item.subtitle.isEmpty {
            subtitleLabel.text = nil
            subtitleTopConstraint.constant = 0
        }
        
        if item.additionaltitle.isEmpty {
            additionalLabel.text = nil
            additionalLabelTopConstraint.constant = 0
        }
    }
    
}
