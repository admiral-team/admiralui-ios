//
//  ControlCellView.swift
//  ExampleiOS
//
//  Created on 11.11.2020.
//

import UIKit
import AdmiralUIKit
import AdmiralTheme

final class ControlCellView<T>: UIView, AnyAppThemable where T: UIView {

    // MARK: - Public Properties
    
    let textField: T
    var changeStateAction: ((TextInputState) -> Void)?
    
    // MARK: - AccessibilitySupport
    
    var adjustsFontForContentSizeCategory: Bool = Appearance.isAccessabilitySupportEnabled {
        didSet { updateSchemeFonts() }
    }
    
    // MARK: - Private Properties
    
    private let statuses: [String]
    private let segmentControl = StandardSegmentedControl(frame: .zero)
    private let titleLabel = UILabel()
    private lazy var titleLabelTopConstraint: NSLayoutConstraint = {
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: LayoutGrid.halfModule * 7)
    }()
    private var scheme = TextFieldsTextViewCustomScheme() {
        didSet { updateScheme() }
    }
    
    // MARK: - Initializer

    init(textField: T, titleText: String = "", statuses: [String] = []) {
        self.textField = textField
        self.statuses = statuses
        self.titleLabel.text = titleText
        super.init(frame: .zero)
        self.titleLabelTopConstraint.constant = titleText.isEmpty ? 0 : LayoutGrid.halfModule * 7
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - AnyAppThemable
    
    func apply(theme: AppTheme) {
        scheme = TextFieldsTextViewCustomScheme(theme: theme)
        segmentControl.apply(theme: theme)
        (textField as? AppThemeCompatible)?.apply(theme: theme)
    }
    
    private func commonInit() {
        apply(theme: Appearance.shared.theme)
        
        addSubviews()
        configureLayout()
        configureUI()
    }
    
    private func addSubviews() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(textField)
        
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        addSubview(segmentControl)
    }
    
    private func configureLabel() {
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 1
    }
    
    private func configureLayout() {
        if statuses.isEmpty {
            configureTitleLableLayout()
            configureWithoutSegmentControl()
        } else {
            configureTitleLableLayout()
            configureTextFieldLayout()
            configureSegmentControlLayout()
        }
    }
    
    private func configureTitleLableLayout() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutGrid.doubleModule),
            trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: LayoutGrid.doubleModule),
            titleLabelTopConstraint
        ])
    }
    
    private func configureSegmentControlLayout() {
        let top = segmentControl.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: LayoutGrid.tripleModule)
        let leading = segmentControl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutGrid.doubleModule)
        let trailing = trailingAnchor.constraint(equalTo: segmentControl.trailingAnchor, constant: LayoutGrid.doubleModule)
        
        NSLayoutConstraint.activate([top, leading, trailing])
    }
    
    private func configureTextFieldLayout() {
        let top = textField.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: LayoutGrid.tripleModule)
        let leading = textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutGrid.doubleModule)
        let trailing = trailingAnchor.constraint(equalTo: textField.trailingAnchor, constant: LayoutGrid.doubleModule)
        let bottom = bottomAnchor.constraint(equalTo: textField.bottomAnchor, constant: LayoutGrid.module)
        
        NSLayoutConstraint.activate([top, bottom, leading, trailing])
    }
    
    private func configureWithoutSegmentControl() {
        let top = textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: LayoutGrid.tripleModule)
        let leading = textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutGrid.doubleModule)
        let trailing = trailingAnchor.constraint(equalTo: textField.trailingAnchor, constant: LayoutGrid.doubleModule)
        let bottom = bottomAnchor.constraint(equalTo: textField.bottomAnchor, constant: LayoutGrid.module)
        
        NSLayoutConstraint.activate([top, bottom, leading, trailing])
    }
    
    private func configureUI() {
        if statuses.isEmpty {
            segmentControl.isHidden = true
        } else {
            for index in 0..<statuses.count {
                let status = statuses[index]
                segmentControl.insertTitle(status, forSegmentAt: index)
            }
            segmentControl.selectedSegmentIndex = 0
            
            segmentControl.addTarget(self, action: #selector(segmentedValueChanged(_:)), for: .valueChanged)
        }
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
    
    @objc private func segmentedValueChanged(_ control: StandardSegmentedControl) {
       guard let state = TextInputState(rawValue: control.selectedSegmentIndex) else {
            return
        }
        changeStateAction?(state)
    }

}
