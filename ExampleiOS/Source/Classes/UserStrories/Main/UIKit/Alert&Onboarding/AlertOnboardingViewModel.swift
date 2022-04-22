//
//  AlertOnboardingViewModel.swift
//  ExampleiOS
//
//  Created on 16.02.2022.
//
// swiftlint:disable all

import Foundation

final class AlertOnboardingViewModel {

    enum Items: CaseIterable {
        case alert
        case onboarding
        case zeroScreen
        case error

        func getTitle() -> String {
            switch self {
            case .alert:
                return "Alert"
            case .error:
                return "Error View"
            case .onboarding:
                return "Onboarding"
            case .zeroScreen:
                return "Zeroscreen"
            }
        }
    }

    // MARK: - Internal properties

    var items: [Items] {
        Items.allCases
    }
    
    let onBoardingModel = [OnboardingPageModel(
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

}
