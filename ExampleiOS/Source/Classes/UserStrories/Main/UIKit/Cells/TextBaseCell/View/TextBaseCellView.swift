//
//  TextBaseCellView.swift
//  ExampleiOS
//
//  Created on 24.02.2021.
//

import AdmiralUIKit
import AdmiralTheme
import UIKit

final class TextBaseCellView: UIView, AnyAppThemable, AccessibilitySupport {

    // MARK: - Public Properties
    
    var isEnabled: Bool = true {
        didSet {
            cell.isEnabled = isEnabled
        }
    }
    
    // MARK: - AccessibilitySupport
    
    var adjustsFontForContentSizeCategory: Bool = Appearance.shared.isAccessabilitySupportEnabled {
        didSet { updateSchemeFonts() }
    }
    
    // MARK: - Private Properties
    
    private let titleLabel = UILabel()
    private var cell: ListViewCell
    private var scheme = TextBaseCellCustomScheme() {
        didSet { updateScheme() }
    }
    
    // MARK: - Initializer

    init(cell: ListViewCell, title: String) {
        self.cell = cell
        super.init(frame: .zero)
        titleLabel.text = title
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - AnyAppThemable
    
    func apply(theme: AppTheme) {
        scheme = TextBaseCellCustomScheme(theme: theme)
        cell.apply(theme: theme)
    }
    
    // MARK: - Private Methods
    
    private func configureUI() {
        autoManage()
        
        addSubviews()
        configureLabel()
        setupConstraits()
    }
    
    private func addSubviews() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        
        cell.translatesAutoresizingMaskIntoConstraints = false
        addSubview(cell)
    }
    
    private func configureLabel() {
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 1
    }
    
    private func setupConstraits() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutGrid.doubleModule),
            trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: LayoutGrid.doubleModule),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: LayoutGrid.halfModule * 7),
            
            cell.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: LayoutGrid.halfModule * 7),
            cell.leadingAnchor.constraint(equalTo: leadingAnchor),
            trailingAnchor.constraint(equalTo: cell.trailingAnchor),
            bottomAnchor.constraint(equalTo: cell.bottomAnchor, constant: LayoutGrid.halfModule * 7)
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
    }
    
    private func updateSchemeColors() {
        titleLabel.textColor = scheme.titleLabelTextColor.uiColor
        backgroundColor = scheme.backgroundColor.uiColor
    }

}
