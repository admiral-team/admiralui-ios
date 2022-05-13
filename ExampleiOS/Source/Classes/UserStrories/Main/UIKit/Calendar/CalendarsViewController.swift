//
//  CalendarsViewController.swift
//  ExampleiOS
//
//  Created on 11.11.2021.
//

import AdmiralUIKit
import UIKit

final class CalendarsViewController: BaseTableViewController {

    // MARK: - Private properties

    private let viewModel = CalendarsViewModel()

    // MARK: - Initializer

    override func viewDidLoad() {
        setSegmentControl(hidden: true)

        super.viewDidLoad()
        tableView.separatorStyle = .none
        tableViewManager.sections = createSections()
    }

    // MARK: - Private Methods

    private func createSections() -> [MainSectionViewModel] {
        let items = CalendarsViewModel.CalendarsItem.allCases.map { item -> MainTitleTableViewCellViewModel in
            let title = item.title
            return MainTitleTableViewCellViewModel(
                title: title,
                didSelect: { [weak self] in self?.presentVC(item: item, title: title) }
            )
        }
        return [MainSectionViewModel(items: items)]
    }

}

private extension CalendarsViewController {

    func presentVC(item: CalendarsViewModel.CalendarsItem, title: String) {
        var vc: UIViewController
        switch item {
        case .horizontal:
            vc = HorizontalViewController()
        case .vertical:
            vc = VerticalCalendarViewController()
        }
        vc.title = title
        navigationController?.pushViewController(vc, animated: true)
    }

}
