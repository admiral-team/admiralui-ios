//
//  InformerSegmentedView.swift
//  AdmiralUI
//
//  Created on 06.11.2020.
//

import UIKit
import AdmiralTheme

final class InformerSegmentedView: UIControl, AnyAppThemable, AccessibilitySupport {
    
    private enum Constants {
        static let animationDuration = Durations.Default.single
    }
    
    // MARK: - Internal Properties
    
    override var isSelected: Bool {
        didSet { updateScheme() }
    }
    
    override var isEnabled: Bool {
        didSet { updateScheme() }
    }
    
    override var isHighlighted: Bool {
        didSet { updateScheme() }
    }
    
    var title: String? {
        get { return titleLabel.text }
        set { titleLabel.text = newValue }
    }
    
    var subtitle: String? {
        get { return subtitleLabel.text }
        set { subtitleLabel.text = newValue }
    }
    
    var scheme = InformerSegmentedScheme() {
        didSet { updateScheme() }
    }
        
    // MARK: - AccessibilitySupport
    
    var adjustsFontForContentSizeCategory: Bool = Appearance.shared.isAccessabilitySupportEnabled {
        didSet { updateSchemeFonts() }
    }
    
    // MARK: - Private Properties
    
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()

    // MARK: - Internal Methods
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    // MARK: - AnyAppThemable
    
    func apply(theme: AppTheme) {
        scheme = InformerSegmentedScheme(theme: theme)
    }
    
    // MARK: - Private Methods
    
    private func commonInit() {
        [titleLabel,
         subtitleLabel].addToSuperview(self)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: LayoutGrid.doubleModule),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutGrid.module),
            trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: LayoutGrid.module),
            titleLabel.heightAnchor.constraint(equalToConstant: LayoutGrid.tripleModule),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            subtitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutGrid.module),
            trailingAnchor.constraint(equalTo: subtitleLabel.trailingAnchor, constant: LayoutGrid.module),
            bottomAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: LayoutGrid.doubleModule)
        ])
        
        configureUI()
    }
    
    private func configureUI() {
        backgroundColor = .clear
        titleLabel.textAlignment = .center
        subtitleLabel.textAlignment = .center
        
        layer.borderWidth = 2
        layer.cornerRadius = LayoutGrid.module
        
        updateScheme()
    }
    
    private func updateScheme() {
        updateSchemeFonts()
        updateSchemeColors()
    }
    
    private func updateSchemeFonts() {
        titleLabel.setDynamicFont(
            font: scheme.itemScheme.titleFont.uiFont,
            textStyle: scheme.itemScheme.titleFont.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory)
        
        subtitleLabel.setDynamicFont(
            font: scheme.itemScheme.subtitleFont.uiFont,
            textStyle: scheme.itemScheme.subtitleFont.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory)
    }
    
    private func updateSchemeColors() {
        titleLabel.textColor = scheme.itemScheme.titleColor.parameter(for: state)?.uiColor
        subtitleLabel.textColor = scheme.itemScheme.subtitleColor.parameter(for: state)?.uiColor
        layer.borderColor = scheme.itemScheme.borderColor.parameter(for: state)?.cgColor
    }
    
}
