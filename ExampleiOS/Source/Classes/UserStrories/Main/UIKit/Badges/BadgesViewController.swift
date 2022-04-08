//
//  BadgesVC.swift
//  ExampleiOS
//
//  Created on 04.04.2022.
//

import AdmiralUIKit
import UIKit

final class BadgesViewController: BaseTableViewController {

    // MARK: - Private properties

    private let viewModel = BadgesViewModel()

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
                didSelect: { [weak self] in self?.presentVC(item: item, title: item.getTitle()) }
            )
        }
        return [MainSectionViewModel(items: items)]
    }

}

private extension BadgesViewController {

    func presentVC(item: BadgesViewModel.Items, title: String) {
        var vc: UIViewController
        switch item {
        case .small:
            vc = BadgesSmallViewContoller()
        case .normal:
            vc = BadgesNormalViewContoller()
        }
        vc.title = title
        navigationController?.pushViewController(vc, animated: true)
    }

}
