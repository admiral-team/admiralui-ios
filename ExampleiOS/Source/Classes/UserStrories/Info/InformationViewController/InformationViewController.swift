//
//  InformationViewController.swift
//  ExampleiOS
//
//  Created on 09.03.2021.
//

import AdmiralUIKit
import AdmiralTheme
import UIKit

class InformationViewController: UIViewController, AnyAppThemable, AccessibilitySupport {
    
    // MARK: - AccessibilitySupport
    
    var adjustsFontForContentSizeCategory: Bool = Appearance.isAccessabilitySupportEnabled {
        didSet { updateSchemeFonts() }
    }
    
    // MARK: - Private Propeties
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let titleLabel = UILabel()
    private let contentView = UIView()
    private var scheme = InformationViewControllerCustomScheme() {
        didSet { updateScheme() }
    }
    // MARK: - Pulic Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
    }
    
    // MARK: - AnyAppThemable
    
    func apply(theme: AppTheme) {
        scheme = InformationViewControllerCustomScheme(theme: theme)
    }
    
    // MARK: - Private Methods
    
    private func configureLayout() {
        autoManage()
        
        addSubviews()
        setupConstraints()
        setupLabels()
    }
    
    private func addSubviews() {
        [scrollView,
         contentView,
         titleLabel].forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
         })
    }
    
    private func setupLabels() {
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .left
        
        // swiftlint:disable line_length
        titleLabel.text = "Данное приложение служит удобным инструментом для всех участников команд банка .\n\nЕсть возможность протестировать все компоненты общебанковской мобильной дизайн-системы в живую взаимодействуя с ними.\n\nКроме состояний и работы компонентов вы сможете увидеть уже готовые темы, а также создать собственную. "
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: LayoutGrid.doubleModule),
            titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -LayoutGrid.doubleModule),
            titleLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -LayoutGrid.doubleModule),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: LayoutGrid.halfModule * 5)
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
        scrollView.backgroundColor = scheme.backgroundColor.uiColor
        view.backgroundColor = scheme.backgroundColor.uiColor
        titleLabel.textColor = scheme.titleLabelTextColor.uiColor
    }
    
}
