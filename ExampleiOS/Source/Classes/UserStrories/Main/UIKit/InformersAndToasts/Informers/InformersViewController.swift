//
//  InformersViewController.swift
//  ExampleiOS
//
//  Created on 23.11.2020.
//

import AdmiralUIKit
import UIKit

final class InformersViewController: BaseTableViewController {

    // MARK: - Private properties

    private let viewModel = InformersViewModel()

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

private extension InformersViewController {

    func presentVC(item: InformersViewModel.Items, title: String) {
        var vc: UIViewController
        switch item {
        case .big:
            vc = BigInformersController()
        case .small:
            vc = SmallInformersViewController()
        }
        vc.title = title
        navigationController?.pushViewController(vc, animated: true)
    }

}
