//
//  FontCell.swift
//  Example iOS
//
//  Created on 13.10.2020.
//

import AdmiralUIKit
import AdmiralTheme
import UIKit

struct FontViewModel: TableViewListItem {
    
    let title: String
    let font: AFont
    let didSelect: (() -> Void)?
    
    var reuseIdentifier: String {
        String(describing: FontCell.self)
    }
    
    init(
        title: String,
        font: AFont,
        didSelect: (() -> Void)? = nil
    ) {
        self.title = title
        self.font = font
        self.didSelect = didSelect
    }
}


final class FontCell: UITableViewCell, TableViewListItemConfigurable, AnyAppThemable, AccessibilitySupport {
    
    // MARK: - Public Properties
    
    var title: String? {
        get { titleLabel.text }
        set { titleLabel.text = newValue }
    }
    
    // MARK: - AccessibilitySupport
    
    var adjustsFontForContentSizeCategory: Bool = Appearance.isAccessabilitySupportEnabled
    
    // MARK: - Private Properties
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        
        return label
    }()
    
    // MARK: - Public Methods
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
        commonInit()
    }
    
    // MARK: - AnyAppThemable
    
    func apply(theme: AppTheme) {
        titleLabel.textColor = theme.colors.textPrimary.uiColor
        contentView.backgroundColor = theme.colors.backgroundBasic.uiColor
    }

    // MARK: - Private Methods
    
    private func commonInit() {
        autoManage()
        
        addSubViews()
        configureLayout()
    }
    
    private func addSubViews() {
        contentView.addSubview(titleLabel)
    }
    
    private func configureLayout() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        configureTitleLabelLayout()
    }
    
    private func configureTitleLabelLayout() {
        let top = titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: LayoutGrid.module)
        let leading = titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LayoutGrid.doubleModule)
        let trailing = titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -LayoutGrid.doubleModule)
        let bottom = titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -LayoutGrid.module * 2)
        NSLayoutConstraint.activate([top, leading, trailing, bottom])
    }
    
    // MARK: - TableViewListItemConfigurable
    
    func configure(for item: TableViewListItem) {
        guard let item = item as? FontViewModel else { return }

        title = item.title
        titleLabel.setDynamicFont(
            font: item.font.uiFont,
            textStyle: item.font.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory)
    }

}
