//
//  PageControlsViewController.swift
//  ExampleiOS
//
//  Created on 21.01.2021.
//

import AdmiralUIKit
import UIKit

final class PageControlsViewController: BaseTableViewController {

    // MARK: - Private properties

    private let viewModel = PageControlsViewModel()

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

private extension PageControlsViewController {

    func presentVC(item: PageControlsViewModel.Items, title: String) {
        var vc: UIViewController
        switch item {
        case .circle:
            vc = CircularPageControlViewController()
        case .linear:
            vc = LinerPageControl()
        }
        vc.title = title
        navigationController?.pushViewController(vc, animated: true)
    }

}
