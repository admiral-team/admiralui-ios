//
//  AlertOnboardingViewController.swift
//  ExampleiOS
//
//  Created on 16.02.2022.
//

import AdmiralUIKit
import UIKit

// swiftlint:disable all
final class AlertOnboardingViewController: BaseTableViewController {

    // MARK: - Private properties
    
    private let viewModel = AlertOnboardingViewModel()
    private let onBoardingModel = [OnboardingPageModel(
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
    // MARK: - Initializer

    override func viewDidLoad() {
        setSegmentControl(hidden: true)

        super.viewDidLoad()
        tableView.separatorStyle = .none
        tableViewManager.sections = createSections()
    }

    // MARK: - Private Methods

    private func createSections() -> [MainSectionViewModel] {
        let items = viewModel.items.map { item -> MainTitleTableViewCellViewModel in
            let title = item.getTitle()
            return MainTitleTableViewCellViewModel(
                title: title,
                didSelect: { [weak self] in self?.presentVC(item: item, title: title) }
            )
        }
        return [MainSectionViewModel(items: items)]
    }

}

private extension AlertOnboardingViewController {

    func presentVC(item: AlertOnboardingViewModel.Items, title: String) {
        var vc: UIViewController
        switch item {
        case .alert:
            vc = AlertController()
        case .error:
            vc = ErrorViewController()
        case .onboarding:
            let onboarding = OnboardingPageViewController()
            onboarding.onboardingPageModels = onBoardingModel
            onboarding.isOnboardingRoot = false
            vc = onboarding
        case .zeroScreen:
            vc = ZeroScreenViewController()
        }
        vc.title = title
        navigationController?.pushViewController(vc, animated: true)
    }

}
