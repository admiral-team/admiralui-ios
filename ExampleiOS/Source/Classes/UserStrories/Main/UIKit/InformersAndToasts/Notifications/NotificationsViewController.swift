//
//  NotificationsViewController.swift
//  ExampleiOS
//
//  Created on 23.12.2021.
//

import AdmiralUIKit
import UIKit

final class NotificationsViewController: BaseTableViewController {

    // MARK: - Private properties

    private let viewModel = NotificationViewModel()

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

private extension NotificationsViewController {

    func presentVC(item: NotificationViewModel.Items, title: String) {
        var vc: UIViewController
        switch item {
        case .action:
            vc = ActionNotificationViewController()
        case .notifications:
            vc = StaticNotificationsViewController()
        case .toast:
            vc = ToastNotificationsViewController()
        }
        vc.title = title
        navigationController?.pushViewController(vc, animated: true)
    }

}
