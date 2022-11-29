//
//  NumberViewController.swift
//  ExampleiOS
//
//  Created on 11.11.2020.
//

import AdmiralUIKit
import UIKit

final class NumberViewController: BaseTableViewController {

    // MARK: - Life Cycle

    override func viewDidLoad() {
        setSegmentControl(hidden: true)

        super.viewDidLoad()
        tableView.separatorStyle = .none
        tableViewManager.sections = createSections()
    }

    // MARK: - Private Methods

    private func createSections() -> [MainSectionViewModel] {
        let items: [TableViewListItem] = [
            MainTitleTableViewCellViewModel(
                title: "Default",
                didSelect: { [weak self] in self?.presentDefaultNumber() }),

            MainTitleTableViewCellViewModel(
                title: "Secondary",
                didSelect: { [weak self] in self?.presentSecondaryNumber() }),

            MainTitleTableViewCellViewModel(
                title: "Input",
                didSelect: { [weak self] in self?.presentInputNumber() })
        ]

        return [MainSectionViewModel(items: items)]
    }

    private func presentDefaultNumber() {
        let viewController = InputNumberDefaultViewController()
        viewController.title = "Default"
        navigationController?.pushViewController(viewController, animated: true)
    }

    private func presentSecondaryNumber() {
        let viewController = InputNumberDefaultViewController()
        viewController.title = "Secondary"
        navigationController?.pushViewController(viewController, animated: true)
    }

    private func presentInputNumber() {
        let viewController = InputNumberViewController()
        viewController.title = "Input"
        navigationController?.pushViewController(viewController, animated: true)
    }
}
