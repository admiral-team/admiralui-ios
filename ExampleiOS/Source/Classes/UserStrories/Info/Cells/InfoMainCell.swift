//
//  InfoMainCell.swift
//  ExampleiOS
//
//  Created on 09.03.2021.
//

import AdmiralUIKit
import AdmiralTheme
import UIKit

// MARK: - ViewModel

struct InfoMainCellViewModel: TableViewListItem {
    let title: String

    var reuseIdentifier: String {
        String(describing: InfoMainCell.self)
    }
    
    var didSelect: (() -> Void)?
    
    var accessibilityId: String
    
    init(
        title: String,
        didSelect: (() -> Void)? = nil,
        accessibilityId: String = ""
    ) {
        self.title = title
        self.didSelect = didSelect
        self.accessibilityId = accessibilityId
    }
}

final class InfoMainCell: UITableViewCell, AnyAppThemable, AccessibilitySupport {
    
    // MARK: - AccessibilitySupport
    
    var adjustsFontForContentSizeCategory: Bool = Appearance.isAccessabilitySupportEnabled {
        didSet { updateSchemeFonts() }
    }
    
    // MARK: - Private Properties
    
    private let titleLabel = UILabel()
    private let iconImageView = UIImageView()
    private var scheme = InfoMainCellCustomScheme() {
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
        scheme = InfoMainCellCustomScheme(theme: theme)
    }
    
    // MARK: - Private Methods
    
    private func commonInit() {
        autoManage()
        
        addSubviews()
        setupLabels()
        addConstraints()
        setSelectionStyle()
        setupImageViews() 
    }

    private func addSubviews() {
        [titleLabel,
         iconImageView].forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
         })
    }
    
    private func setupLabels() {
        titleLabel.numberOfLines = 1
        titleLabel.textAlignment = .center
    }
    
    private func setupImageViews() {
        iconImageView.image = Asset.Info.info.image
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: LayoutGrid.halfModule * 5),
            iconImageView.heightAnchor.constraint(equalToConstant: LayoutGrid.halfModule * 30),
            iconImageView.widthAnchor.constraint(equalToConstant: LayoutGrid.halfModule * 30),
            iconImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: LayoutGrid.halfModule * 4),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LayoutGrid.doubleModule),
            contentView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: LayoutGrid.doubleModule),
            contentView.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: LayoutGrid.halfModule * 13)
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
        titleLabel.textColor = scheme.textColor.uiColor
        contentView.backgroundColor = scheme.backgroundColor.uiColor
    }
    
}

// MARK: - TableViewListItemConfigurable

extension InfoMainCell: TableViewListItemConfigurable {
    
    func configure(for item: TableViewListItem) {
        guard let item = item as? InfoMainCellViewModel else { return }
        titleLabel.text = item.title
        self.accessibilityIdentifier = item.accessibilityId
    }
    
}
