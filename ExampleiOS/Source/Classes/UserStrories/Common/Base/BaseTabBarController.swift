//
//  BaseTabBarController.swift
//  ExampleiOS
//
//  Created on 22.01.2021.
//

import AdmiralUIKit
import AdmiralTheme
import AdmiralUIResources
import UIKit

class BaseTabBarController: UITabBarController, AppThemeable {
    
    // MARK: - Private Properties
    
    private enum Constants {
        static let mainTabBarNavTitle: String = "Дизайн-система  «Адмирал»"
        static let mainTabBarTitle: String = "Главная"
        static let infoTitle: String = "Инфо"
        static let chatTitle: String = "Чат"
        static let settingsTitle: String = "Настройки"
    }
    
    // MARK: - Initializers
    
    init() {
        super.init(nibName: nil, bundle: nil)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    // MARK: - Internal Methods
    
    func prepareSwiftUIController() -> UIViewController {
        tabBar.isTranslucent = true
        tabBar.backgroundImage = UIImage()
        if #available(iOS 14.0.0, *) {
            let mainVC = SwiftUIController()
            mainVC.tabBarItem = UITabBarItem(
                title: Constants.mainTabBarTitle,
                image: AdmiralUIResources.Asset.System.Solid.starSolid.image,
                tag: 0)
            mainVC.tabBarItem.accessibilityIdentifier = "MainTabBarItem"
            return mainVC
        } else {
            return UINavigationController()
        }
    }
    
    func prepareUIKitController() -> UINavigationController {
        tabBar.isTranslucent = false
        tabBar.backgroundImage = nil
        let mainVC = MainViewController()
        mainVC.navigationItem.title = Constants.mainTabBarNavTitle
        mainVC.tabBarItem = UITabBarItem(
            title: Constants.mainTabBarTitle,
            image: AdmiralUIResources.Asset.System.Solid.starSolid.image,
            tag: 0)
        mainVC.tabBarItem.accessibilityIdentifier = "MainTabBarItem"
        return BaseNavigationController(rootViewController: mainVC)
    }
    
    func prepareUIKitChatController() -> UINavigationController {
        let chatVC = ChatViewController()
        chatVC.navigationItem.title = "Chat"
        chatVC.tabBarItem = UITabBarItem(
            title: Constants.chatTitle,
            image: AdmiralUIResources.Asset.Category.Solid.chatSolid.image,
            tag: 2)
        chatVC.tabBarItem.accessibilityIdentifier = "ChatTabBarItem"
        return BaseNavigationController(rootViewController: chatVC)
    }
    
    func prepareSwiftUIChatController() -> UIViewController {
        tabBar.isTranslucent = true
        tabBar.backgroundImage = UIImage()
        if #available(iOS 14.0.0, *) {
            let chatVC = SwiftUIChatViewController()
            chatVC.tabBarItem = UITabBarItem(
                title: Constants.chatTitle,
                image: AdmiralUIResources.Asset.Category.Solid.chatSolid.image,
                tag: 0)
            chatVC.tabBarItem.accessibilityIdentifier = "ChatTabBarItem"
            return chatVC
        } else {
            return UINavigationController()
        }
    }
    
    // MARK: - AppThemeable
    
    func apply(theme: AppTheme) {
        tabBar.backgroundColor = theme.colors.backgroundAccentDark.uiColor
        tabBar.tintColor = theme.colors.elementAccent.uiColor
        tabBar.barTintColor = theme.colors.backgroundAccentDark.uiColor
        tabBar.unselectedItemTintColor = theme.colors.elementContrast.uiColor
        tabBarItem.setTitleTextAttributes([NSAttributedString.Key.font: theme.fonts.caption2.uiFont], for: [])
    }
    
    // MARK: - Private Methodss
    
    private func commonInit() {
        autoManage()
        let isSwiftUIOn = UserDefaults.standard.bool(forKey: UserDefaults.Keys.isSwiftUIOn)
        isSwiftUIOn ? setSwiftUITabs() : setUIKitTabs()
    }
    
    private func prepareInfoController() -> UINavigationController {
        let infoVC = InfoViewController()
        infoVC.navigationItem.title = Constants.infoTitle
        infoVC.tabBarItem = UITabBarItem(
            title: Constants.infoTitle,
            image: AdmiralUIResources.Asset.Category.Solid.mobileSolid.image,
            tag: 1)
        infoVC.tabBarItem.accessibilityIdentifier = "InfoTabBarItem"
        return BaseNavigationController(rootViewController: infoVC)
    }
    
    private func prepareSetingsController() -> UINavigationController {
        let settingsVC = SettingsViewController()
        settingsVC.navigationItem.title = Constants.settingsTitle
        settingsVC.tabBarItem = UITabBarItem(
            title: Constants.settingsTitle,
            image: Asset.TabBar.settings.image,
            tag: 3)
        settingsVC.tabBarItem.accessibilityIdentifier = "SeatingTabBarItem"
        return BaseNavigationController(rootViewController: settingsVC)
    }
    
    private func setUIKitTabs() {
        var controllers = [UINavigationController]()
        controllers.append(prepareUIKitController())
        controllers.append(prepareInfoController())
        controllers.append(prepareUIKitChatController())
        controllers.append(prepareSetingsController())
        
        setViewControllers(controllers, animated: false)
        selectedIndex = 0
    }
    
    private func setSwiftUITabs() {
        var controllers = [UIViewController]()
        controllers.append(prepareSwiftUIController())
        controllers.append(prepareInfoController())
        controllers.append(prepareSwiftUIChatController())
        controllers.append(prepareSetingsController())
        
        setViewControllers(controllers, animated: false)
        selectedIndex = 0
    }
    
}
