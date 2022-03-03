//
//  AlertOnboardingViewController.swift
//  ExampleiOS
//
//  Created on 16.02.2022.
//

import AdmiralUIKit
import UIKit

final class AlertOnboardingViewController: BaseTableViewController {

    // MARK: - Private properties

    private let viewModel = AlertOnboardingViewModel()

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
            vc = UIViewController()
        case .zeroScreen:
            vc = ZeroScreenViewController()
        }
        vc.title = title
        navigationController?.pushViewController(vc, animated: true)
    }

}
