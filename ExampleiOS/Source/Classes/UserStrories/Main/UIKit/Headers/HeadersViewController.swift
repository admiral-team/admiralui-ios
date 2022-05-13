//
//  HeadersMenuController.swift
//  ExampleiOS
//
//  Created on 24.12.2020.
//

import AdmiralUIKit
import UIKit

final class HeadersViewController: BaseTableViewController {

    // MARK: - Private properties

    private let viewModel = HeadersViewModel()

    // MARK: - Initializer

    override func viewDidLoad() {
        setSegmentControl(hidden: true)

        super.viewDidLoad()
        tableView.separatorStyle = .none
        tableViewManager.sections = createSections()
    }

    // MARK: - Private Methods

    private func createSections() -> [MainSectionViewModel] {
        let items = HeadersViewModel.CalendarsItem.allCases.map { item -> MainTitleTableViewCellViewModel in
            let title = item.title
            return MainTitleTableViewCellViewModel(
                title: title,
                didSelect: { [weak self] in self?.presentVC(item: item, title: title) }
            )
        }
        return [MainSectionViewModel(items: items)]
    }

}

private extension HeadersViewController {

    func presentVC(item: HeadersViewModel.CalendarsItem, title: String) {
        var vc: UIViewController
        switch item {
        case .card:
            vc = CardViewController()
        }
        vc.title = title
        navigationController?.pushViewController(vc, animated: true)
    }

}
