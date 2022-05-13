//
//  InformersAndToastsViewController.swift
//  ExampleiOS
//
//  Created on 24.12.2021.
//

import AdmiralUIKit
import UIKit

final class InformersAndToastsViewController: BaseTableViewController {

    // MARK: - Private properties

    private let viewModel = InformersAndToastViewModel()

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

private extension InformersAndToastsViewController {

    func presentVC(item: InformersAndToastViewModel.Items, title: String) {
        var vc: UIViewController
        switch item {
        case .informers:
            vc = InformersViewController()
        case .notifications:
            vc = NotificationsViewController()
        }
        vc.title = title
        navigationController?.pushViewController(vc, animated: true)
    }

}
