//
//  ActionNotificationController.swift
//  ExampleiOS
//
//  Created on 28.12.2021.
//

import AdmiralUIKit
import AdmiralCore
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
        // swiftlint:disable line_length
        textLabel.text = "Компонент используется для отмены совершенного действия, появляется внизу экрана поверх контента с обратным отсчетом времени в 5 секунд сразу после совершения какого-либо действия."
    }
    
    private func setLinkControl() {
        linkControl.title = "Показать Action"
        linkControl.fontStyle = .body
        linkControl.style = .none
        linkControl.addTarget(self, action: #selector(tapLink), for: .touchUpInside)
    }
    
    @objc private func tapLink() {
        let view = ToastView()
        view.title = "Сообщение будет удалено"
        view.type = .default
        view.closeAction = {}
        view.closeTitle = "Отмена"
        view.timerDuration = 5
        view.closeButtonAccesibilityId = "ActionNotificationToastCloseButton"
        view.accessibilityIdentifier = "ActionNotificationToastView"
      
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
