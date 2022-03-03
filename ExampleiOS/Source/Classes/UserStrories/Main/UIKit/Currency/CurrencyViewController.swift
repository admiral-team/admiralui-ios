//
//  CurrencyViewController.swift
//  ExampleiOS
//
//  Created on 24.02.2022.
//

import AdmiralUIKit
import UIKit

final class CurrencyViewController: BaseTableViewController {

    // MARK: - Private properties

    private let viewModel = CurrencyViewModel()

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

private extension CurrencyViewController {

    func presentVC(item: CurrencyViewModel.Items, title: String) {
        var vc: UIViewController
        switch item {
        case .icons:
            vc = IconsCurrencyViewController()
        case .default:
            vc = DefaultCurrencyViewController()
        case .flags:
            vc = FlagsCurrencyViewController()
        case .iconsAndFlags:
            vc = IconsFlagsCurrencyViewController()
        }
        vc.title = title
        navigationController?.pushViewController(vc, animated: true)
    }

}
