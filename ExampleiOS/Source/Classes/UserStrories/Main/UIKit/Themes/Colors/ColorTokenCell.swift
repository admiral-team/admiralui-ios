//
//  ColorTokenPreviewCell.swift
//  ExampleiOS
//
//  Created on 17.02.2021.
//

import AdmiralUIKit
import AdmiralTheme
import AdmiralUIResources
import UIKit

struct ColorTokenListItem: TableViewListItem {
    var token: ColorToken
    var isEditEnabled: Bool
    var didSelect: (() -> Void)?
    
    var reuseIdentifier: String {
        String(describing: ColorTokenCell.self)
    }

    init(
        token: ColorToken,
        isEditEnabled: Bool,
        didSelect: (() -> Void)? = nil
    ) {
        self.token = token
        self.isEditEnabled = isEditEnabled
        self.didSelect = didSelect
    }
}

final class ColorTokenCell: UITableViewCell, AnyAppThemable, AccessibilitySupport {
        
    // MARK: - AccessibilitySupport
    
    var adjustsFontForContentSizeCategory: Bool = Appearance.shared.isAccessabilitySupportEnabled {
        didSet { updateSchemeFonts() }
    }

    
    // MARK: - Private Properties
    
    private let colorView = UIView()
    private let titleLabel = UILabel()
    private let hexLabel = UILabel()
    private let arrowImageView = UIImageView()
    private let labelsLayoutGuide = UILayoutGuide()
    private var scheme = ColorTokerCellCustomSheme() {
        didSet { updateScheme() }
    }
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
        commonInit()
    }
    
    // MARK: - LifeCycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        colorView.layer.cornerRadius = colorView.frame.width / 2
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        setDefaultHighlighted(highlighted, animated: animated)
    }
    
    // MARK: - AnyAppThemable
    
    func apply(theme: AppTheme) {
       scheme = ColorTokerCellCustomSheme(theme: theme)
    }
    
    // MARK: - Private Methods
    
    private func commonInit() {
        autoManage()
        
        addSubviews()
        setupViews()
        setupConstraints()
    }
    
    private func addSubviews() {
        [colorView,
         titleLabel,
         hexLabel,
         arrowImageView].addToSuperview(self)
        addLayoutGuide(labelsLayoutGuide)
    }
    
    private func setupViews() {
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 1
        
        hexLabel.textAlignment = .left
        hexLabel.numberOfLines = 1
        
        arrowImageView.image = AdmiralUIResources.Asset.System.Outline.chevronRightOutline.image
    }
    
    private func setupConstraints() {
        arrowImageView.setContentHuggingPriority(.required, for: .horizontal)

        NSLayoutConstraint.activate([
            colorView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: LayoutGrid.halfModule * 3),
            colorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LayoutGrid.doubleModule),
            colorView.heightAnchor.constraint(equalToConstant: LayoutGrid.halfModule * 11),
            colorView.widthAnchor.constraint(equalToConstant: LayoutGrid.halfModule * 11),
            bottomAnchor.constraint(greaterThanOrEqualTo: colorView.bottomAnchor, constant: LayoutGrid.halfModule * 3),

            labelsLayoutGuide.topAnchor.constraint(equalTo: colorView.topAnchor),
            labelsLayoutGuide.leadingAnchor.constraint(equalTo: colorView.trailingAnchor, constant: LayoutGrid.doubleModule),
            bottomAnchor.constraint(greaterThanOrEqualTo: labelsLayoutGuide.bottomAnchor, constant: LayoutGrid.halfModule * 3),
            
            trailingAnchor.constraint(equalTo: arrowImageView.trailingAnchor, constant: LayoutGrid.doubleModule),
            arrowImageView.leadingAnchor.constraint(equalTo: labelsLayoutGuide.trailingAnchor, constant: LayoutGrid.module),
            arrowImageView.centerYAnchor.constraint(equalTo: labelsLayoutGuide.centerYAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: labelsLayoutGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: labelsLayoutGuide.leadingAnchor),
            labelsLayoutGuide.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            hexLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: LayoutGrid.halfModule),
            labelsLayoutGuide.bottomAnchor.constraint(equalTo: hexLabel.bottomAnchor),
            hexLabel.leadingAnchor.constraint(equalTo: labelsLayoutGuide.leadingAnchor),
            labelsLayoutGuide.trailingAnchor.constraint(equalTo: hexLabel.trailingAnchor)
        ])
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
        hexLabel.setDynamicFont(
            font: scheme.hexLabelFont.uiFont,
            textStyle: scheme.hexLabelFont.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory)
    }
    
    private func updateSchemeColors() {
        titleLabel.textColor = scheme.titleLabelTextColor.uiColor
        hexLabel.textColor = scheme.hexLabelTextColor.uiColor
        contentView.backgroundColor = scheme.backgroundColor.uiColor
        arrowImageView.tintColor = scheme.arrowImageViewTintColor.uiColor
    }
    
}

// MARK: - TableViewListItemConfigurable

extension ColorTokenCell: TableViewListItemConfigurable {
    
    func configure(for item: TableViewListItem) {
        guard let item = item as? ColorTokenListItem else { return }
        titleLabel.text = item.token.name
        hexLabel.text = item.token.hex
        colorView.backgroundColor = item.token.color
        arrowImageView.isHidden = !item.isEditEnabled
    }
    
}
