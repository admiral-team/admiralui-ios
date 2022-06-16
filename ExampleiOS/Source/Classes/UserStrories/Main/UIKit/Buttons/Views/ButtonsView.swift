//
//  SmallButtonView.swift
//  ExampleiOS
//
//  Created on 16.02.2021.
//

import AdmiralUIKit
import AdmiralTheme
import UIKit

final class ButtonsView: UIView, AnyAppThemable {
    
    typealias ButtonViews = AppThemeCompatible & UIView
    
    // MARK: - Public Properties
    
    var buttonViews = [ButtonViews]() {
        didSet { addButtonsToStack() }
    }
    var scheme = ButtonsViewCustomScheme() {
        didSet { updateScheme() }
    }
    
    // MARK: - Private Properties

    private var stackView = UIStackView()
    
    // MARK: - Initializer

    init(buttonViews: [ButtonViews]) {
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
        configureStackView()
        setupConstraits()
    }
    
    private func addSubviews() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
    }
    
    private func configureStackView() {
        stackView.axis = .vertical
        stackView.spacing = LayoutGrid.halfModule * 6
    }
    
    private func setupConstraits() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: LayoutGrid.doubleModule * 2),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: LayoutGrid.doubleModule),
            trailingAnchor.constraint(equalTo: stackView.trailingAnchor)
        ])
    }
    
    private func addButtonsToStack() {
        buttonViews.forEach({
            stackView.addArrangedSubview($0)
        })
    }
    
    private func updateScheme() {
        updateSchemeColors()
    }
    
    
    private func updateSchemeColors() {
        backgroundColor = scheme.backgroundColor.uiColor
    }
    
}
