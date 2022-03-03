//
//  RadioControlsCellView.swift
//  ExampleiOS
//
//  Created on 02.02.2021.
//

import AdmiralUIKit
import AdmiralTheme
import UIKit
 
final class RadioControlsCellView: UIView, AnyAppThemable, AccessibilitySupport {
    
    // MARK: - Public Properties
    
    var isEnabled: Bool = true {
        didSet {
            radioFirstControl.isEnabled = isEnabled
            radioSecondControl.isEnabled = isEnabled
        }
    }
    
    // MARK: - AccessibilitySupport
    
    var adjustsFontForContentSizeCategory: Bool = Appearance.isAccessabilitySupportEnabled {
        didSet { updateSchemeFonts() }
    }
    
    // MARK: - Private Properties
    
    private let titleLabel = UILabel()
    private let radioFirstControl = CheckTextControl<RadioControl>(checkControl: RadioControl())
    private let radioSecondControl = CheckTextControl<RadioControl>(checkControl: RadioControl())
    private var scheme = RadioControlsCellViewCustomScheme() {
        didSet { updateScheme() }
    }
    
    // MARK: - Initializer

    init(textCheckboxTitle: String, checkBoxesControlState: CheckControlState, isSelected: Bool, titleText: String) {
        super.init(frame: .zero)
        
        titleLabel.text = titleText
        radioFirstControl.text = nil
        radioFirstControl.isSelected = isSelected
        radioFirstControl.checkState = checkBoxesControlState
        radioFirstControl.addTarget(self, action: #selector(changeCheckBox(_:)), for: .touchUpInside)

        radioSecondControl.text = textCheckboxTitle
        radioSecondControl.isSelected = isSelected
        radioSecondControl.checkState = checkBoxesControlState
        radioSecondControl.addTarget(self, action: #selector(changeCheckBox(_:)), for: .touchUpInside)

        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - AnyAppThemable
    
    func apply(theme: AppTheme) {
        radioFirstControl.apply(theme: theme)
        radioSecondControl.apply(theme: theme)
        scheme = RadioControlsCellViewCustomScheme(theme: theme)
    }
    
    // MARK: - Private Methods
    
    private func commonInit() {
        addSubviews()
        configureLabel()
        setupConstraits()
    }
    
    private func addSubviews() {
        [titleLabel,
         radioFirstControl,
         radioSecondControl].forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        })
    }
    
    private func configureCheckBox(
        _ view: CheckTextControl<CheckBox>,
        title: String?,
        isSelected: Bool,
        state: CheckControlState) {
        
        view.text = title
        view.checkState = state
        view.isSelected = isSelected
        view.addTarget(self, action: #selector(changeCheckBox(_:)), for: .touchUpInside)
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
            
            radioFirstControl.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: LayoutGrid.doubleModule),
            radioFirstControl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutGrid.doubleModule),
            
            radioSecondControl.topAnchor.constraint(equalTo: radioFirstControl.bottomAnchor, constant: LayoutGrid.halfModule * 5),
            radioSecondControl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutGrid.doubleModule),
            radioSecondControl.bottomAnchor.constraint(equalTo: bottomAnchor)
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
    
    @objc private func changeCheckBox(_ radioButton: UIControl) {
        [radioFirstControl, radioSecondControl].forEach({ $0.isSelected = false })
        radioButton.isSelected = true
    }
    
}
