//
//  MenuTableViewHeaderView.swift
//  ExampleiOS
//
//  Created on 11.11.2020.
//

import AdmiralUIKit
import AdmiralTheme
import UIKit

struct MenuTableViewHeaderViewViewModel: TableViewListItem {
    
    let title: String
    let didSelect: (() -> Void)?
    
    var reuseIdentifier: String {
        String(describing: MenuTableViewHeaderView.self)
    }
    
    init(
        title: String,
        didSelect: (() -> Void)? = nil
    ) {
        self.title = title
        self.didSelect = didSelect
    }
}


final class MenuTableViewHeaderView: UITableViewHeaderFooterView, TableViewListItemConfigurable, AnyAppThemable, AccessibilitySupport {
    
    // MARK: - Public Properties
    
    var title: String? {
        get { return titleLabel.text }
        set { titleLabel.text = newValue }
    }
    
    // MARK: - AccessibilitySupport
    
    public var adjustsFontForContentSizeCategory: Bool = Appearance.isAccessabilitySupportEnabled {
        didSet { updateSchemeFonts() }
    }
    
    // MARK: - Private Properties
    
    private let titleLabel = UILabel()
    private var scheme = MenuTableViewHeaderViewCustomScheme() {
        didSet { updateScheme() }
    }
    
    // MARK: - Life Cycle
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    // MARK: - AnyAppThemable
    
    func apply(theme: AppTheme) {
        scheme = MenuTableViewHeaderViewCustomScheme(theme: theme)
    }

    // MARK: - Private Methods
    
    private func commonInit() {
        autoManage()
        
        addSubViews()
        configureLayout()
        configureTitleLabel()
    }
    
    private func addSubViews() {
        contentView.addSubview(titleLabel)
    }
    
    private func configureTitleLabel() {
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 1
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureLayout() {
        let top = titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: LayoutGrid.halfModule * 7)
        let bottom = contentView.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: LayoutGrid.halfModule)
        let leading = titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LayoutGrid.doubleModule)
        let trailing = contentView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: LayoutGrid.doubleModule)
        
        bottom.priority = .defaultHigh
        trailing.priority = .defaultHigh
        
        NSLayoutConstraint.activate([top, bottom, leading, trailing])
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
    }
    
    private func updateSchemeColors() {
        titleLabel.textColor = scheme.titleLabelTextColor.uiColor
    }
    
    // MARK: - TableViewListItemConfigurable
    
    func configure(for item: TableViewListItem) {
        guard let item = item as? MenuTableViewHeaderViewViewModel else { return }

        title = item.title
    }

}
