//
//  ThemeSwitchComponentView.swift
//  ExampleiOS
//
//  Created on 23.03.2021.
//

import AdmiralUIKit
import AdmiralTheme
import UIKit

final class ThemeSwitchComponentView: UIControl, AnyAppThemable, AccessibilitySupport {
    
    // MARK: - Internal Properties
    
    override var isSelected: Bool {
        didSet { updateScheme() }
    }
    
    override var isHighlighted: Bool {
        didSet { updateScheme() }
    }
    
    var title: String? {
        didSet { titleLabel.text = title }
    }
    
    // MARK: - AccessibilitySupport
    
    public var adjustsFontForContentSizeCategory: Bool = Appearance.shared.isAccessabilitySupportEnabled {
        didSet { updateSchemeFonts() }
    }
    
    // MARK: - Private Properties
    
    private let titleLabel = UILabel()
    private var scheme = ThemeSwitchComponentViewCustomScheme() {
        didSet { updateScheme() }
    }
    private enum Constants {
        static let itemSize: CGFloat = LayoutGrid.halfModule * 9
    }
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override var intrinsicContentSize: CGSize {
        let titleLabelWidth = titleLabel.intrinsicContentSize.width
        let width = titleLabelWidth + 2 * LayoutGrid.module
        return CGSize(
            width: width,
            height: LayoutGrid.halfModule * 9)
    }
    
    // MARK: - AnyAppThemable
    
    func apply(theme: AppTheme) {
        scheme = ThemeSwitchComponentViewCustomScheme(theme: theme)
    }
    
    // MARK: - Private Methods

    private func commonInit() {
        autoManage()
        
        configureUI()
        addSubviews()
        configureLayout()
    }
    
    private func addSubviews() {
        [titleLabel].addToSuperview(self)
    }
    
    private func configureLayout() {
        NSLayoutConstraint.activate([
            widthAnchor.constraint(greaterThanOrEqualToConstant: Constants.itemSize),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            heightAnchor.constraint(equalToConstant: Constants.itemSize)
        ])
    }
    
    private func configureUI() {
        layer.cornerRadius = 18.0
        titleLabel.textAlignment = .center
    }
    
    private func updateScheme() {
        updateSchemeFonts()
        updateSchemeColors()
    }
    
    private func updateSchemeFonts() {
        titleLabel.setDynamicFont(
            font: scheme.font.uiFont,
            textStyle: scheme.font.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory)
    }
    
    private func updateSchemeColors() {
        backgroundColor = scheme.backgroundColor.parameter(for: state)?.uiColor
        titleLabel.textColor = scheme.textColor.parameter(for: state)?.uiColor
    }
    
}
