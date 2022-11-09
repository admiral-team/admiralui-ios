//
//  ToastNotificationsViewController.swift
//  ExampleiOS
//
//  Created on 24.12.2021.
//

import AdmiralUIKit
import AdmiralTheme
import AdmiralUIResources
import UIKit

final class ToastNotificationsViewController: BaseViewController, AccessibilitySupport {
    
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
    private var isDefaultToast = true
    
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
        textLabel.text = "Компонент появляется в верхней части страницы на мобильных девайсах и справа в верхней части страницы на планшетах только внутри приложения, автоматически исчезает по таймауту, по свайпу вверх или по нажатию на иконку закрытия если она присутствует.\n\nКомпонентов на странице может быть несколько, если они приходят одновременно наслаиваясь друг на друга и исчезают по собственному таймауту. При тапу на группу таких уведомлений они раскрываются в список."
    }
    
    private func setLinkControl() {
        linkControl.title = "Показать Toast"
        linkControl.fontStyle = .body
        linkControl.style = .none
        linkControl.addTarget(self, action: #selector(tapLink), for: .touchUpInside)
    }
    
    @objc private func tapLink() {
        let view = ToastView()
        view.title = "At breakpoint boundaries, mini units divide the screen into a fixed master grid."
        view.linkText = "Link text"
        view.type = isDefaultToast ? .default : .error
        view.imageType = isDefaultToast ? .info : .error
        view.linkAction = {}
        view.closeAction = {}
        view.closeButtonAccesibilityId = "ToastCloseButton"
        view.accessibilityIdentifier = "ToastView"
      
        var config = BannerNotification.Config.default
        config.displayingTime = 2.0
        
        switchPresenter.show(banner: view, config: config)
        
        isDefaultToast.toggle()
        
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
