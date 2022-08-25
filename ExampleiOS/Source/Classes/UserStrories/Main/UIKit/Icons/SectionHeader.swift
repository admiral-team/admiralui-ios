//
//  SectionHeader.swift
//  Example iOS
//
//  Created on 13.10.2020.
//

import AdmiralUIKit
import AdmiralTheme
import UIKit

struct SectionHeaderViewModel {
    let title: String
}

final class SectionHeader: UICollectionReusableView, AnyAppThemable, AccessibilitySupport {
    
    // MARK: - AccessibilitySupport
    
    var adjustsFontForContentSizeCategory: Bool = Appearance.shared.isAccessabilitySupportEnabled {
        didSet { updateSchemeFonts() }
    }

    // MARK: - Private Properties
    
    private var titleLabel = UILabel()
    private var scheme = SectionHeaderCustomScheme() {
        didSet { updateScheme() }
    }
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - AnyAppThemable
    
    func apply(theme: AppTheme) {
        scheme = SectionHeaderCustomScheme(theme: theme)
    }
    
    // MARK: - Internal Methods
    
    func configure(viewModel: SectionHeaderViewModel) {
        titleLabel.text = viewModel.title
    }
    
    // MARK: - Private Methods
    
    private func commonInit() {
        autoManage()
        
        addSubviews()
        configureConstraints()
    }
    
    private func addSubviews() {
        [titleLabel].forEach({
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        })
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: LayoutGrid.tripleModule),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutGrid.module),
            trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: LayoutGrid.module),
            bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: LayoutGrid.doubleModule)
        ])
    }
    
    private func updateScheme() {
        updateSchemeFonts()
        updateSchemeColors()
    }
    
    private func updateSchemeFonts() {
        titleLabel.setDynamicFont(
            font: scheme.titleLabelLabelFont.uiFont,
            textStyle: scheme.titleLabelLabelFont.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory)
    }
    
    private func updateSchemeColors() {
        titleLabel.textColor = scheme.titleLabelTextColor.uiColor
        backgroundColor = scheme.backgroundColor.uiColor
    }
    
}
