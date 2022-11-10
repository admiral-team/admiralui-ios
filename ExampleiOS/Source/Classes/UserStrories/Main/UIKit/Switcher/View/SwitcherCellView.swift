//
//  SwitcherCellView.swift
//  ExampleiOS
//
//  Created on 20.10.2020.
//

import AdmiralUIKit
import AdmiralTheme
import UIKit

final class SwitcherCellView: UIView, AnyAppThemable, AccessibilitySupport {

    // MARK: - Public Properties
    
    var isEnabled: Bool = true {
        didSet {
            switchControl.isEnabled = isEnabled
        }
    }
    
    // MARK: - AccessibilitySupport
    
    var adjustsFontForContentSizeCategory: Bool = Appearance.isAccessabilitySupportEnabled {
        didSet { updateSchemeFonts() }
    }
    
    // MARK: - Private Properties
    
    private let titleLabel = UILabel()
    private let switchControl = CustomSwitch()
    private var scheme = SwitcherCellViewCustomScheme() {
        didSet { updateScheme() }
    }
    
    // MARK: - Initializer

    init(isOn: Bool, title: String, accesibilityId: String) {
        super.init(frame: .zero)
        switchControl.isOn = isOn
        switchControl.accessibilityIdentifier = accesibilityId
        titleLabel.text = title
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - AnyAppThemable
    
    func apply(theme: AppTheme) {
        switchControl.apply(theme: theme)
        scheme = SwitcherCellViewCustomScheme(theme: theme)
    }
    
    // MARK: - Private Methods
    
    private func configureUI() {
        autoManage()
        
        addSubviews()
        configureLabel()
        setupConstraits()
        configureSwitches()
    }
    
    private func addSubviews() {
        [switchControl,
         titleLabel].forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
         })
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
            
            switchControl.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: LayoutGrid.doubleModule),
            switchControl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutGrid.doubleModule),
            switchControl.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -LayoutGrid.doubleModule)
        ])
    }

    private func configureSwitches() {
        switchControl.addTarget(self, action: #selector(changeSwitch(_:)), for: .valueChanged)
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
    
    @objc private func changeSwitch(_ switchView: UISwitch) {
        switchControl.isOn = switchView.isOn
    }

}
