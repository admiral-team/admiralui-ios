//
//  CalendarsViewController.swift
//  ExampleiOS
//
//  Created on 11.11.2021.
//

import AdmiralUIKit
import UIKit

final class CalendarsViewController: BaseTableViewController {
    
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
                title: "Horizontal",
                didSelect: { [weak self] in self?.presentHorizontalCalendar() }),
            
            MainTitleTableViewCellViewModel(
                title: "Vertical",
                didSelect: { [weak self] in self?.presentVericalCalendar() })
        ]
        
        return [MainSectionViewModel(items: items)]
    }
    
    private func presentHorizontalCalendar() {
        let viewController = HorizontalViewController()
        viewController.title = "Horizontal"
        viewController.loadViewIfNeeded()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func presentVericalCalendar() {
        let viewController = VerticalCalendarViewController()
        viewController.loadViewIfNeeded()
        viewController.title = "Vertical"
        navigationController?.pushViewController(viewController, animated: true)
    }

}
