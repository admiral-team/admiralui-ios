//
//  RootRouter.swift
//  ExampleiOS
//
//  Created on 09.11.2020.
//

import AdmiralUIKit
import AdmiralUIResources
import UIKit

final class RootRouter: BaseRouter {
    
    // MARK: - Internal Properties
    
    var userSettingService: UserSettingServiceProtocol = UserSettingService()
    
    // MARK: - Internal Methods
    
    func setRoot() {
        if userSettingService.isOnboardingFinish {
            showMain()
        } else {
            showOnboarding()
        }
    }
    
    // MARK: - Private Methods
    
    private func showOnboarding() {
        let onboardingPageViewController = OnboardingPageViewController()
        onboardingPageViewController.onboardingPageModels =
            [OnboardingPageModel(
                title: "Добро\nпожаловать!",
                subtitle: "Приветствуем вас в нашем мобильном приложении.  Это приложение служит удобным инструментом для всех участников команд!",
                image: Asset.Onboarding.one.image),
             OnboardingPageModel(
                title: "Что внутри приложения",
                subtitle: "В приложении есть набор всех стилей и компонентов UI kit 3.0 Mobile, который вы сможете протестировать в реальном времени.",
                image: Asset.Onboarding.two.image),
             OnboardingPageModel(
                title: "Ждем ваших\n👍🏽",
                subtitle: "Мы рады любому фидбеку и активно ведем непрерывную работу над дизайн-системой.\nВсе наши контакты находятся в разделе “Инфо”.",
                image: Asset.Onboarding.three.image)]
        
        let nc = BaseNavigationController(rootViewController: onboardingPageViewController)
        setRootViewController(viewController: nc)
    }
    
    private func showMain() {
        let tabBarController = BaseTabBarController()
        setRootViewController(viewController: tabBarController, animated: true)
    }
    
}
