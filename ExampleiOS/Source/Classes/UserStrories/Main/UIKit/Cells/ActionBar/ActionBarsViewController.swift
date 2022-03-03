//
//  ActionBarsViewController.swift
//  ExampleiOS
//
//  Created on 07.02.2022.
//

import AdmiralUIKit
import UIKit

final class ActionBarsViewController: BaseTableViewController {

    // MARK: - Private properties

    private let viewModel = ActionBarsViewModel()

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

private extension ActionBarsViewController {

    func presentVC(item: ActionBarsViewModel.Items, title: String) {
        var vc: UIViewController
        switch item {
        case .default:
            vc = ActionBarViewControllerDefault()
        case .secondary:
            vc = ActionBarViewControllerSecondary()
        }
        vc.title = title
        navigationController?.pushViewController(vc, animated: true)
    }

}
