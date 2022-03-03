//
//  BottomSheetViewController.swift
//  ExampleiOS
//
//  Created on 17.12.2020.
//

import AdmiralUIKit
import AdmiralTheme
import UIKit

final class BottomSheetViewController: BaseViewController, AccessibilitySupport {
    
    // MARK: - AccessibilitySupport
    
    var adjustsFontForContentSizeCategory: Bool = Appearance.isAccessabilitySupportEnabled {
        didSet { updateSchemeFonts() }
    }
    
    // MARK: - Private Properties
    
    private let descriptionLabel = UILabel()
    private let bottomButton = GhostButton()
    private var scheme = BottomSheetViewControllerCustomTheme() {
        didSet { updateScheme() }
    }
    
    // MARK: - Initializers
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
    
    // MARK: - AppThemeable
    
    override func apply(theme: AppTheme) {
        super.apply(theme: theme)
        bottomButton.apply(theme: theme)
        scheme = BottomSheetViewControllerCustomTheme(theme: theme)
    }
    
    // MARK: - Private Methods
    
    private func commonInit() {
        autoManage()

        addSubviews()
        setupLabels()
        setupButtons()
        configureConstraints()
    }
    
    private func addSubviews() {
        [descriptionLabel,
         bottomButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
    }
    
    private func setupLabels() {
        descriptionLabel.numberOfLines = 0
        // swiftlint:disable all
        descriptionLabel.text = "Всплывающие окна отображаются в нижней части экрана, содержат дополнения к основному экрану и остаются видимыми, пока пользователи взаимодействуют с основным контентом.\n\nТакже являются альтернативой встроенным меню или простым диалоговым окнам на мобильных устройствах и предоставляют место для дополнительных элементов, более длинных описаний и значков.\n\nДля вызова Bottom-sheet, нажмите кнопку"
        // swiftlint:enable all
    }
    
    private func setupButtons() {
        bottomButton.setTitle("Показать Bottom-Sheet", for: [])
        bottomButton.addTarget(self, action: #selector(tapBottomButton), for: .touchUpInside)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: LayoutGrid.doubleModule),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutGrid.doubleModule),
            view.trailingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor, constant: LayoutGrid.doubleModule),
            bottomButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutGrid.doubleModule),
            view.trailingAnchor.constraint(equalTo: bottomButton.trailingAnchor, constant: LayoutGrid.doubleModule),
            bottomButton.heightAnchor.constraint(equalToConstant: LayoutGrid.module * 6),
            bottomButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: LayoutGrid.doubleModule)
        ])
    }
    
    private func updateScheme() {
        updateSchemeFonts()
        updateSchemeColors()
    }
    
    private func updateSchemeFonts() {
        descriptionLabel.setDynamicFont(
            font: scheme.descriptionLabelFont.uiFont,
            textStyle: scheme.descriptionLabelFont.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory)
    }
    
    private func updateSchemeColors() {
        descriptionLabel.textColor = scheme.descriptionLabelTextColor.uiColor
        view.backgroundColor = scheme.backgroundColor.uiColor
    }
    
    @objc private func tapBottomButton() {
        let vc = BottomSheetExampleViewController()
        vc.modalPresentationStyle = .custom
        vc.modalPresentationCapturesStatusBarAppearance = true
        vc.transitioningDelegate = BottomSheetPresentationDelegate.default
        present(vc, animated: true, completion: nil)
    }
    
}
