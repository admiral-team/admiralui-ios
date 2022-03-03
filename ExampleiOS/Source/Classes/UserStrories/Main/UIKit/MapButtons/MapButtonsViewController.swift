//
//  MapButtonsViewController.swift
//  ExampleiOS
//
//  Created on 18.02.2022.
//

import AdmiralUIKit
import UIKit

final class MapButtonsViewController: BaseTableViewController {

    // MARK: - Private properties

    private let viewModel = MapButtonsViewModel()

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

private extension MapButtonsViewController {

    func presentVC(item: MapButtonsViewModel.Items, title: String) {
        var vc: UIViewController
        switch item {
        case .list:
            vc = MapButtonsListViewController()
        }
        vc.title = title
        navigationController?.pushViewController(vc, animated: true)
    }

}
