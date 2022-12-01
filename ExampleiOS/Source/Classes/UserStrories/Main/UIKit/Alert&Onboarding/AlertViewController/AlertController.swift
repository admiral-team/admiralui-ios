//
//  AlertMenuViewController.swift
//  ExampleiOS
//
//  Created on 09.11.2020.
//

import AdmiralUIKit
import AdmiralTheme
import UIKit

final class AlertController: BaseViewController, AccessibilitySupport {
    
    // MARK: - AccessibilitySupport
    
    var adjustsFontForContentSizeCategory: Bool = Appearance.isAccessabilitySupportEnabled {
        didSet { updateSchemeFonts() }
    }
    
    // MARK: - Private Properties
    
    private let vc = AlertViewController()
    private let showButton = GhostButton()
    private let descriptionLabel = UILabel()
    private var scheme = AlertControllerCustomScheme() {
        didSet { updateScheme() }
    }
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - AnyAppThemable
    
    override func apply(theme: AppTheme) {
        super.apply(theme: theme)
        showButton.apply(theme: theme)
        scheme = AlertControllerCustomScheme(theme: theme)
        vc.apply(theme: theme)
    }
    
    // MARK: - Private Methods
    
    private func configureUI() {
        autoManage()
        
        showButton.setTitle("Показать Alert", for: [.normal])
        showButton.addTarget(self, action: #selector(tapShowButton), for: .touchUpInside)
        
        addSubviews()
        setupLabels()
        configureConstraints()
        configureAlertController()
    }
    
    private func setupLabels() {
        descriptionLabel.numberOfLines = 0
        // swiftlint:disable all
        descriptionLabel.text = "Всплывающие окна поверх контента, часто содержат короткое информирующее сообщение, иллюстрацию и кнопки основгого или альтернативного действия.\n\nДля вызова Alert, нажмите кнопку "
        // swiftlint:enable all
    }
    
    private func configureAlertController() {
        vc.title = "Header"
        vc.message = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
        vc.image = Asset.PopUp.popUpImage.image
        vc.modalPresentationStyle = .custom
        vc.modalTransitionStyle = .crossDissolve
        let action = AlertAction(title: "Хорошо", style: .primary) { [weak self] _ in
            self?.vc.dismiss(animated: true, completion: nil)
        }
        let secondAction = AlertAction(title: "Отмена", style: .alternative) { [weak self] _ in
            self?.vc.dismiss(animated: true, completion: nil)
        }
        vc.addAction(action)
        vc.addAction(secondAction)
    }
    
    @objc private func tapShowButton() {
        present(vc, animated: true, completion: nil)
    }
    
    private func addSubviews() {
        [showButton,
         descriptionLabel].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: LayoutGrid.doubleModule),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutGrid.doubleModule),
            view.trailingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor, constant: LayoutGrid.doubleModule),
            showButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutGrid.doubleModule),
            view.trailingAnchor.constraint(equalTo: showButton.trailingAnchor, constant: LayoutGrid.doubleModule),
            showButton.heightAnchor.constraint(equalToConstant: LayoutGrid.module * 6),
            showButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: LayoutGrid.doubleModule)
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
        view.backgroundColor = scheme.backgroundColor.uiColor
        descriptionLabel.textColor = scheme.descriptionLabelTextColor.uiColor
    }
    
}
