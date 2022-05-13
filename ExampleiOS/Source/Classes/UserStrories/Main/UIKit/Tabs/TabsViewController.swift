//
//  TabsViewController.swift
//  ExampleiOS
//
//  Created on 10.02.2021.
//

import AdmiralUIKit
import UIKit

final class TabsViewController: BaseTableViewController {

    // MARK: - Private properties

    private let viewModel = TabsViewModel()

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

private extension TabsViewController {

    func presentVC(item: TabsViewModel.Items, title: String) {
        var vc: UIViewController
        switch item {
        case .standart:
            vc = StandardTabsViewController()
        case .logo:
            vc = LogoTabsViewController()
        case .informer:
            vc = InformerTabViewController()
        case .outline:
            vc = OutlineSliderTabsViewController()
        case .underline:
            vc = UnderlineSliderTabsViewController()
        case .icon:
            vc = IconTabsViewController()
        }
        vc.title = title
        navigationController?.pushViewController(vc, animated: true)
    }

}
