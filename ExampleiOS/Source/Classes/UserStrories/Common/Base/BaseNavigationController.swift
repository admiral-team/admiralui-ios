//
//  BaseNavigationController.swift
//  ExampleiOS
//
//  Created on 22.01.2021.
//

import AdmiralUIKit
import AdmiralTheme
import UIKit

class BaseNavigationController: UINavigationController, AppThemeable {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        switch Appearance.shared.theme.colors.style {
        case .light:
            if #available(iOS 13.0, *) {
                return .darkContent
            } else {
                return .default
            }
        case .dark:
            return .lightContent
        }
    }
    
    private var isInitialized: Bool = false
    
    // MARK: - Initializers
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        commonInit()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    // MARK: - Private Methodss
    
    private func commonInit() {
        // WORKAROUND: Before iOS 13 init(rootViewController:)
        // calls init(nibName nibNameOrNil:, bundle:) and after - No
        // This check prevents calling common init twice
        guard !isInitialized else { return }
        isInitialized = true
        
        autoManage()
        
        navigationBar.isTranslucent = false
        navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationBar.shadowImage = UIImage()
    }
    
    // MARK: - AppThemeable
    
    func apply(theme: AppTheme) {
        navigationBar.tintColor = theme.colors.backgroundAccent.uiColor
        navigationBar.barTintColor = theme.colors.backgroundBasic.uiColor
        navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: theme.fonts.subtitle2.uiFont,
            NSAttributedString.Key.foregroundColor: theme.colors.textPrimary.uiColor]
        setNeedsStatusBarAppearanceUpdate()
        
        // WORKAROUND: when switching from swiftui, color the navigation bar did not change
        if #available(iOS 13.0, *) {
            let coloredAppearance = UINavigationBarAppearance()
            coloredAppearance.configureWithTransparentBackground()
            coloredAppearance.backgroundColor = theme.colors.backgroundBasic.uiColor
            coloredAppearance.titleTextAttributes = [.foregroundColor: theme.colors.textPrimary.uiColor]
            coloredAppearance.largeTitleTextAttributes = [.foregroundColor: theme.colors.textPrimary.uiColor]

            UINavigationBar.appearance().standardAppearance = coloredAppearance
            UINavigationBar.appearance().compactAppearance = coloredAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
        }
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        viewController.navigationItem.backBarButtonItem = UIBarButtonItem(
            title: nil,
            style: .plain,
            target: nil,
            action: nil)
        super.pushViewController(viewController, animated: animated)
    }

}
