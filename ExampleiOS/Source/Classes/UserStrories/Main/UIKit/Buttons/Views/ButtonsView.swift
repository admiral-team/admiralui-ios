//
//  SmallButtonView.swift
//  ExampleiOS
//
//  Created on 16.02.2021.
//

import AdmiralUIKit
import AdmiralTheme
import UIKit

final class ButtonsView: UIView, AnyAppThemable, AccessibilitySupport {
    
    typealias ButtonViews = AppThemeCompatible & UIView
    
    // MARK: - Public Properties
    
    var buttonViews = [ButtonViews]()
    var scheme = ButtonsViewCustomScheme() {
        didSet { updateScheme() }
    }
    
    // MARK: - AccessibilitySupport
    
    var adjustsFontForContentSizeCategory: Bool = Appearance.isAccessabilitySupportEnabled {
        didSet { updateSchemeFonts() }
    }
    
    // MARK: - Private Properties

    private let titleLabel = UILabel()
    private var stackView = UIStackView()
    
    // MARK: - Initializer

    init(buttonViews: [ButtonViews], title: String) {
        titleLabel.text = title
        self.buttonViews = buttonViews
        super.init(frame: .zero)
        
        commonInit()
        buttonViews.forEach({
            stackView.addArrangedSubview($0)
        })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - AnyAppThemable
    
    func apply(theme: AppTheme) {
        scheme = ButtonsViewCustomScheme(theme: theme)
        buttonViews.forEach({ $0.apply(theme: theme) })
    }
    
    // MARK: - Private Methods
    
    private func commonInit() {
        addSubviews()
        configureLabel()
        configureStackView()
        setupConstraits()
    }
    
    private func addSubviews() {
        [titleLabel,
         stackView].forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        })
    }

    private func configureLabel() {
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 1
    }
    
    private func configureStackView() {
        stackView.axis = .vertical
        stackView.spacing = LayoutGrid.halfModule * 6
    }
    
    private func setupConstraits() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutGrid.doubleModule),
            trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: LayoutGrid.doubleModule),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: LayoutGrid.halfModule * 7),
            
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: LayoutGrid.doubleModule * 2),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: LayoutGrid.doubleModule),
            trailingAnchor.constraint(equalTo: stackView.trailingAnchor)
        ])
    }
    
    private func updateScheme() {
        updateSchemeFonts()
        updateSchemeColors()
    }
    
    private func updateSchemeFonts() {
        titleLabel.setDynamicFont(
            font: scheme.titleFont.uiFont,
            textStyle: scheme.titleFont.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory)
    }
    
    private func updateSchemeColors() {
        backgroundColor = scheme.backgroundColor.uiColor
        titleLabel.textColor = scheme.textColor.uiColor
    }
    
}
