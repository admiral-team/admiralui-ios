//
//  CheckBoxesCellView.swift
//  ExampleiOS
//
//  Created on 02.02.2021.
//

import AdmiralUIKit
import AdmiralTheme
import UIKit

final class CheckBoxesCellView: UIView, AnyAppThemable, AccessibilitySupport {
    
    // MARK: - Public Properties
    
    var isEnabled: Bool = true {
        didSet {
            checkBoxFirstControl.isEnabled = isEnabled
            checkBoxSecondControl.isEnabled = isEnabled
        }
    }
    
    // MARK: - AccessibilitySupport
    
    var adjustsFontForContentSizeCategory: Bool = Appearance.shared.isAccessabilitySupportEnabled {
        didSet { updateSchemeFonts() }
    }
    
    // MARK: - Private Properties
    
    private let titleLabel = UILabel()
    private let checkBoxFirstControl = CheckTextControl<CheckBox>(checkControl: CheckBox())
    private let checkBoxSecondControl = CheckTextControl<CheckBox>(checkControl: CheckBox())
    private var scheme = CheckBoxesCellViewCustomScheme() {
        didSet { updateScheme() }
    }
    
    // MARK: - Initializer
    
    init(
        textCheckboxTitle: String,
        checkBoxesControlState: CheckControlState,
        isSelected: Bool,
        titleText: String
    ) {
        super.init(frame: .zero)
        
        titleLabel.text = titleText
        checkBoxFirstControl.text = nil
        checkBoxFirstControl.isSelected = isSelected
        checkBoxFirstControl.checkState = checkBoxesControlState
        checkBoxFirstControl.addTarget(self, action: #selector(changeCheckBox(_:)), for: .touchUpInside)
        
        checkBoxSecondControl.text = textCheckboxTitle
        checkBoxSecondControl.isSelected = isSelected
        checkBoxSecondControl.checkState = checkBoxesControlState
        checkBoxSecondControl.addTarget(self, action: #selector(changeCheckBox(_:)), for: .touchUpInside)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - AnyAppThemable
    
    func apply(theme: AppTheme) {
        checkBoxFirstControl.apply(theme: theme)
        checkBoxSecondControl.apply(theme: theme)
        scheme = CheckBoxesCellViewCustomScheme(theme: theme)
    }
    
    // MARK: - Private Methods
    
    private func commonInit() {
        addSubviews()
        configureLabel()
        setupConstraits()
    }
    
    private func addSubviews() {
        [titleLabel,
         checkBoxFirstControl,
         checkBoxSecondControl].forEach({
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
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: LayoutGrid.doubleModule),
            
            checkBoxFirstControl.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: LayoutGrid.doubleModule),
            checkBoxFirstControl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutGrid.doubleModule),
            
            checkBoxSecondControl.topAnchor.constraint(equalTo: checkBoxFirstControl.bottomAnchor, constant: LayoutGrid.halfModule * 5),
            checkBoxSecondControl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutGrid.doubleModule),
            checkBoxSecondControl.bottomAnchor.constraint(equalTo: bottomAnchor)
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
    
    @objc private func changeCheckBox(_ checkBox: UIControl) {
        checkBox.isSelected = !checkBox.isSelected
    }
    
}
