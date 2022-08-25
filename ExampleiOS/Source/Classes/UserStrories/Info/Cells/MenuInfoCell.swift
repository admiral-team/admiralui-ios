//
//  MenuInfoCell.swift
//  ExampleiOS
//
//  Created on 09.03.2021.
//

import AdmiralUIKit
import AdmiralTheme
import UIKit

// MARK: - ViewModel

struct MenuInfoCellViewModel: TableViewListItem {
    let title: String
    let image: UIImage

    var reuseIdentifier: String {
        String(describing: MenuInfoCell.self)
    }
    
    var didSelect: (() -> Void)?
    
    init(
        title: String,
        image: UIImage,
        didSelect: (() -> Void)? = nil
    ) {
        self.title = title
        self.image = image
        self.didSelect = didSelect
    }
}

final class MenuInfoCell: UITableViewCell, AnyAppThemable, AccessibilitySupport {
    
    // MARK: - AccessibilitySupport
    
    var adjustsFontForContentSizeCategory: Bool = Appearance.shared.isAccessabilitySupportEnabled {
        didSet { updateSchemeFonts() }
    }
    
    // MARK: - Private Properties
    
    private let titleLabel = UILabel()
    private let iconImageView = UIImageView()
    private let disclosureImageView = UIImageView()
    private var scheme = MenuInfoCellCustomScheme() {
        didSet { updateScheme() }
    }
    
    private enum Constants {
        static let titleLabelHeight: CGFloat = LayoutGrid.halfModule * 5
        static let imageWidth: CGFloat = LayoutGrid.halfModule * 6
        static let imageHeight: CGFloat = LayoutGrid.halfModule * 6
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
        scheme = MenuInfoCellCustomScheme(theme: theme)
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
        [titleLabel,
         disclosureImageView,
         iconImageView].forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
         })
    }
    
    private func setupLabels() {
        titleLabel.numberOfLines = 1
        titleLabel.textAlignment = .left
    }
    
    private func setupImageViews() {
        disclosureImageView.image = Asset.disclosure.image
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LayoutGrid.doubleModule),
            iconImageView.heightAnchor.constraint(equalToConstant: LayoutGrid.tripleModule),
            iconImageView.widthAnchor.constraint(equalToConstant: LayoutGrid.tripleModule),
            iconImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            disclosureImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            contentView.trailingAnchor.constraint(equalTo: disclosureImageView.trailingAnchor, constant: LayoutGrid.doubleModule),
            disclosureImageView.heightAnchor.constraint(equalToConstant: Constants.imageHeight),
            disclosureImageView.widthAnchor.constraint(equalToConstant: Constants.imageWidth),
            
            titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: LayoutGrid.halfModule * 9),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: LayoutGrid.halfModule * 6),
            contentView.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: LayoutGrid.halfModule * 6),
            disclosureImageView.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: LayoutGrid.doubleModule)
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
        iconImageView.tintColor = scheme.imageTintColor.uiColor
    }
    
}

// MARK: - TableViewListItemConfigurable

extension MenuInfoCell: TableViewListItemConfigurable {
    
    func configure(for item: TableViewListItem) {
        guard let item = item as? MenuInfoCellViewModel else { return }
        
        titleLabel.text = item.title
        iconImageView.image = item.image
    }
    
}
