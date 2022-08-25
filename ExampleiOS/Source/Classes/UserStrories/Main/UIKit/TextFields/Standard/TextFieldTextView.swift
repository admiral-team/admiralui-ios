//
//  TextFieldTextView.swift
//  ExampleiOS
//
//  Created on 19.02.2021.
//

import AdmiralUIKit
import AdmiralTheme
import UIKit

enum TextFieldTextViewState {
    case `default`
    case crediCard
}

final class TextFieldTextView: UIView, AnyAppThemable, AccessibilitySupport {
    
    // MARK: - Public Properties
    
    var state: TextInputState = .normal {
        didSet {
            (textField as? TextField)?.state = state
            (textField as? SecureTextField)?.state = state
            (textField as? OTPTextField)?.state = state
            (textField as? CardTextField)?.state = state
            (textField as? DoubleTextField)?.firstTextField.state = state
            (textField as? DoubleTextField)?.secondTextField.state = state
            (textField as? TextView)?.state = state
        }
    }
    
    // MARK: - AccessibilitySupport
    
    var adjustsFontForContentSizeCategory: Bool = Appearance.shared.isAccessabilitySupportEnabled {
        didSet { updateSchemeFonts() }
    }
    
    // MARK: - Private Properties
    
    private let titleLabel = UILabel()
    private let textField: UIView
    private lazy var titleLabelTopConstraint: NSLayoutConstraint = {
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: LayoutGrid.halfModule * 7)
    }()
    private var textFieldSideOffset = LayoutGrid.doubleModule
    private var scheme = TextFieldsTextViewCustomScheme() {
        didSet { updateScheme() }
    }
    
    // MARK: - Initializer

    init(textField: UIView, titleText: String, state: TextFieldTextViewState = .default) {
        self.textField = textField
        super.init(frame: .zero)
        
        switch state {
        case .crediCard:
            textFieldSideOffset = LayoutGrid.module * 5
        default:
            textFieldSideOffset = LayoutGrid.doubleModule
        }
        
        titleLabel.text = titleText
        titleLabelTopConstraint.constant = titleText.isEmpty ? 0 : LayoutGrid.halfModule * 7
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - AnyAppThemable
    
    func apply(theme: AppTheme) {
        scheme = TextFieldsTextViewCustomScheme(theme: theme)
        (textField as? AppThemeCompatible)?.apply(theme: theme)
    }
    
    // MARK: - Private Methods
    
    private func commonInit() {
        autoManage()
        
        addSubviews()
        configureLabel()
        setupConstraits()
    }
    
    private func addSubviews() {
        [titleLabel,
         textField].forEach({
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
            titleLabelTopConstraint,
            
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: LayoutGrid.quadrupleModule),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: textFieldSideOffset),
            bottomAnchor.constraint(equalTo: textField.bottomAnchor, constant: LayoutGrid.halfModule * 7),
            trailingAnchor.constraint(equalTo: textField.trailingAnchor, constant: textFieldSideOffset)
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
