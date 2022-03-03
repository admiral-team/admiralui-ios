//
//  InformersAndToastsViewController.swift
//  ExampleiOS
//
//  Created on 24.12.2021.
//

import AdmiralUIKit
import UIKit

final class InformersAndToastsViewController: BaseTableViewController {
    
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
                title: "Informers",
                didSelect: { [weak self] in self?.presentInformers() }),
            
            MainTitleTableViewCellViewModel(
                title: "Notifications",
                didSelect: { [weak self] in self?.presentNotifications() })
        ]
        
        return [MainSectionViewModel(items: items)]
    }
    
    private func presentInformers() {
        let viewController = InformersViewController()
        viewController.title = "Informers"
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func presentNotifications() {
        let viewController = NotificationsViewController()
        viewController.title = "Notifications"
        navigationController?.pushViewController(viewController, animated: true)
    }

}
