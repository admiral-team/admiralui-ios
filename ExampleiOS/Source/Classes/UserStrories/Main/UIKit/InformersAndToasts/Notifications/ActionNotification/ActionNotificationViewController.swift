//
//  ActionNotificationController.swift
//  ExampleiOS
//
//  Created on 28.12.2021.
//

import AdmiralUIKit
import AdmiralTheme
import AdmiralUIResources
import UIKit

final class ActionNotificationViewController: BaseViewController, AccessibilitySupport {
    
    var scheme = ToastNotificationsViewScheme() {
        didSet { updateScheme() }
    }
    
    // MARK: - AccessibilitySupport
    
    var adjustsFontForContentSizeCategory: Bool = Appearance.isAccessabilitySupportEnabled {
        didSet { updateSchemeFonts() }
    }
    
    // MARK: - Private Properties
    
    private let stackPresenter = BannerNotification.defaultStackBanner()
    private let switchPresenter = BannerNotification.defaultSwitchBanner()
    private let viewModel = ActionNotificationViewModel()

    private let textLabel = UILabel()
    private let linkControl = PrimaryLinkControl()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
    
    // MARK: - AnyAppThemable
    
    override func apply(theme: AppTheme) {
        super.apply(theme: theme)
        scheme = ToastNotificationsViewScheme(theme: theme)
        linkControl.apply(theme: theme)
    }

    // MARK: - Private Methods
    
    private func commonInit() {
        addSubviews()
        setLinkControl()
        setLabel()
        configureConstraints()
    }
    
    private func addSubviews() {
        [textLabel, linkControl].addToSuperview(view)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            textLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutGrid.doubleModule),
            textLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: LayoutGrid.doubleModule),
            view.trailingAnchor.constraint(equalTo: textLabel.trailingAnchor, constant: LayoutGrid.doubleModule),
            
            linkControl.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: LayoutGrid.doubleModule),
            linkControl.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setLabel() {
        textLabel.numberOfLines = 0
        textLabel.textAlignment = .left
        textLabel.text = viewModel.text
    }
    
    private func setLinkControl() {
        linkControl.title = viewModel.title
        linkControl.fontStyle = .body
        linkControl.style = .none
        linkControl.addTarget(self, action: #selector(tapLink), for: .touchUpInside)
    }
    
    @objc private func tapLink() {
        let view = ToastView()
        view.title = viewModel.toastTitle
        view.type = .default
        view.closeAction = {}
        view.closeTitle = viewModel.closeTitle
        view.timerDuration = 5
      
        var config = BannerNotification.Config.default
        config.displayingTime = 5.0
        config.direction = .down
        
        switchPresenter.show(banner: view, config: config)
    }

    private func updateScheme() {
        updateSchemeFonts()
        updateSchemeColors()
    }
    
    private func updateSchemeFonts() {
        textLabel.setDynamicFont(
            font: scheme.titleFont.uiFont,
            textStyle: scheme.titleFont.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory)
    }
    
    private func updateSchemeColors() {
        view.backgroundColor = scheme.backgroundColor.uiColor
        textLabel.textColor = scheme.textColor.uiColor
    }
}
